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
#import "ItemMoreViewController.h"
#import "SecondHeadCell.h"

@interface SecondHandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *itemDataSourceArray;
//collectView 的数据相关的
@property (nonatomic,strong)NSArray *secondCellDataSource;
@property (nonatomic,assign)NSInteger secondCellCurrentPage;

@end

@implementation SecondHandViewController
{
    ItemMoreViewController *_itemMoreVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.secondCellCurrentPage = 1;

    [self titleViewWithTitle:@"二手物品" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    [self requestDataSecondCellData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
    
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
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
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
    else if (indexPath.section==3){
    return [self sectionThirdrdTableView:tableView indexPath:indexPath];
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
            _itemMoreVC.itemTitle = self.itemDataSourceArray[value][@"title"];
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

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    SecondHeadCell *cell = (SecondHeadCell *)[self creatCell:tableView indenty:@"SecondHeadCell"];
//    cell.model = self.secondCellDataSource;
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
        return 44;
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
                                   ,@"icon":@"home_eswp_smcp"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"服饰"
                                   ,@"icon":@"home_eswp_fzxm"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"出行"
                                   ,@"icon":@"home_eswp_jtgj"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"母婴"
                                   ,@"icon":@"home_eswp_myyp"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"家具"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"影音"
                                   ,@"icon":@"home_eswp_tsyx"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"收藏"
                                   ,@"icon":@"home_eswp_yssc"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"网游"
                                   ,@"icon":@"home_eswp_wyxn"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"美容"
                                   ,@"icon":@"home_eswp_mrbj"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"更多"
                                   ,@"icon":@"order_tabbar_selected"
                                   ,@"vcName":@"ItemMoreViewController"},

                                 ];
    }
    return _itemDataSourceArray;
}



@end
