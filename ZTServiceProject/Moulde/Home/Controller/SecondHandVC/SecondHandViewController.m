//
//  SecondHandViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHandViewController.h"
#import "SearchHeadCell.h"
#import "ItemBtnCell.h"
#import "ImageCell.h"
#import "secondHandCell.h"
#import "MessageCell.h"
#import "NearByItemModel.h"
#import "HomeHttpManager.h"
@interface SecondHandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *itemDataSourceArray;
//collectView 的数据相关的
@property (nonatomic,strong)NSArray *secondCellDataSource;
@property (nonatomic,assign)NSInteger secondCellCurrentPage;

@end

@implementation SecondHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.secondCellCurrentPage = 1;

    [self titleViewWithTitle:@"二手物品" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    [self requestDataSecondCellData];
}
- (void)rightBarClick
{
    [PushManager pushViewControllerWithName:@"ReleaseViewController" animated:YES block:nil];
}
//请求collectView的数据
- (void)requestDataSecondCellData {
    [HomeHttpManager requestQueryType:2 secondInfoId:@"" keywords:@"" classId:@"" resId:@"" cityId:@"" districtId:@"" minPrice:@"" maxPrice:@"" newOrOld:@"" delivery:@"1" sort:@"0" pageNum:self.secondCellCurrentPage success:^(id response) {
        self.secondCellDataSource = response;
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error, NSString *message) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 2;
    }else if(section ==1){
        return 1;
    }else if(section ==2){
        return 1;
    }
    else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }

    else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchHeadCell *cell = (SearchHeadCell *)[self creatCell:tableView indenty:@"SearchHeadCell"];
        return cell;
    }
    else {
        ItemBtnCell *cell = (ItemBtnCell *)[self creatCell:tableView indenty:@"ItemBtnCell"];
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            [PushManager pushViewControllerWithName:self.itemDataSourceArray[value][@"vcName"] animated:YES block:nil];
        };
        cell.titleAndImageDictArray = self.itemDataSourceArray;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[self creatCell:tableView indenty:@"ImageCell"];
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    secondHandCell *cell = (secondHandCell *)[self creatCell:tableView indenty:@"secondHandCell"];
    cell.model = self.secondCellDataSource;
    return cell;
}

//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if(indexPath.row ==0){
            return 45;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
    else if (indexPath.section ==1) {
        return 150;
    }
    else if (indexPath.section ==2) {
        return 175;
    }
    else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSArray *)itemDataSourceArray {
    if(!_itemDataSourceArray) {
        _itemDataSourceArray = @[
                                 @{@"title":@"数码"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"服饰"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"NearByViewController"},
                                 @{@"title":@"出行"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"母婴"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"家具"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"影音"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"收藏"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"网游"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"美容"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},
                                 @{@"title":@"更多"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"TenementViewController"},

                                 ];
    }
    return _itemDataSourceArray;
}



@end
