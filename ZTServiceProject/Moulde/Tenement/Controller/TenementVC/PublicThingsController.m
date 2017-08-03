//
//  PublicThingsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublicThingsController.h"
#import "SolicitingHeadCell.h"
#import "DoorServiceCell.h"
#import "AddPhotosCell.h"
#import "StaticlCell.h" 
#import "TenementHttpManager.h"
#import "PublicTypeController.h"

@interface PublicThingsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PublicThingsController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSString *_affairDiscribe;
    NSString *_userRealName;
    NSString *_userPhoneNum;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleArray = @[@"联系人:",
                    @"联系电话:"];
    _contentArray = @[@"输入您的姓名",
                      @"输入您的电话"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"公共报事"
                  titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"提交"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
}

- (void)rightBarClick
{
    NSLog(@"提交");
    // 公共报事
    @weakify(self);
    [TenementHttpManager requestZoneId:self.zoneId
                           affairTitle:@""
                        affairDiscribe:_affairDiscribe
                        affairCategory:@"1"
                           userAddress:@"北京市 海淀区 财智大厦 c305室"
                          userRealName:_userRealName
                          userPhoneNum:_userPhoneNum
                                images:[UIImage imageNamed:@""]
                               success:^(id response) {
                                   @strongify(self);
                                   //操作失败的原因
                                   NSString *information = [response objectForKey:@"information"];
                                   //状态码
                                   NSString *status = [response objectForKey:@"status"];
                                   
                                   if ([status integerValue]==0) {
                                       [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                   }else{
                                       [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                   }
                               } failure:^(NSError *error, NSString *message) {
                               }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==4) {
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = @"选择类型";
    cell.detailTextLabel.text = @"请选择类型";
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

//    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
//    cell.title.textColor = TEXT_COLOR;
//    cell.rightContent.textColor = TEXT_COLOR;
//    cell.title.text = @"选择类型:";
//    cell.content.placeholder = @"请选择价格范围";
//    cell.rightContent.text = @"选择";
//    if (IS_IPHONE_4 || IS_IPHONE_5) {
//        cell.title.font = [UIFont systemFontOfSize:13];
//        cell.rightContent.font = [UIFont systemFontOfSize:11];
//        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
//    }else{
//        cell.title.font = [UIFont systemFontOfSize:14];
//        cell.rightContent.font = [UIFont systemFontOfSize:12];
//        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    DoorServiceCell *cell = (DoorServiceCell *)[self creatCell:tableView indenty:@"DoorServiceCell"];
    cell.textViewBlock = ^(id obj) {
        NSLog(@"obj==%@", obj);
        _affairDiscribe = obj;
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"位置选择";
    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = [UIColor grayColor];
    return cell;
    
}

//第4组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
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
    if (indexPath.row==0) {
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userRealName = obj;
        };
    }else{
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userPhoneNum = obj;
        };
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section==0) {
        @weakify(self);
        [PushManager pushViewControllerWithName:@"PublicTypeController" animated:YES block:^(PublicTypeController* viewController) {
            @strongify(self);
            viewController.zoneId = self.zoneId;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section==4) {
        return 44;
    }else if (indexPath.section ==3) {
        return 49;
    }else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return 0.f;
//    }else{
//        return 5.f;
//    }
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    view.backgroundColor = RGB(247, 247, 247);
//    return view;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footView = [[UIView alloc] init];
//    footView.backgroundColor = [UIColor clearColor];
//    return footView;
//}
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 1;
//}

@end
