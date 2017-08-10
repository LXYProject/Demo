//
//  VillagePeopleController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VillagePeopleController.h"
#import "PeopleDetailsCell.h"
#import "MineHttpManager.h"
#import "PersonalDataController.h"
#import "CommunityPeopleModel.h"


@interface VillagePeopleController ()

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 小区查看附近的人 的数据相关的
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation VillagePeopleController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"同小区的人" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];


    [self.tableView setHeaderRefreshBlock:^{
        [self requestLookPepoleByVillage];
    }];
    [self.tableView beginHeaderRefreshing];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = @"正在加载";
    
}

// 根据小区查看附近的人
- (void)requestLookPepoleByVillage{
    @weakify(self);
    [MineHttpManager requestPeopleZoneId:@"510018177815"
                                 success:^(NSArray* response) {
                                 @strongify(self);
                                     [self.tableView endRefreshing];
                                     [_hud hideAnimated:YES];
                                     
                                     [self.dataSource removeAllObjects];
                                     [self.dataSource addObjectsFromArray:response];
                                     [self.tableView reloadData];
                                     
                                 } failure:^(NSError *error, NSString *message) {
                                     [self.tableView endRefreshing];
                                     _hud.label.text = message;
                                     [_hud hideAnimated:YES];
                                 }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    PeopleDetailsCell *cell = (PeopleDetailsCell *)[self creatCell:tableView indenty:@"PeopleDetailsCell"];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [PushManager pushViewControllerWithName:@"PersonalDataController" animated:YES block:^(PersonalDataController* viewController) {
        viewController.model = self.dataSource[indexPath.row];
        viewController.titleStr = [self.dataSource[indexPath.row] userName];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
