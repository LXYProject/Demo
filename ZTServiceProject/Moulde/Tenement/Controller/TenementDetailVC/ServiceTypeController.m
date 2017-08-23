//
//  ServiceTypeController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceTypeController.h"
#import "TenementHttpManager.h"
#import "DoorServiceModel.h"
#import "DoorServiceController.h"   

@interface ServiceTypeController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 服务类型数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ServiceTypeController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"服务类型"
                  titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    [self.tableView setHeaderRefreshBlock:^{
        
        if (self.zoneId.length>0) {
            [self requestServiceList];
        }
    }];
    [self.tableView beginHeaderRefreshing];

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
}

// 服务类型列表
- (void)requestServiceList{
    @weakify(self);
    [TenementHttpManager requestListOrPanorama:ServiceList
                                        zoneId:self.zoneId
                                       success:^(id response) {
                                           @strongify(self);
                                           [self.tableView endRefreshing];
                                           [_hud hide:YES];
                                           
                                           [self.dataSource removeAllObjects];
                                           
                                           [self.dataSource addObjectsFromArray:response];
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
    cell.textLabel.text = [self.dataSource[indexPath.row] serviceCategory];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self);
    [PushManager popViewControllerWithName:@"DoorServiceController" animated:YES block:^(DoorServiceController* viewController) {
        @strongify(self);
        viewController.serviceType = [self.dataSource[indexPath.row] serviceCategory];
    }];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
