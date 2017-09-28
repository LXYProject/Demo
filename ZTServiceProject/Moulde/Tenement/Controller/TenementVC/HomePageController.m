//
//  HomePageController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HomePageController.h"
#import "MineHttpManager.h"
#import "MyHouseModel.h"

@interface HomePageController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//查看所有与我有关的房屋 的数据相关的
@property (nonatomic,strong)NSMutableArray *bindHousesDataSource;//绑定的房屋


@end

@implementation HomePageController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"房屋选择" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    [self.tableView setHeaderRefreshBlock:^{
        [self requestLookAllHouseWithMe];
    }];

    [self.tableView beginHeaderRefreshing];
    
}

// 查看所有与我有关的房屋
- (void)requestLookAllHouseWithMe{
//    @weakify(self);
//    [MineHttpManager requesHouseAddVillage:House
//                                   success:^(NSDictionary* response) {
//                                       @strongify(self);
//                                       [self.tableView endRefreshing];
//                                       [_hud hide:YES];
//                                       
//                                       NSMutableArray *bindHouseArray = [MyHouseModel mj_objectArrayWithKeyValuesArray:response[@"bindHouses"]];
//                                       [self.bindHousesDataSource removeAllObjects];
//                                       [self.bindHousesDataSource addObjectsFromArray:bindHouseArray];
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
    [MineHttpManager requestHouseAddVillage:House machineId:[getUUID getUUID] machineName:[Tools deviceVersion] clientType:@"0" success:^(id response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        NSMutableArray *bindHouseArray = [MyHouseModel mj_objectArrayWithKeyValuesArray:response[@"bindHouses"]];
        [self.bindHousesDataSource removeAllObjects];
        [self.bindHousesDataSource addObjectsFromArray:bindHouseArray];
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
    return self.bindHousesDataSource.count;
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
    cell.textLabel.text = [self.bindHousesDataSource[indexPath.row] title];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [PushManager pushViewControllerWithName:@"VillagePanoramaController" animated:YES block:^(VillagePanoramaController* viewController) {
//        viewController.navTitle = [self.myZonesDataSource[indexPath.row] zoneName];
//        viewController.pushId = 1;
//    }];
    
}

- (NSArray *)bindHousesDataSource {
    if (!_bindHousesDataSource) {
        _bindHousesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _bindHousesDataSource;
}

@end
