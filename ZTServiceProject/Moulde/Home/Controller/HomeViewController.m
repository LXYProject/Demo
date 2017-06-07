//
//  HomeViewController.m
//  Aa
//
//  Created by 张圆圆 on 17/6/5.
//  Copyright © 2017年 张圆圆. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerHeaderCell.h"
#import "ItemBtnCell.h"
#import "NearByServiceCell.h"
#import "SectionHeaderCell.h"
#import "ProductItemCell.h"
#import "NearByHeaderCell.h"
#import "HomeHttpManager.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *itemDataSourceArray;
@property (nonatomic,strong)NSArray *notificationNewsArray;
@property (nonatomic,assign)NSInteger nearBySelectIndex;
@property (nonatomic,strong)NSArray *imageURLArray;
@end

@implementation HomeViewController
{
    NSArray *imageNames;
    NSArray *noticeNews;
    NSInteger _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _nearBySelectIndex = 0;
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                    ];
    //数据源标题
    noticeNews = @[@"通知1",@"通知2",@"通知3",@"通知4",@"通知5",@"通知6"];
    
    [self requestBanner];
}

//请求广告图
- (void)requestBanner {
    @weakify(self);
    [HomeHttpManager requestBanner:Home_Banner city:@"" zoneId:@"" success:^(NSArray * response) {
        @strongify(self);
        self.imageURLArray = response;
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error, NSString *message) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 2;
    }
    else if (section == 1) {
        return 1;
    }
    else if (section ==2 ){
        return 3;
    }
    else if (section == 3) {
        return 1;
    }
    else if (section == 4) {
        return 1;
    }
    else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==3) {
        return nil;
    }
    else if (indexPath.section ==4) {
        return nil;
    }
    else {
        return nil;
    }
    
}
//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BannerHeaderCell *cell = (BannerHeaderCell *)[self creatCell:tableView indenty:@"BannerHeaderCell"];
        cell.modelArray = imageNames;
//        cell.modelArray = self.imageURLArray;
        return cell;
    }
    else {
        ItemBtnCell *cell = (ItemBtnCell *)[self creatCell:tableView indenty:@"ItemBtnCell"];
        cell.titleAndImageDictArray = self.itemDataSourceArray;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath {
    SectionHeaderCell *cell = (SectionHeaderCell *)[self creatCell:tableView indenty:@"SectionHeaderCell"];
    cell.notificationNews = self.notificationNewsArray;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                      indexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        NearByHeaderCell *cell = (NearByHeaderCell *)[self creatCell:tableView indenty:@"NearByHeaderCell"];
        return cell;
    }
    else if (indexPath.row==1) {
        NearByServiceCell *cell = (NearByServiceCell *)[self creatCell:tableView indenty:@"NearByServiceCell"];
        cell.selectIndex = self.nearBySelectIndex;
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            self.nearBySelectIndex = value;
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        return cell;
    }
    else {
        ProductItemCell *cell = (ProductItemCell *)[self creatCell:tableView indenty:@"ProductItemCell"];
        return cell;
    }
    
    
    
}

//第3组
- (void)sectionZeroThirdTableView:(UITableView *)tableView
                        indexPath:(NSIndexPath *)indexPath {
    
}

//第4组
- (void)sectionFourWithTableView:(UITableView *)tableView
                       indexPath:(NSIndexPath *)indexPath {
    
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
            return 160;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
    else if (indexPath.section ==1) {
        return 44;
    }
    else if (indexPath.section ==2) {
        if (indexPath.row<=1) {
            return 44;
        }
        return 120;
    }
    else if (indexPath.section ==3) {
        return 0;
    }
    else if (indexPath.section ==4) {
        return 0;
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
                                 @{@"title":@"二手物品"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"求购"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"房屋租赁"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"求租"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"我的小区"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"我的房屋"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"物业"
                                   ,@"icon":@"order_tabbar_selected"},
                                 @{@"title":@"生活缴费"
                                   ,@"icon":@"order_tabbar_selected"},
                                 ];
    }
    return _itemDataSourceArray;
}

- (NSArray *)notificationNewsArray {
    if(!_notificationNewsArray){
        _notificationNewsArray = @[@"今天天机打了肯德基埃里克森",@"啊实打实大会",@"实打实大所",@"撒大声地",@"奥术大师多"];
    }
    return _notificationNewsArray;
 }


@end
