//
//  BuildingListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BuildingListController.h"
#import "MineHttpManager.h"
#import "BuildingListModel.h"
#import "HouseListController.h"

@interface BuildingListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//搜索到楼的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation BuildingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"楼栋列表" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    
    [self searchStoriedBuilding];
}

// 小区id搜索楼
- (void)searchStoriedBuilding{
    [MineHttpManager requestZoneId:self.zoneId
                           success:^(NSArray* response) {
                               
                               [self.dataSource addObjectsFromArray:response];
                               [self.tableView reloadData];

                           } failure:^(NSError *error, NSString *message) {
                               
                           }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] buildingName];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @weakify(self);
    [PushManager pushViewControllerWithName:@"HouseListController" animated:YES block:^(HouseListController* viewController) {
        @strongify(self);
        viewController.zoneId = self.zoneId;
        viewController.buildingId = [self.dataSource[indexPath.row] buildingId];
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
