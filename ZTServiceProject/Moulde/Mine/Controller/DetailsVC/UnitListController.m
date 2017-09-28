//
//  UnitListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/9/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "UnitListController.h"
#import "MineHttpManager.h"
#import "UnitModel.h"
#import "FloorListController.h"

@interface UnitListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//搜索到单元的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation UnitListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"单元列表" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    [self searchUnitBuilding];
}

// 单元-根据楼栋ID搜索
- (void)searchUnitBuilding{
    @weakify(self);
    [MineHttpManager requestBuildingId:self.buildingId
                               success:^(NSArray* response) {
                                   @strongify(self);
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
    cell.textLabel.text = [self.dataSource[indexPath.row] unitName];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @weakify(self);
    [PushManager pushViewControllerWithName:@"FloorListController" animated:YES block:^(FloorListController* viewController) {
        @strongify(self);
        viewController.zoneId = self.zoneId;
        viewController.buildingUnitId = [self.dataSource[indexPath.row] unitId];
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
