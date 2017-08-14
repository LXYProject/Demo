//
//  LocationChoiceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/21.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LocationChoiceController.h"
#import "PostMessageController.h"
#import "ReleaseViewController.h"
#import "PublishServiceController.h"
#import "PublicThingsController.h"
#import "ReleaseHelpController.h"

@interface LocationChoiceController ()<CLLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate,AMapLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign)CLLocationCoordinate2D currentSelectPoint;
@property (nonatomic,strong)AMapLocationManager *localManager;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation LocationChoiceController
{
    NSInteger x;
    NSInteger y;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self titleViewWithTitle:@"位置选择" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"确定" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    [self.view addSubview:self.mapView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //持续定位
    self.localManager = [[AMapLocationManager alloc] init];
    self.localManager.delegate = self;
    //开启持续定位
    [self.localManager startUpdatingLocation];
    
//    self.currentSelectPoint.latitude = 39.968309;
//    self.currentSelectPoint.longitude = 116.431795;
    
}



- (void)rightBarClick
{
    NSLog(@"确定");
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}



/** 根据定位坐标进行周边搜索 */
- (void)searchAround{
    if (!self.search) {
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
    }
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:self.currentSelectPoint.latitude longitude:self.currentSelectPoint.longitude];
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    /* 按照距离排序. */
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [self.search AMapPOIAroundSearch: request];
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"location:{lat:%f; lon:%f;}", coordinate.latitude, coordinate.longitude);
    self.currentSelectPoint = coordinate;
    [self searchAround];
}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    // 定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    self.currentSelectPoint = location.coordinate;
    [self searchAround];
    // 停止定位
    [self.localManager stopUpdatingLocation];
}


/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    NSLog(@"response.pois==%@", response.pois);
    
    self.dataSource = (NSMutableArray *)response.pois;
    [self.tableView reloadData];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"请求错误");
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
//    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    AMapPOI *poi = (AMapPOI *)self.dataSource[indexPath.row];
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = UIColorFromRGB(0xb2b2b2);
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];

    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMapPOI *poi = (AMapPOI *)self.dataSource[indexPath.row];

    if (self.currentController==0) {
        [PushManager popViewControllerWithName:@"PostMessageController" animated:YES block:^(PostMessageController* viewController) {//发布帖子
            viewController.locationInfo = poi.name;
        }];
    }else if (self.currentController==1){
        [PushManager popViewControllerWithName:@"ReleaseViewController" animated:YES block:^(ReleaseViewController* viewController) {//二手物品发布
            viewController.locationInfo = poi.name;
        }];
    }else if (self.currentController==2){
        [PushManager popViewControllerWithName:@"PublishServiceController" animated:YES block:^(PublishServiceController* viewController) {//发布服务
            viewController.locationInfo = poi.name;
        }];
    }else if (self.currentController==3){
        [PushManager popViewControllerWithName:@"PublicThingsController" animated:YES block:^(PublicThingsController* viewController) {//公共报事
            viewController.locationInfo = poi.name;
        }];
    }else{
        [PushManager popViewControllerWithName:@"ReleaseHelpController" animated:YES block:^(ReleaseHelpController* viewController) {//发布求助
            viewController.locationInfo = poi.name;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
        _mapView.delegate = self;
        _mapView.zoomLevel = 13.1;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
    }
    return _mapView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
@end
