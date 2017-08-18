//
//  PersonalDataController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PersonalDataController.h"
#import "PersonalDataHeadCell.h"
#import "NumberOfPostsCell.h"
#import "PostCollectionViewCell.h"
#import "ChatViewController.h"
#import "LoginHttpManager.h"

@interface PersonalDataController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonalDataController
{
    NSArray *_sectionTitleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"个人资料" titleColor:[UIColor whiteColor]];

    _sectionTitleArr = @[@"账号信息:", @"ZT号:", @"账号等级:", @"注册日期:"];
    
}

//通过手机号查询用户信息
- (void)request{
    [LoginHttpManager requestPhone:@""
                           success:^(id response) {
                           
                           } failure:^(NSError *error, NSString *message) {
                           
                           }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if(indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    PersonalDataHeadCell *cell = (PersonalDataHeadCell *)[self creatCell:tableView indenty:@"PersonalDataHeadCell"];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        NumberOfPostsCell *cell = (NumberOfPostsCell *)[self creatCell:tableView indenty:@"NumberOfPostsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        PostCollectionViewCell *cell = (PostCollectionViewCell *)[self creatCell:tableView indenty:@"PostCollectionViewCell"];
        //cell.model = self.secondCellDataSource;
        return cell;
    }

    
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
    cell.textLabel.text = _sectionTitleArr[indexPath.row];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 66;

    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            return 44;
        }else{
            return 105;
        }
    }else{
        return 44;
    }
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
- (IBAction)focusOnBtn {
    NSLog(@"关注");
}
- (IBAction)dialogueBtn {
    NSLog(@"对话");
    [PushManager pushViewControllerWithName:@"ChatViewController" animated:YES block:^(ChatViewController* viewController) {
        viewController.titleStr = self.titleStr;
    }];
}

@end
