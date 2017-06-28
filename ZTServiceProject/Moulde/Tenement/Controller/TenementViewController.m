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
#import "ItemBtnCell.h"
#import "HomeHttpManager.h"
#import "TenemnetHeaderCell.h"
#import "BannerHeaderCell.h"
#import "AdvertisementModel.h"
#import "DQTextFild.h"
#import "MyCommunityListController.h"

@interface TenementViewController ()<UITextFieldDelegate, MyCommunityListControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSourceArray;
@property (nonatomic,strong)NSArray *imageURLArray;
@property (nonatomic,strong)NSArray *titleHeader;
@property (nonatomic, strong)NSMutableArray *imageUrlArr;
@property (nonatomic, strong)NSMutableArray *imageNames;

@property (nonatomic, strong) DQTextFild *BYsearchTextFd;

@end

@implementation TenementViewController
{
//    NSArray *imageNames;
    NSInteger _times;
    MyCommunityListController *_myVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    imageNames = @[
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   ];
    _imageUrlArr = [[NSMutableArray alloc] init];
    [self createNav];

    _myVC.delegate = self;
    
    [self requestBanner];
}

- (void)createNav
{
    self.BYsearchTextFd = [[DQTextFild alloc]initWithFrame:CGRectMake(50, 33,self.view.frame.size.width-100,31)];
    self.BYsearchTextFd.placeholder = @"请输入关键词";
    [self.BYsearchTextFd setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.BYsearchTextFd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UILabel * placeholderLabel = [self.BYsearchTextFd valueForKey:@"_placeholderLabel"];
    placeholderLabel.textAlignment = NSTextAlignmentCenter;
    self.BYsearchTextFd.backgroundColor = [UIColor clearColor];
    self.BYsearchTextFd.background = [UIImage imageNamed:@"搜索-背景"];
    self.BYsearchTextFd.delegate = self;
    self.BYsearchTextFd.keyboardType = UIKeyboardTypeWebSearch;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cancel"]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    img.frame = CGRectMake(10, 0,20,20);
    btn.frame = CGRectMake(10, 0,20,20);
    self.BYsearchTextFd.rightView = btn;
    self.BYsearchTextFd.rightViewMode = UITextFieldViewModeAlways;
    self.BYsearchTextFd.font = [UIFont fontWithName:@"Arial" size:14];
    self.navigationItem.titleView = self.BYsearchTextFd;
}

- (void)btnClick
{
//    [PushManager pushViewControllerWithName:@"" animated:YES block:nil];
    MyCommunityListController *myVC = [[MyCommunityListController alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
//    [self presentViewController:myVC animated:YES completion:nil];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

#pragma mark 实现传值协议方法
-(void)passTrendValues:(NSString *)values{
    NSLog(@"values:::%@",values);
}

//请求广告图
- (void)requestBanner {
    @weakify(self);
    [HomeHttpManager requestBanner:Tenement_Banner city:@"510100" zoneId:@"510029841228" success:^(NSArray * response) {
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
            [PushManager pushViewControllerWithName:self.dataSourceArray[indexPath.section][value][@"vcName"] animated:YES block:nil];
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

- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[
                             @[@{@"imgUrl":@""},
                               @{@"imgUrl":@""}],
                             @[
                                 @{@"title":@"小区公告",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 
                                 @{@"title":@"小区全景",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"NearByViewController"},
                                 
                                 @{@"title":@"便民信息",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 
                                 @{@"title":@"小区主页",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 ],
                             @[
                                 @{@"title":@"上门服务",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"DoorServiceController"},
                                 
                                 @{@"title":@"公共报事",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"PublicThingsController"},
                                 
                                 @{@"title":@"表扬",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"PraiseViewController"},
                                 
                                 @{@"title":@"投诉",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"ComplaintsController"},
                                 ],
                             @[
                                 @{@"title":@"呼叫保安",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 
                                 @{@"title":@"保安团队",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 
                                 @{@"title":@"设施设备",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"}
                                 ],
                             @[
                                 @{@"title":@"物业费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"},
                                 @{@"title":@"生活缴费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"AnnounceViewController"}
                                 ],
                             ];
    }
    return _dataSourceArray;
}

@end
