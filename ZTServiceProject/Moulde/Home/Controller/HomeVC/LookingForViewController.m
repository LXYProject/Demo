//
//  LookingForViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LookingForViewController.h"
#import "StaticlCell.h"
#import "StaticOneCell.h"
#import "BtnItemCell.h"
#import "AddPhotosCell.h"
#import "BabyDescriptionCell.h"

@interface LookingForViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LookingForViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSArray *_titleOneArray;
    NSArray *_contentOneArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"求购" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    
    _titleArray = @[@"物品名称：",
                    @"品牌型号："];
    _contentArray = @[@"请输入物品的名称",
                      @"请输入品牌的型号"];
    _titleOneArray = @[@"新旧程度：",
                       @"价格范围："];
    _contentOneArray = @[@"八成新",
                         @"1000-2000"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 4;
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
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }
    else{
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0 || indexPath.row==1) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        if (indexPath.row==0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
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

    }else{
        StaticOneCell *cell = (StaticOneCell *)[self creatCell:tableView indenty:@"StaticOneCell"];
        cell.titleLabel.textColor = TEXT_COLOR;
        cell.contentLabel.textColor = TEXT_COLOR;
        cell.titleLabel.text = _titleOneArray[indexPath.row-2];
        cell.contentLabel.text = _contentOneArray[indexPath.row-2];
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.titleLabel.font = [UIFont systemFontOfSize:13];
            cell.contentLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.titleLabel.font = [UIFont systemFontOfSize:14];
            cell.contentLabel.font = [UIFont systemFontOfSize:12];
        }
        return cell;
    }
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    BtnItemCell *cell = (BtnItemCell *)[self creatCell:tableView indenty:@"BtnItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    BabyDescriptionCell *cell = (BabyDescriptionCell *)[self creatCell:tableView indenty:@"BabyDescriptionCell"];
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
            return 44;
    }
    else if (indexPath.section ==1) {
        return 85;
    }
    else {
        return 100;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 5.f;
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 5;
//}

@end
