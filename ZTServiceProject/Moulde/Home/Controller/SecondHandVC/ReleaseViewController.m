//
//  ReleaseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/19.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseViewController.h"
#import "AddPhotosCell.h"
#import "SolicitingHeadCell.h"
#import "BabyDescriptionCell.h"
#import "SwitchCell.h"
#import "HomeHttpManager.h"

//#define btnY 440
//#define labelY 428
//#define btnX 15
#define btnY 542
#define labelY 530
#define btnX 15
@interface ReleaseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReleaseViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSArray *_switchArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
    _titleArray = @[@"宝贝标题",
                    @"分类",
                    @"现价"];
    _contentArray = @[@"请选择新旧程度",
                      @"",
                      @"请选择新旧程度"];
    _switchArray = @[@"",
                     @"支持快递",
                     @"原价"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"发布宝贝" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布须知" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    [self createUI];
}
- (void)rightBarClick
{
    NSLog(@"二手物品发布");
    [HomeHttpManager requestTitle:@""
                          content:@""
                         pictures:@""
                           cityId:@""
                       districtId:@""
                          address:@""
                            resId:@""
                          resName:@""
                                x:@""
                                y:@""
                         oriPrice:@""
                         secPrice:@""
                         delivery:@""
                          classId:@""
                         newOrOld:@""
                          success:^(id response) {
                              
                          } failure:^(NSError *error, NSString *message) {
                              
                          }];

}

- (void)createUI
{
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake(btnX, btnY, 15, 15);
    [chooseBtn setImage:[UIImage imageNamed:@"否@3x"] forState:UIControlStateNormal];
    [chooseBtn setImage:[UIImage imageNamed:@"是@3x"] forState:UIControlStateSelected];
    [chooseBtn addTarget:self action:@selector(styleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:chooseBtn];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(btnX+10+15, labelY, 200, 40);
    label.text = @"在邻里圈展示, 曝光更多卖更快哦~";
    label.textColor = TEXT_COLOR;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        label.font = [UIFont systemFontOfSize:11];
    }else{
        label.font = [UIFont systemFontOfSize:12];
    }
    [self.tableView addSubview:label];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, labelY+40, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    [submitBtn setTitle:@"发布" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];
    
}

- (void)submitCLick
{
    NSLog(@"submitCLick");
}
- (void)styleBtnClick:(UIButton *)button{
    button.selected = !button.selected;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section==2) {
        return 1;
    }else if (section==1){
        return 4;
    }
    else{
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
    }else if (indexPath.section==3){
        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==3) {
        BabyDescriptionCell *cell = (BabyDescriptionCell *)[self creatCell:tableView indenty:@"BabyDescriptionCell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    
    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
    cell.title.text = [NSString stringWithFormat:@"%@:", _titleArray[indexPath.row]];
    cell.content.placeholder = _contentArray[indexPath.row];
    if (indexPath.row==1) {
        cell.rightContent.text = @"其他";
        cell.content.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [cell.rightContent removeFromSuperview];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
        cell.rightContent.font = [UIFont systemFontOfSize:13];
        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
        cell.rightContent.font = [UIFont systemFontOfSize:14];
        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    cell.title.textColor = TEXT_COLOR;
    cell.rightContent.textColor = TEXT_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"请选择位置信息";
    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
    
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
        cell.title.text = @"新旧:";
        cell.content.placeholder = @"请选择价格范围";
        cell.rightContent.text = @"九成新";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
            cell.rightContent.font = [UIFont systemFontOfSize:13];
            [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
            cell.rightContent.font = [UIFont systemFontOfSize:14];
            [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        }
        cell.title.textColor = TEXT_COLOR;
        cell.rightContent.textColor = TEXT_COLOR;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        SwitchCell *cell = (SwitchCell *)[self creatCell:tableView indenty:@"SwitchCell"];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@:", _switchArray[indexPath.row]];
        if (indexPath.row==1) {
            [cell.details removeFromSuperview];
        }else{
            cell.details.placeholder = @"请选择新旧程度";
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.titleLabel.font = [UIFont systemFontOfSize:13];
            [cell.details setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell.details setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        }
        cell.titleLabel.textColor = TEXT_COLOR;
        
//        CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
//        CGRect rect = [self.tableView convertRect:rectInTableView toView:[tableView superview]];
//        _lanelY = rect.origin.y;
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==1) {
            [PushManager pushViewControllerWithName:@"ReleaseClassifiedController" animated:YES block:nil];
        }
    }
    if (indexPath.section==2) {
        [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:nil];
    }
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
    
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section ==1) {
        if (indexPath.row==3) {
            return 100;
        }else{
            return 44;
        }
    }else {
        return 44;
    }
}

@end
