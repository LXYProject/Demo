//
//  FloorListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/9/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "FloorListController.h"
#import "MineHttpManager.h"
#import "FloorModel.h"
#import "HousingListController.h"

@interface FloorListController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//搜索到楼层的数据
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation FloorListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"楼层列表" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    [self searchFloorBuilding];

}

// 楼层-根据单元ID搜索
- (void)searchFloorBuilding{
    @weakify(self);
    [MineHttpManager requestBuildingUnitId:self.buildingUnitId
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
    cell.textLabel.text = [self.dataSource[indexPath.row] floorName];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    @weakify(self);
    [PushManager pushViewControllerWithName:@"HousingListController" animated:YES block:^(HousingListController* viewController) {
        @strongify(self);
        viewController.zoneId = self.zoneId;
        viewController.buildingFloorId = [self.dataSource[indexPath.row] floorId];
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
