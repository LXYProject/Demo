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

@interface MyCommunityListController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//查看所有与我有关的小区 的数据相关的
@property (nonatomic,strong)NSMutableArray *myZonesDataSource;//绑定的小区
@property (nonatomic,assign)NSInteger currentPage;


@end

@implementation MyCommunityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"我的小区"
                  titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    
    self.currentPage = 1;
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        [self requestLookAllVillageWithMe];
    }];
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        [self requestLookAllVillageWithMe];
    }];
    [self.tableView beginHeaderRefreshing];

}

// 查看所有与我有关的小区
- (void)requestLookAllVillageWithMe{
    
    [MineHttpManager requesHouseAddVillage:Village
                                   success:^(NSDictionary *response) {
                                       
                                       NSArray *myZonesArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response[@"myZones"]];
                                       
                                       [self.tableView endRefreshing];
                                       if (self.currentPage==1){
                                           [self.myZonesDataSource removeAllObjects];
                                       }
                                       [self.myZonesDataSource addObjectsFromArray:myZonesArray];
                                       if (response.count<10) {
                                           [self.tableView endRefreshingWithNoMoreData];
                                       }
                                       [self.tableView reloadData];
                                       
                                   } failure:^(NSError *error, NSString *message) {
                                       [self.tableView endRefreshing];
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
    if ([self.delegate respondsToSelector:@selector(passTrendValues:)]) {
        [self.delegate passTrendValues:self.myZonesDataSource[indexPath.row]];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)myZonesDataSource {
    if (!_myZonesDataSource) {
        _myZonesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _myZonesDataSource;
}


@end
