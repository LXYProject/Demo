//
//  PublicTypeController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublicTypeController.h"
#import "PublicThingsController.h"
#import "TenementHttpManager.h"
#import "MatterTypeModel.h"

@interface PublicTypeController ()

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 报事类型数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation PublicTypeController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"报事类型"
                  titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    [self.tableView setHeaderRefreshBlock:^{
        
        if (self.zoneId.length>0) {
            [self requestAffairCategoryList];
        }
    }];
    [self.tableView beginHeaderRefreshing];

}

// 报事类型列表
- (void)requestAffairCategoryList{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    @weakify(self);
    [TenementHttpManager requestListOrPanorama:ListThings
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
    cell.textLabel.text = [self.dataSource[indexPath.row] affairCategory];
//    cell.textLabel.text = @"hahah";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [PushManager popViewControllerWithName:@"PublicThingsController" animated:YES block:^(PublicThingsController* viewController) {
        viewController.publicType = [self.dataSource[indexPath.row] affairCategory];
    }];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end
