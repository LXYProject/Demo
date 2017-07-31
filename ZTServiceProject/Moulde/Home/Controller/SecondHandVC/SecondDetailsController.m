//
//  SecondDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondDetailsController.h"
#import "SecondBannerCell.h"
#import "SecondDetailsCell.h"
#import "SecondBtnItemCell.h"
#import "SecondUserCell.h"  
#import "SecondAddressCell.h"
#import "CommentsHeadCell.h"
#import "CommentContentCell.h"
#import "SecondHandModel.h"
#import "CommentInfoCell.h"


@interface SecondDetailsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondDetailsController
{
    NSArray *imageNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                   ];
    
    [self titleViewWithTitle:@"二手物品详情" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"搜索" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondDetailsCell" bundle:nil] forCellReuseIdentifier:@"SecondDetailsCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentInfoCell" bundle:nil] forCellReuseIdentifier:@"CommentInfoCell"];

}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section==2){
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
//    else if (indexPath.section==3){
//        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
//    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SecondBannerCell *cell = (SecondBannerCell *)[self creatCell:tableView indenty:@"SecondBannerCell"];
        cell.secondModelArray = self.model.secondHandNormalImageList;
        return cell;
    }else if (indexPath.row==1){
        SecondDetailsCell *cell = (SecondDetailsCell *)[self creatCell:tableView indenty:@"SecondDetailsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if (indexPath.row==2){
        SecondUserCell *cell = (SecondUserCell *)[self creatCell:tableView indenty:@"SecondUserCell"];
        cell.model = self.model;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        SecondAddressCell *cell = (SecondAddressCell *)[self creatCell:tableView indenty:@"SecondAddressCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    SecondBtnItemCell *cell = (SecondBtnItemCell *)[self creatCell:tableView indenty:@"SecondBtnItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {

    if (indexPath.row==0) {
        CommentsHeadCell *cell = (CommentsHeadCell *)[self creatCell:tableView indenty:@"CommentsHeadCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==1){
        CommentContentCell *cell = (CommentContentCell *)[self creatCell:tableView indenty:@"CommentContentCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
//        NSArray *commentList = self.model.commentList;
//        cell.model = commentList[indexPath.row-2];

        return cell;
    }
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
        return 5.f;
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
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 270;
        }else if (indexPath.row==1){
                return [tableView fd_heightForCellWithIdentifier:@"SecondDetailsCell" configuration:^(SecondDetailsCell* cell) {
                    cell.model = self.model;
                }];
        }
        else{
            return 44;
        }
    }else if (indexPath.section==1){
        return 44;
    }
    else{
        if (indexPath.row==0) {
            return 44;
        }else if(indexPath.row==1){
            return 65;
        }else{
//            return  [tableView fd_heightForCellWithIdentifier:@"CommentInfoCell" cacheByIndexPath:indexPath configuration:^(CommentInfoCell* cell) {
//                NSArray *commentList = self.model.commentList;
//                cell.model = commentList[indexPath.row-2];
//            }];
            return 0;

        }
    }
}

@end
