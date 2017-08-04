//
//  PublishServiceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublishServiceController.h"
#import "AddPhotosCell.h"
#import "PublishServiceCell.h"
#import "NearByHttpManager.h"

#define  placeholderColor   [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]
#define LabelY 615
@interface PublishServiceController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PublishServiceController
{
    NSArray *_sectionOneArr;
    NSArray *_sectionTwoArr;
    NSArray *_sectionThreeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"发布服务" titleColor:[UIColor whiteColor]];
    
    _sectionOneArr = @[@"我能", @"描述", @"我在"];
    _sectionTwoArr = @[@"价格", @"单位", @"服务类型", @"服务范围"];
    _sectionThreeArr = @[@"用地图详细描述你的服务", @"请选择地理位置"];
    
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
                             online:@""
                              price:@""
                               unit:@""
                         categoryId:@""
                       categoryName:@""
                               area:@""
                             cityId:@""
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
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
    UITextField *serverField = [[UITextField alloc] init];
    serverField.frame = CGRectMake(80, 13, 180, 30);
    [serverField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:serverField];
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.frame = CGRectMake(80, 0, 180, 50);
    [cell.contentView addSubview:detailLabel];
    cell.textLabel.text = _sectionOneArr[indexPath.row];
    if (indexPath.row==0) {
        serverField.placeholder = @"为自己的服务起一个响亮的名字";
    }else{
        serverField.hidden =  YES;
        detailLabel.text = _sectionThreeArr[indexPath.row-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.font = [UIFont systemFontOfSize:11];
        [serverField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.font = [UIFont systemFontOfSize:12];
        [serverField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    detailLabel.textColor = UIColorFromRGB(0xb2b2b2);
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        PublishServiceCell *cell = (PublishServiceCell *)[self creatCell:tableView indenty:@"PublishServiceCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(80, 13, 180, 30);
        [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [cell.contentView addSubview:textField];
        cell.textLabel.text = _sectionTwoArr[indexPath.row-1];
        if (indexPath.row==0 || indexPath.row==1) {
            textField.placeholder = @"请输入服务的价格（元）";
        }else{
            textField.hidden = YES;
            cell.detailTextLabel.text = @"请选择";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
            [textField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            [textField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];

        }
        cell.textLabel.textColor = TEXT_COLOR;
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
    
    if (indexPath.section==0) {
        
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            [PushManager pushViewControllerWithName:@"ServiceDescriptionController" animated:YES block:nil];
        }else{
            [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:nil];
        }
    }else{
        if (indexPath.row==0 || indexPath.row==1) {
            
        }else if (indexPath.row==2){
            [PushManager pushViewControllerWithName:@"ServiceUnitController" animated:YES block:nil];
        }else if (indexPath.row==3){
            [PushManager pushViewControllerWithName:@"SelectServiceTypeController" animated:YES block:nil];
        }else{
            
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return 100;
    }else if(indexPath.section==1){
        return 50;
    }else{
        if (indexPath.row==0) {
            return 150;
        }else{
            return 50;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

@end
