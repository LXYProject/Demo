//
//  ReleaseHelpController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseHelpController.h"
#import "AddPhotosCell.h"
#import "NearByHttpManager.h"

#define LabelY 405
@interface ReleaseHelpController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReleaseHelpController
{
    NSArray *_sectionOneArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"发布求助" titleColor:[UIColor whiteColor]];
    
    _sectionOneArr = @[@"我要", @"描述", @"赏金", @"我在", @"求助类型", @"有效期至"];
    
    [self createLabel];
}

- (void)createLabel{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, LabelY, 250, 40);
    label.text = @"同意《正图生活平台服务者入住协议》";
    label.textColor = UIColorFromRGB(0xe64e51);
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        label.font = [UIFont systemFontOfSize:11];
    }else{
        label.font = [UIFont systemFontOfSize:12];
    }
    [self.tableView addSubview:label];
}
- (IBAction)releaseBtnClick {
    
    // 发布
    [NearByHttpManager rqeuestTitle:@""
                            content:@""
                            address:@""
                              price:@""
                         categoryId:@""
                       categoryName:@""
                          validDate:@""
                             cityId:@""
                         districtId:@""
                                  x:@""
                                  y:@""
                              resId:@""
                            resName:@""
                             images:@""
                            success:^(id response) {
                            
                            } failure:^(NSError *error, NSString *message) {
                            
                            }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
}


//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    return cell;
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(80, 13, 220, 30);
    [cell.contentView addSubview:textField];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.frame = CGRectMake(80, 0, 220, 50);
    [cell.contentView addSubview:detailLabel];
    cell.textLabel.text = _sectionOneArr[indexPath.row];
    if (indexPath.row==0) {
        textField.placeholder = @"我需要别人帮我做什么";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row==1){
        textField.hidden = YES;
        detailLabel.text = @"说一下具体的求助信息，清楚明确的";
    }else if (indexPath.row==2){
        textField.placeholder = @"我愿意支付的报酬（单位元）";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row==3){
        textField.hidden = YES;
        detailLabel.text = @"选择服务地点";
    }else if (indexPath.row==4){
        textField.hidden = YES;
        detailLabel.text = @"请选择";
        detailLabel.frame = CGRectMake(SCREEN_WIDTH-80, 0, 100, 50);
    }else{
        textField.hidden = YES;
        detailLabel.text = @"为求助选择一个截止时间";
        detailLabel.frame = CGRectMake(SCREEN_WIDTH-180, 0, 150, 50);
    }
    if (indexPath.row==0 || indexPath.row==2) {
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.font = [UIFont systemFontOfSize:11];
        [textField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.font = [UIFont systemFontOfSize:12];
        [textField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    detailLabel.textColor = UIColorFromRGB(0xb2b2b2);
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
        }else if (indexPath.row==1){
            
        }else if (indexPath.row==2){
            
        }else if (indexPath.row==3){
            
        }else if (indexPath.row==4){
            [PushManager pushViewControllerWithName:@"SelectHelpTypeController" animated:YES block:nil];
        }else{
            
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 100;
    }else{
        return 50;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
@end
