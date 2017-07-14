//
//  HouseListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HouseListController.h"
#import "MineHttpManager.h"
#import "HouseListModel.h"
#import "MyHouseViewController.h"

@interface HouseListController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//搜索到楼的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HouseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"房屋列表" titleColor:[UIColor whiteColor]];

    [self searchHouse];
}

// 根据楼查询房屋表
- (void)searchHouse{
    [MineHttpManager requestZoneId:self.zoneId
                        buildingId:self.buildingId
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
    cell.textLabel.text = [self.dataSource[indexPath.row] houseName];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 选择行，添加房屋关注
    [MineHttpManager requestAddToCancelHouse:addLikeHouse
                                     houseId:[self.dataSource[indexPath.row] houseId]
                                     success:^(id response) {
                                         
                                         //操作失败的原因
                                         NSString *information = [response objectForKey:@"information"];
                                         //状态码
                                         NSString *status = [response objectForKey:@"status"];

                                         if ([status integerValue]==0) {

                                             [self createAlertView];

                                         }else{
                                             [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                         }
                                     } failure:^(NSError *error, NSString *message) {
                                     }];
    
}

- (void)createAlertView{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:(UIAlertControllerStyleAlert)];
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
