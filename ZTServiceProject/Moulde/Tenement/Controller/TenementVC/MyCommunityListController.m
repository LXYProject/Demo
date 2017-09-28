//
//  MyCommunityListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/21.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyCommunityListController.h"
#import "MineHttpManager.h"
#import "MyNeighborModel.h"
#import "TenementViewController.h"

@interface MyCommunityListController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//查看所有与我有关的小区 的数据相关的
@property (nonatomic,strong)NSMutableArray *myZonesDataSource;//绑定的小区


@end

@implementation MyCommunityListController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我的小区" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    
    [self.tableView setHeaderRefreshBlock:^{
        [self requestLookAllVillageWithMe];
    }];
    [self.tableView beginHeaderRefreshing];

}

// 查看所有与我有关的小区
- (void)requestLookAllVillageWithMe{
//    @weakify(self);
//    [MineHttpManager requesHouseAddVillage:Village
//                                   success:^(NSDictionary *response) {
//                                       @strongify(self);
//                                       [self.tableView endRefreshing];
//                                       [_hud hide:YES];
//
//                                       NSArray *myZonesArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response[@"myZones"]];
//                                       
//                                           [self.myZonesDataSource removeAllObjects];
//                                       [self.myZonesDataSource addObjectsFromArray:myZonesArray];
//                                       [self.tableView reloadData];
//                                       
//                                   } failure:^(NSError *error, NSString *message) {
//                                       [self.tableView endRefreshing];
//                                       _hud.labelText = message;
//                                       [_hud hide:YES];
//                                   }];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    @weakify(self);
    [MineHttpManager requestHouseAddVillage:Village machineId:[getUUID getUUID] machineName:[Tools deviceVersion] clientType:@"0" success:^(id response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        NSArray *myZonesArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response[@"myZones"]];
        
        [self.myZonesDataSource removeAllObjects];
        [self.myZonesDataSource addObjectsFromArray:myZonesArray];
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];
        _hud.labelText = message;
        [_hud hide:YES];
        
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myZonesDataSource.count;
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
    cell.textLabel.text = [self.myZonesDataSource[indexPath.row] zoneName];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    @weakify(self);
    [PushManager popViewControllerWithName:@"TenementViewController" animated:YES block:^(TenementViewController* viewController) {
        @strongify(self);
        viewController.btnTitle = [self.myZonesDataSource[indexPath.row] zoneName];
        viewController.zoneId = [self.myZonesDataSource[indexPath.row] zoneId];
        viewController.x = [self.myZonesDataSource[indexPath.row] zoneX];
        viewController.y = [self.myZonesDataSource[indexPath.row] zoneY];

    }];

}

- (NSArray *)myZonesDataSource {
    if (!_myZonesDataSource) {
        _myZonesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _myZonesDataSource;
}


@end
