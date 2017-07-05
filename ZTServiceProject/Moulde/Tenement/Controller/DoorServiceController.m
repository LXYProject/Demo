//
//  DoorServiceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DoorServiceController.h"
#import "StaticlCell.h"
#import "StaticOneCell.h"
#import "SolicitingHeadCell.h"
#import "DoorServiceCell.h"
#import "AddPhotosCell.h"
#import "DataPickerViewDemo.h"

@interface DoorServiceController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoorServiceController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSString *_data;
    NSString *_hour;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleArray = @[@"联系人:",@"联系电话:"];
    _contentArray = @[@"输入您的姓名", @"输入您的电话"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"上门服务" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"提交" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1 || section==2) {
        return 2;
    }else {
        return 1;
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
    }else if (indexPath.section ==3) {
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==4) {
        return [self sectionFourTableView:tableView indexPath:indexPath];
    }
    else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"选择房屋";
    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
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

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
        cell.title.textColor = TEXT_COLOR;
        cell.rightContent.textColor = TEXT_COLOR;
        cell.title.text = @"选择类型:";
        cell.rightContent.text = @"选择";
        [cell.content removeFromSuperview];
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
            cell.rightContent.font = [UIFont systemFontOfSize:11];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
            cell.rightContent.font = [UIFont systemFontOfSize:12];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        DoorServiceCell *cell = (DoorServiceCell *)[self creatCell:tableView indenty:@"DoorServiceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
    cell.title.textColor = TEXT_COLOR;
    cell.rightContent.textColor = TEXT_COLOR;
    cell.title.text = @"预约时间:";
    cell.rightContent.text = @"3月2日  14:12";
    cell.rightContent.text = _data;
    cell.rightContent.text = [NSString stringWithFormat:@"%@  %@", _data,_hour];

    if (indexPath.section==3) {
        [cell.content removeFromSuperview];
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
        cell.rightContent.font = [UIFont systemFontOfSize:11];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
        cell.rightContent.font = [UIFont systemFontOfSize:12];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

//第4组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==3) {
        [[DataPickerViewDemo sharedPikerView]show];
        [DataPickerViewDemo sharedPikerView].pikerSelected = ^(NSString *dateStr, NSString *timeStr) {
            NSLog(@"date:%@,time:%@",dateStr,timeStr);
            _data = dateStr;
            _hour = timeStr;
            [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        };
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section ==1) {
        return 44;
    }else if (indexPath.section ==2) {
        if (indexPath.row==0) {
            return 44;
        }else{
            return 100;
        }
    }else if (indexPath.section==3){
        return 44;
    }
    else {
        return 100;
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
