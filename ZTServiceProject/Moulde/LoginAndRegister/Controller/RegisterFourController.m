//
//  RegisterFourController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterFourController.h"
#import "RegisterHeadCell.h"

#define btnY 420
@interface RegisterFourController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RegisterFourController
{
    NSArray *_sectionOneArr;
    NSArray *_sectionTwoArr;
    NSArray *_sectionThreeArr;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"个人信息" titleColor:[UIColor whiteColor]];


    _sectionOneArr = @[@"昵称", @"性别", @"生日"];
    _sectionTwoArr = @[@"个性签名", @"家乡"];
    _sectionThreeArr = @[@"联系方式", @"我的地址"];
    
    [self createUI];
}

- (void)createUI
{
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, btnY, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    [submitBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];
}

- (void)submitClick
{
    NSLog(@"立即体验");
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else{
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        if (indexPath.section==1) {
            cell.textLabel.text = _sectionOneArr[indexPath.row];
        }else if (indexPath.section==2){
            cell.textLabel.text = _sectionTwoArr[indexPath.row];
        }else{
            cell.textLabel.text = _sectionThreeArr[indexPath.row];
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }
        cell.detailTextLabel.text = @"hhh";
        cell.textLabel.textColor = TEXT_COLOR;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }

}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    RegisterHeadCell *cell = (RegisterHeadCell *)[self creatCell:tableView indenty:@"RegisterHeadCell"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
           [PushManager pushViewControllerWithName:@"ChangeNickNameController" animated:YES block:nil];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return 72;
    }else{
        return 44;
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

@end
