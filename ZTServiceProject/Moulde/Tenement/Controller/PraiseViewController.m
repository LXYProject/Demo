//
//  PraiseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PraiseViewController.h"
#import "StaticlCell.h"
#import "PraiseTextCell.h"
#import "AddPhotosCell.h"

@interface PraiseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PraiseViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleArray = @[@"联系人:",@"联系电话:"];
    _contentArray = @[@"输入您的姓名", @"输入您的电话"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"表扬" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"提交" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row==0) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.textColor = TEXT_COLOR;
        cell.title.text = @"标题:";
        cell.content.placeholder = @"请输入标题";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
            [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
            [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        PraiseTextCell *cell = (PraiseTextCell *)[self creatCell:tableView indenty:@"PraiseTextCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
    cell.title.textColor = TEXT_COLOR;
    cell.title.text = _titleArray[indexPath.row];
    cell.content.placeholder = _contentArray[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        if (indexPath.row==0) {
            return 44;
        }else{
            return 100;
        }
    }else if (indexPath.section ==1) {
        return 100;
    }else {
        return 44;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}

//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 5;
//}

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

@end
