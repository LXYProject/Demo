//
//  HomeViewController.m
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerHeaderCell.h"
#import "ItemBtnCell.h"
#import "NearByServiceCell.h"
#import "SectionHeaderCell.h"
#import "ProductItemCell.h"
#import "NearByHeaderCell.h"
#import "secondHandCell.h"
#import "NearByHttpManager.h"
#import "NearByCell.h"
#import "SecondHandViewController.h"
#import "ServiceDetailsController.h"
#import "HelpDetailsController.h"
#import "CityListViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "RentHouseModel.h"
#import "HomeHttpManager.h"

#define ScrollDistance  100
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate, CityListViewDelegate>
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)NSArray *itemDataSourceArray;
@property (nonatomic,strong)NSArray *notificationNewsArray;
@property (nonatomic,assign)NSInteger nearBySelectIndex;
@property (nonatomic,strong)NSArray *imageURLArray;

//周边服务 的数据相关的
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger currentPage;

//collectView 的数据相关的
@property (nonatomic,strong)NSArray *secondCellDataSource;
@property (nonatomic,assign)NSInteger secondCellCurrentPage;

//租房查询 的数据相关的
@property (nonatomic,strong)NSArray *rentHouseDataSource;
@property (nonatomic,assign)NSInteger rentHouseCurrentPage;

@property (strong, nonatomic) CLLocationManager* locationManager;

@end

@implementation HomeViewController
{
    NSArray *imageNames;
    NSArray *noticeNews;
    NSInteger _times;
    NSString *_LocatingCity;
    
    NSString *_deviceUUID;
    NSString *_deviceModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _nearBySelectIndex = 0;
    
    self.currentPage = 1;
    self.secondCellCurrentPage = 1;
    
    // 获取设备唯一标识符和手机型号
    _deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"设备唯一码deviceUUID==%@", _deviceUUID);
    _deviceModel = [Tools deviceVersion];
    NSLog(@"手机型号deviceModel==%@", _deviceModel);

    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        if (_nearBySelectIndex==0) {
            [self requestServiceData];
        }else{
            [self requestData];
        }
        [self requestDataSecondCellData];
        [self requestRentHouseData];
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        if (_nearBySelectIndex==0) {
            [self requestServiceData];
        }else{
            [self requestData];
        }
        [self requestDataSecondCellData];
        [self requestRentHouseData];
    }];
    [self.tableView beginHeaderRefreshing];
    
    [self changeNavBarAlpha:0];
    self.navigationController.navigationBar.shadowImage = [Tools createImageWithColor:[UIColor clearColor]];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self leftItemWithNormalName:@"address_One"
                           title:@"定位中..."
                      titleColor:[UIColor whiteColor]
                        selector:@selector(leftBarClick)
                          target:self];
    [self rightBarButtomItemWithNormalName:@"notice"
                                  highName:@"notice"
                                  selector:@selector(rightBarClick)
                                    target:self];
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                   ];
    
    [self startLocation];
    [self requestBanner];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开始定位
    //[self.locationManager startUpdatingLocation];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止定位
    //[self.locationManager stopUpdatingLocation];
    
}


- (void)changeNavBarAlpha:(CGFloat)alpha{
    self.navigationController.navigationBar.subviews.firstObject.alpha = alpha;
    self.navigationBarBackGroudColor = [UIColorFromRGB(0xe64e51) colorWithAlphaComponent:alpha];
    self.navigationBarTitleColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
    
}
//请求广告图
- (void)requestBanner {
    @weakify(self);
    [HomeHttpManager requestBanner:Home_Banner
                              city:@"510100"
                            zoneId:@""
                           success:^(NSArray * response) {
                               @strongify(self);
                               self.imageURLArray = response;
                               [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                           } failure:^(NSError *error, NSString *message) {
                           }];
}
// 去帮忙
- (void)requestData
{
//    @weakify(self);
//    [NearByHttpManager requestDataWithNearType:ToHelp
//                                         query:2
//                                       keyWord:_keywords
//                                          city:_city
//                                      district:_district
//                                    categoryId:@""
//                                          sort:@""
//                                          page:self.currentPage
//                                       success:^(NSArray * response) {
//                                           @strongify(self);
//                                           [self.tableView endRefreshing];
//                                           
//                                           if (self.currentPage==1){
//                                               [self.dataSource removeAllObjects];
//                                           }
//                                           [self.dataSource addObjectsFromArray:response];
//                                           if (response.count<10) {
//                                               [self.tableView endRefreshingWithNoMoreData];
//                                           }
//                                           [self.tableView reloadData];
//                                           
//                                           //                                           [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
//                                           
//                                       } failure:^(NSError *error, NSString *message) {
//                                           [self.tableView endRefreshing];
//                                       }];
    
    @weakify(self);
    [NearByHttpManager requestDataWithNearType:ToHelp machineId:_deviceUUID machineName:_deviceModel clientType:@"0" query:2 categoryId:@"" page:self.currentPage success:^(NSArray * response) {
        @strongify(self);
        [self.tableView endRefreshing];
        
        if (self.currentPage==1){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
    }];

}
// 找服务
- (void)requestServiceData
{
//    @weakify(self);
//    [NearByHttpManager requestDataWithNearType:LookingService
//                                         query:2
//                                       keyWord:_keywords
//                                          city:_city
//                                      district:_district
//                                    categoryId:@""
//                                          sort:@""
//                                          page:self.currentPage
//                                       success:^(NSArray * response) {
//                                           @strongify(self);
//                                           [self.tableView endRefreshing];
//                                           
//                                           if (self.currentPage==1){
//                                               [self.dataSource removeAllObjects];
//                                           }
//                                           [self.dataSource addObjectsFromArray:response];
//                                           if (response.count<10) {
//                                               [self.tableView endRefreshingWithNoMoreData];
//                                           }
//                                           [self.tableView reloadData];
//                                           
//                                           //                                           [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
//                                           
//                                           
//                                           //                                           NSIndexPath *index=[NSIndexPath indexPathForRow:2 inSection:2];//刷新
//                                           //                                           [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
//                                           
//                                       } failure:^(NSError *error, NSString *message) {
//                                           [self.tableView endRefreshing];
//                                       }];
    
    @weakify(self);
    [NearByHttpManager requestDataWithNearType:LookingService machineId:_deviceUUID machineName:_deviceModel clientType:@"0" query:2 categoryId:@"" page:self.currentPage success:^(NSArray * response) {
        @strongify(self);
        [self.tableView endRefreshing];
        
        if (self.currentPage==1){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
    }];

}

//请求collectView的数据
- (void)requestDataSecondCellData {
    @weakify(self);
    [HomeHttpManager requestQueryType:2
                         secondInfoId:@""
                             keywords:@""
                              classId:@""
                                resId:@""
                               cityId:@""
                           districtId:@""
                             minPrice:@""
                             maxPrice:@""
                             newOrOld:@""
                             delivery:@"1"
                                 sort:@"0"
                              pageNum:self.secondCellCurrentPage
                              success:^(id response) {
                                  @strongify(self);
                                  self.secondCellDataSource = response;
                                  [self.tableView reloadData];
                                  //[self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
                              } failure:^(NSError *error, NSString *message) {
                              }];
}

//请求租房查询
- (void)requestRentHouseData
{
    @weakify(self);
    [HomeHttpManager requestQueryType:2
                             keywords:@""
                               cityId:@""
                           districtId:@""
                             minPrice:@""
                             maxPrice:@""
                            houseType:@""
                            direction:@""
                              minArea:@""
                              maxArea:@""
                          heatingMode:@""
                                floor:@""
                          hasElevator:@""
                         houseFitment:@""
                      basicFacilities:@""
                   extendedFacilities:@""
                                 sort:@"0"
                              pageNum:self.currentPage
                              success:^(id response) {
                                  @strongify(self);
                                  self.rentHouseDataSource = response;
                                  [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:5] withRowAnimation:UITableViewRowAnimationAutomatic];
                              } failure:^(NSError *error, NSString *message) {
                              }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 2;
    }
    else if (section == 1){
        return 1;
    }else if (section ==2 ){
        return self.dataSource.count+2;
    }else if (section == 3){
        return self.secondCellDataSource.count>0?2:1;
    }else if (section == 4){
        return self.secondCellDataSource.count;
    }else if (section == 5){
        return self.rentHouseDataSource.count+1;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==3) {
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==4) {
        return [self sectionFourWithTableView:tableView indexPath:indexPath];
    }
    else if(indexPath.section == 5){
        return [self sectionFiveWithTableView:tableView indexPath:indexPath];
    }
    else {
        return nil;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView == scrollView) {
        if (scrollView.contentOffset.y
            <= ScrollDistance) {
            [self changeNavBarAlpha:scrollView.contentOffset.y/ScrollDistance];
        }
        else if (scrollView.contentOffset.y<=0){
            [self changeNavBarAlpha:0];
        }
        else {
            [self changeNavBarAlpha:1];
        }
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BannerHeaderCell *cell = (BannerHeaderCell *)[self creatCell:tableView indenty:@"BannerHeaderCell"];
        //        cell.modelArray = imageNames;
        cell.modelArray = self.imageURLArray;
        return cell;
    }
    else {
        ItemBtnCell *cell = (ItemBtnCell *)[self creatCell:tableView indenty:@"ItemBtnCell"];
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            [PushManager pushViewControllerWithName:self.itemDataSourceArray[value][@"vcName"] animated:YES block:nil];
        };
        cell.titleAndImageDictArray = self.itemDataSourceArray;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    SectionHeaderCell *cell = (SectionHeaderCell *)[self creatCell:tableView indenty:@"SectionHeaderCell"];
    cell.notificationNews = self.notificationNewsArray;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        NearByHeaderCell *cell = (NearByHeaderCell *)[self creatCell:tableView indenty:@"NearByHeaderCell"];
        cell.cellHeadIcon.image = [UIImage imageNamed:@"peripheral_services_img"];
        cell.type = Nearby_Type;
        return cell;
    }
    else if (indexPath.row==1) {
        NearByServiceCell *cell = (NearByServiceCell *)[self creatCell:tableView indenty:@"NearByServiceCell"];
        cell.selectIndex = self.nearBySelectIndex;
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            self.nearBySelectIndex = value;
            NSLog(@"value==%ld", value);
            if (_nearBySelectIndex==0) {
                [self requestServiceData];
            }else{
                [self requestData];
            }
            
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return cell;
    }
    else {
        ProductItemCell *cell = (ProductItemCell *)[self creatCell:tableView indenty:@"ProductItemCell"];
        if (_nearBySelectIndex==0) {
            cell.serviceModel = self.dataSource[indexPath.row-2];
        }else{
            cell.model = self.dataSource[indexPath.row-2];
        }
        return cell;
        
    }
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0) {
        NearByHeaderCell *cell = (NearByHeaderCell *)[self creatCell:tableView indenty:@"NearByHeaderCell"];
        cell.cellHeadIcon.image = [UIImage imageNamed:@"Item_recom_img"];
        cell.type = Second_Type;
        return cell;
    }
    else {
        secondHandCell *cell = (secondHandCell *)[self creatCell:tableView indenty:@"secondHandCell"];
        cell.model = self.secondCellDataSource;
        return cell;
    }
}

//第4组
- (UITableViewCell *)sectionFourWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    ProductItemCell *cell = (ProductItemCell *)[self creatCell:tableView indenty:@"ProductItemCell"];
    cell.secondModel = self.secondCellDataSource[indexPath.row];
    return cell;
}

//第5组
- (UITableViewCell *)sectionFiveWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        NearByHeaderCell *cell = (NearByHeaderCell *)[self creatCell:tableView indenty:@"NearByHeaderCell"];
        cell.cellHeadIcon.image = [UIImage imageNamed:@"rent_house_img"];
        cell.type = Rent_Type;
        return cell;
    }
    else {
        ProductItemCell *cell = (ProductItemCell *)[self creatCell:tableView indenty:@"ProductItemCell"];
        cell.rentHouseModel = self.rentHouseDataSource[indexPath.row-1];
        return cell;
    }
}


//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==2) {
        if (_nearBySelectIndex==0) {
            [PushManager pushViewControllerWithName:@"ServiceDetailsController" animated:YES block:^(ServiceDetailsController* serviceDetailsVC) {
                serviceDetailsVC.currentVC = 0;
                serviceDetailsVC.model = self.dataSource[indexPath.row-2];
            }];
            
        }else{
            [PushManager pushViewControllerWithName:@"HelpDetailsController" animated:YES block:^(HelpDetailsController* helpDetailsVC) {
                helpDetailsVC.model = self.dataSource[indexPath.row-2];
            }];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if(indexPath.row ==0){
            return 180;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
    else if (indexPath.section ==1) {
        return 44;
    }
    else if (indexPath.section ==2) {
        if (indexPath.row<=1) {
            return 44;
        }
        return 120;
    }
    else if (indexPath.section ==3) {
        if (indexPath.row==0) {
            return 44;
        }
        return 175;
    }
    else if (indexPath.section ==4) {
        return 120;
    }
    else {
        if (indexPath.row ==0) {
            return 44;
        }
        return 120;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}

//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 10.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(247, 247, 247);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (NSArray *)itemDataSourceArray {
    if(!_itemDataSourceArray) {
        _itemDataSourceArray = @[
                                 @{@"title":@"二手物品"
                                   ,@"icon":@"second_hand_ goods"
                                   ,@"vcName":@"SecondHandViewController"},
                                 @{@"title":@"求购"
                                   ,@"icon":@"looking_for"
                                   ,@"vcName":@"LookingForViewController"},
                                 @{@"title":@"房屋租赁"
                                   ,@"icon":@"house_lease"
                                   ,@"vcName":@"HouseRentViewController"},
                                 @{@"title":@"求租"
                                   ,@"icon":@"soliciting"
                                   ,@"vcName":@"SolicitingViewController"},
                                 @{@"title":@"我的小区"
                                   ,@"icon":@"home_wdxq"
                                   ,@"vcName":@"MyCommunityController"},
                                 @{@"title":@"我的房屋"
                                   ,@"icon":@"my_house"
                                   ,@"vcName":@"MyHouseViewController"},
                                 @{@"title":@"物业"
                                   ,@"icon":@"management_fee"
                                   ,@"vcName":@"PayCostController"},
                                 @{@"title":@"生活缴费"
                                   ,@"icon":@"life_pay_cost"
                                   ,@"vcName":@"LifePayCostController"},
                                 ];
    }
    return _itemDataSourceArray;
}

- (NSArray *)notificationNewsArray {
    if(!_notificationNewsArray){
        _notificationNewsArray = @[@"今天天机打了肯德基埃里克森",
                                   @"啊实打实大会",
                                   @"实打实大所",
                                   @"撒大声地",
                                   @"奥术大师多"];
    }
    return _notificationNewsArray;
}
- (void)setCategoryId:(NSString *)categoryId {
    _categoryId = categoryId;
    if (_nearBySelectIndex==0) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    if (_nearBySelectIndex==0) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

- (void)setDistrict:(NSString *)district {
    _district = district;
    if (_nearBySelectIndex==0) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

-(void)setCity:(NSString *)city {
    _city = city;
    if (_nearBySelectIndex==0) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

//开始定位的时候，首先判断是否能定位
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [self.locationManager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
    }
    
}
//代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    double latitude = currLocation.coordinate.latitude;
    double longitude = currLocation.coordinate.longitude;
    
    [[NSUserDefaults standardUserDefaults] setDouble:latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setDouble:longitude forKey:@"longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    @weakify(self);
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        @strongify(self);
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            _LocatingCity = [address objectForKey:@"City"];
            [[NSUserDefaults standardUserDefaults] setObject:_LocatingCity forKey:@"locationCity"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self leftItemWithNormalName:@"address_One" title:_LocatingCity titleColor:[UIColor whiteColor] selector:@selector(leftBarClick) target:self];
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            
        }
        
    }];
    
}
//定位失败，调用此方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

- (void)leftBarClick
{
    NSLog(@"leftBarClick");
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",
                                 @"北京",
                                 @"天津",
                                 @"厦门",
                                 @"重庆",
                                 @"福州",
                                 @"泉州",
                                 @"济南",
                                 @"深圳",
                                 @"长沙",
                                 @"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",
                                        @"厦门",
                                        @"泉州", nil];
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:_LocatingCity, nil];
    
    
    [self presentViewController:cityListView animated:YES completion:nil];
    
}

- (void)didClickedWithCityName:(NSString*)cityName
{
    [self leftItemWithNormalName:@"noticeYellow" title:cityName titleColor:[UIColor whiteColor] selector:@selector(leftBarClick) target:self];
    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}
@end
