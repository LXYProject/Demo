//
//  TenementViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenementViewController.h"
#import "MacroDefinition.h"
#import "ItemBtnCell.h"
#import "HomeHttpManager.h"
#import "TenemnetHeaderCell.h"
#import "BannerHeaderCell.h"
#import "AdvertisementModel.h"
#import "DQTextFild.h"
#import "MyCommunityListController.h"
#import "MKPAlertView.h"
#import "AnnounceViewController.h"
#import "DoorServiceController.h"
#import "InformationController.h"
#import "PraiseViewController.h"
#import "ComplaintsController.h"
#import "VillagePanoramaController.h"

@interface TenementViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSourceArray;
@property (nonatomic,strong)NSArray *imageURLArray;
@property (nonatomic,strong)NSArray *titleHeader;
@property (nonatomic, strong)NSMutableArray *imageUrlArr;
@property (nonatomic, strong)NSMutableArray *imageNames;

@property (nonatomic, strong) DQTextFild *BYsearchTextFd;
@property (nonatomic, strong) UIButton *searchBtn;

@end

@implementation TenementViewController
{
//    NSArray *imageNames;
    NSInteger _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    imageNames = @[
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   ];
    _imageUrlArr = [[NSMutableArray alloc] init];
    
    [self requestBanner];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNav];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBtn removeFromSuperview];
}

- (void)createNav
{
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(50, 33,self.view.frame.size.width-100,31);
    self.searchBtn.backgroundColor = RGB(210, 70, 76);
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = self.searchBtn.bounds.size.width * 0.05;
    self.searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    if (_btnTitle.length==0) {
        [self.searchBtn setTitle:@"岷阳小区" forState:UIControlStateNormal];
        self.zoneId = @"510018177815";
    }else{
        [self.searchBtn setTitle:_btnTitle forState:UIControlStateNormal];
    }
    //[self.searchBtn setTitle:_btnTitle forState:UIControlStateNormal];
    NSLog(@"_btnTitle:::%@",_btnTitle);
    NSLog(@"zoneId:::%@",_zoneId);
    [self.searchBtn setImage:[UIImage imageNamed:@"wy_xl"] forState:UIControlStateNormal];
    self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0,self.searchBtn.frame.size.width-25, 0, 0); //上左下右
    [self.searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchBtn;
    
}

- (void)searchBtnClick
{
    [PushManager pushViewControllerWithName:@"MyCommunityListController" animated:YES block:nil];
}
//请求广告图
- (void)requestBanner {
    @weakify(self);
    [HomeHttpManager requestBanner:Tenement_Banner
                              city:@"510100"
                            zoneId:@"510029841228"
                           success:^(NSArray * response) {
                               @strongify(self);
                               self.imageURLArray = response;
                               [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                           } failure:^(NSError *error, NSString *message) {
                           }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BannerHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerHeaderCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BannerHeaderCell" owner:nil options:nil] lastObject];
        }
//        cell.modelArray = imageNames;
        cell.modelArray = self.imageURLArray;
        return cell;
    }
    
    else {  
        if (indexPath.row ==0 ){
            TenemnetHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TenemnetHeaderCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TenemnetHeaderCell" owner:nil options:nil] lastObject];
            }
            cell.titleHeader.text = self.titleHeader[indexPath.section-1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
        
        ItemBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemBtnCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ItemBtnCell" owner:nil options:nil] lastObject];
        }
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);

            if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"MKPAlertView"]) {
                
                // 弹出框
                [self creareAlert];
            }else{
                
                if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"AnnounceViewController"]){
                  
                    [PushManager pushViewControllerWithName:@"AnnounceViewController" animated:YES block:^(AnnounceViewController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];
                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"DoorServiceController"]){
                    
                    [PushManager pushViewControllerWithName:@"DoorServiceController" animated:YES block:^(DoorServiceController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];
                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"PublicThingsController"]){

                    [PushManager pushViewControllerWithName:@"PublicThingsController" animated:YES block:^(DoorServiceController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];

                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"InformationController"]){

                    [PushManager pushViewControllerWithName:@"InformationController" animated:YES block:^(InformationController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];

                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"PraiseViewController"]){
                    
                    [PushManager pushViewControllerWithName:@"PraiseViewController" animated:YES block:^(PraiseViewController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];
                    
                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"ComplaintsController"]){
                    
                    [PushManager pushViewControllerWithName:@"ComplaintsController" animated:YES block:^(ComplaintsController* viewController) {
                        viewController.zoneId = self.zoneId;
                    }];
                }else if ([self.dataSourceArray[indexPath.section][value][@"vcName"] isEqualToString:@"VillagePanoramaController"]){
                    
                    [PushManager pushViewControllerWithName:@"VillagePanoramaController" animated:YES block:^(VillagePanoramaController* viewController) {
                        viewController.zoneId = self.zoneId;
                        viewController.zoneName = self.btnTitle;
                        viewController.x = self.x;
                        viewController.y = self.y;
                        viewController.pushId = 0;
                    }];
                }
                else{
                // push控制器
                [PushManager pushViewControllerWithName:self.dataSourceArray[indexPath.section][value][@"vcName"] animated:YES block:nil];
                }
            }
        };
        cell.titleAndImageDictArray = self.dataSourceArray[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180;
    }
    else {
        if (indexPath.row ==0) {
            return 49;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)titleHeader
{
    if (!_titleHeader) {
        _titleHeader = @[
                         @"小区信息",
                         @"物业服务",
                         @"小区安保",
                         @"缴费"
                         ];
    }
    return _titleHeader;
}

- (void)creareAlert
{
    MKPAlertView *alertView = [[MKPAlertView alloc]initWithTitle:@"呼叫保安"
                                                         message:@""
                                                         sureBtn:@"确认呼叫"
                                                       cancleBtn:@"取消呼叫"];
    alertView.resultIndex = ^(NSInteger index)
    {
        // 回调 -- 处理
        NSLog(@"%s",__func__);
        
    };
    [alertView showMKPAlertView];

}
- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[
                             @[@{@"imgUrl":@""},
                               @{@"imgUrl":@""}],
                             @[
                                 @{@"title":@"小区公告",
                                   @"icon":@"wy_xqgg",
                                   @"vcName":@"AnnounceViewController"},
                                 
                                 @{@"title":@"小区全景",
                                   @"icon":@"wy_xqqj",
                                   @"vcName":@"VillagePanoramaController"},
                                 
                                 @{@"title":@"便民信息",
                                   @"icon":@"wy_bmxx",
                                   @"vcName":@"InformationController"},
                                 
                                 @{@"title":@"小区主页",
                                   @"icon":@"wy_xqzy",
                                   @"vcName":@"HomePageController"},
                                 ],
                             @[
                                 @{@"title":@"上门服务",
                                   @"icon":@"wy_smfw",
                                   @"vcName":@"DoorServiceController"},
                                 
                                 @{@"title":@"公共报事",
                                   @"icon":@"wy_ggbs",
                                   @"vcName":@"PublicThingsController"},
                                 
                                 @{@"title":@"表扬",
                                   @"icon":@"wy_by",
                                   @"vcName":@"PraiseViewController"},
                                 
                                 @{@"title":@"投诉",
                                   @"icon":@"wy_ts",
                                   @"vcName":@"ComplaintsController"},
                                 ],
                             @[
                                 @{@"title":@"呼叫保安",
                                   @"icon":@"wy_hjba",
                                   @"vcName":@"MKPAlertView"},
                                 
                                 @{@"title":@"保安团队",
                                   @"icon":@"wy_batd",
                                   @"vcName":@"InformationController"},
                                 
                                 @{@"title":@"设施设备",
                                   @"icon":@"wy_sssb",
                                   @"vcName":@"InformationController"}
                                 ],
                             @[
                                 @{@"title":@"物业费",
                                   @"icon":@"wy_wyf",
                                   @"vcName":@"PayCostController"},
                                 @{@"title":@"生活缴费",
                                   @"icon":@"wy_shjf",
                                   @"vcName":@"LifePayCostController"}
                                 ],
                             ];
    }
    return _dataSourceArray;
}

@end
