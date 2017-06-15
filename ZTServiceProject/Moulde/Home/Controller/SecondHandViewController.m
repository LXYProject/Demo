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

@interface SecondHandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *itemDataSourceArray;

@end

@implementation SecondHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 2;
    }else{
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
    }else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchHeadCell *cell = (SearchHeadCell *)[self creatCell:tableView indenty:@"SearchHeadCell"];
        //        cell.modelArray = imageNames;
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
//    return nil;
}



//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
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
//                                 @{@"title":@"美容"
//                                   ,@"icon":@"order_tabbar_selected"
//                                   ,@"vcName":@"TenementViewController"},
//                                 @{@"title":@"更多"
//                                   ,@"icon":@"order_tabbar_selected"
//                                   ,@"vcName":@"TenementViewController"},

                                 ];
    }
    return _itemDataSourceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
