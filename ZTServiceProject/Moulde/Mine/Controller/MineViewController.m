//
//  MineViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MineViewController.h"
#import "MineBtnCell.h"

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController
{
    NSArray *_sectionOneTitle;
    NSArray *_sectionTwoTitle;
    NSArray *_sectionOneImg;
    NSArray *_sectionTwoImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = nil;
    self.navigationBarBackGroudColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [Tools createImageWithColor:[UIColor clearColor]];
    [self createTableview];
    
    _sectionOneTitle = @[@"我的消息", @"我的邻里圈", @"我的发布"];
    _sectionTwoTitle = @[@"我的房屋", @"我的小区"];
    _sectionOneImg = @[@"message_tabbar_default",@"message_tabbar_selected", @"my_tabbar_default"];
    _sectionTwoImg= @[@"message_tabbar_default",@"message_tabbar_selected"];
    
    [self rightBarButtomItemWithNormalName:@"warn_40px" highName:@"warn_40px" selector:@selector(rightBarClick) target:self];
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}
- (void)createTableview
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGB(247, 247, 247);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    headerView.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    //头像
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, headerView.frame.size.height/2-40, 100, 100)];
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = headImage.bounds.size.width * 0.5;
    headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headImage.image = [UIImage imageNamed:@"Oval 3 Copy"];
//    NSString *stringUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoto"];
//    NSURL *url = [NSURL URLWithString:stringUrl];
//    [headImage sd_setImageWithURL:url placeholderImage:nil];
    [headerView addSubview:headImage];
    
    
    //登录注册按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(SCREEN_WIDTH/2-50, headImage.frame.origin.y+100, 100, 25);
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:loginBtn];
    
    _tableView.tableHeaderView =headerView;
    _tableView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:_tableView];

}
- (void)loginBtnClick
{
    NSLog(@"loginBtnClick");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
    }else if (section==2){
        return 2;
    }else
        return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        MineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBtnCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MineBtnCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    }else if (indexPath.section==1){
        cell.textLabel.text = _sectionOneTitle[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_sectionOneImg[indexPath.row]];


    }else if (indexPath.section==2){
        cell.textLabel.text = _sectionTwoTitle[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_sectionTwoImg[indexPath.row]];
    }else{
        cell.textLabel.text = @"我的好友";
        cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    }
    if (IS_IPHONE_6){
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }else if (IS_IPHONE_6p){
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }else{
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }else{
        return 45;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
