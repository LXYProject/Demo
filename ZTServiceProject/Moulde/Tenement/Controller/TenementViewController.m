//
//  TenementViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenementViewController.h"
#import "MacroDefinition.h"
#import "PropertyBannerCell.h"
#import "ItemBtnCell.h"
#import "ItemBtnCell.h"
@interface TenementViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSourceArray;
@end

@implementation TenementViewController
{
    NSArray *imageNames;
    NSInteger _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                   ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PropertyBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PropertyBannerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PropertyBannerCell" owner:nil options:nil] lastObject];
        }
        cell.modelArray = imageNames;
        return cell;
    }
    
    else {
        ItemBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemBtnCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ItemBtnCell" owner:nil options:nil] lastObject];
        }
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            [PushManager pushViewControllerWithName:self.dataSourceArray[indexPath.section][value][@"vcName"] animated:YES block:nil];
        };
        cell.titleAndImageDictArray = self.dataSourceArray[indexPath.section];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }
    else {
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[
                             @[@{@"imgUrl":@""},
                               @{@"imgUrl":@""}],
                             @[
                                 @{@"title":@"小区公告",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"小区全景",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"NearByViewController"},
                                 
                                 @{@"title":@"便民信息",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"小区主页",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 ],
                             @[
                                 @{@"title":@"上门服务",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"公共报事",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"表扬",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"投诉",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 ],
                             @[
                                 @{@"title":@"呼叫保安",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"保安团队",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"设施设备",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"}
                                 ],
                             @[
                                 @{@"title":@"物业费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 @{@"title":@"生活缴费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"}
                                 ],
                             ];
    }
    return _dataSourceArray;
}

@end
