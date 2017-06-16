//
//  SolicitingViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitingViewController.h"
#import "SolicitingHeadCell.h"
#import "SolicitBtnItemCell.h"
#import "BtnItemCell.h"
#import "AddPhotosCell.h"
#import "BabyDescriptionCell.h"

@interface SolicitingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *itemDataSourceArray;

@end

@implementation SolicitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    else if (section==1){
        return 2;
    }
    else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
//    else if (indexPath.section==1){
//        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
//    }else if (indexPath.section==1){
//        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
//    }else if (indexPath.section==1){
//        return [self sectionFourTableView:tableView indexPath:indexPath];
//    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
    if (indexPath.row==0) {
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.title = self.titleArray[indexPath.row];
//    cell.content = self.detailsArray[indexPath.row];
    return cell;
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    SolicitBtnItemCell *cell = (SolicitBtnItemCell *)[self creatCell:tableView indenty:@"SolicitBtnItemCell"];
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    BtnItemCell *cell = (BtnItemCell *)[self creatCell:tableView indenty:@"BtnItemCell"];
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    return cell;
}

//第3组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    
    BabyDescriptionCell *cell = (BabyDescriptionCell *)[self creatCell:tableView indenty:@"BabyDescriptionCell"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 10.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(247, 247, 247);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
//    if (indexPath.section == 0) {
//        return 44;
//    }
//    else if (indexPath.section==1){
//        return 44;
//    }
//    else if (indexPath.section ==2) {
//        return 85;
//    }
//    else {
//        return 100;
//    }
}
- (NSArray *)itemDataSourceArray {
    if(!_itemDataSourceArray) {
        _itemDataSourceArray = @[
                                 @{@"title":@"租金"
                                   ,@"content":@"请填写租金"},
                                 @{@"title":@"户型"
                                   ,@"content":@"请填写户型"},
                                 @{@"title":@"朝向"
                                   ,@"content":@""},

                                 ];
    }
    return _itemDataSourceArray;
}

@end
