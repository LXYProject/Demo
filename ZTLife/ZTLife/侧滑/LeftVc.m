//
//  LeftVc.m
//  CyhSlider
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LeftVc.h"
#import "subVC.h"
#import "MainVC.h"
#import "CyhSliderVC.h"
#import "LoginViewController.h"

@interface LeftVc ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation LeftVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = RGB(247, 247, 247);
    self.tableView.backgroundColor = RGB(247, 247, 247);
    self.tableView.tableFooterView = [[UIView alloc]init];

//    UIImageView * bgimageview = [[UIImageView alloc] initWithFrame:self.view.frame];
//    bgimageview.image = [UIImage imageNamed:@"timg.jpeg"];
//    [self.view addSubview:bgimageview];
    
    self.titleArr = @[@"使用指南", @"我的消息", @"版本消息", @"我的奖励", @"考勤签到", @"设置"];
    [self createTableview];
    [self createHeadView];
    
}


- (void)createTableview
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,100, self.view.frame.size.width *2/3, self.view.frame.size.height - 400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];

    [self.view addSubview:self.tableView];
}


- (void)createHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width *2/3, 100)];
    headView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headView];
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.frame = CGRectMake(15, 25, 50, 50);
    headBtn.backgroundColor = [UIColor redColor];
    //设置圆角
    headBtn.layer.cornerRadius = headBtn.frame.size.width / 2;
    //将多余的部分切掉
    headBtn.layer.masksToBounds = YES;
    [headBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:headBtn];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 150, 20)];
    headLabel.text = @"登录/账户激活";
    [headView addSubview:headLabel];
}

- (void)headBtnClick{
    NSLog(@"头像");
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [[CyhSliderVC initCyhslider] pushSubvc:loginVC];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    subVC * svc = [[subVC alloc] init];
    svc.showtext = @[@"跳转到下一页了"];
    //这里跳转需要调用方法跳转，不能直接跳转，否者。。。，想知道试一下你就知道了
    [[CyhSliderVC initCyhslider] pushSubvc:svc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
