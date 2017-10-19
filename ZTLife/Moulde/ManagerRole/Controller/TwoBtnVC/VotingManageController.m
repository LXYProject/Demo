//
//  VotingManageController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VotingManageController.h"
#import "VotingManageCell.h"

@interface VotingManageController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;//绑定的房屋
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation VotingManageController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"投票管理" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
//    self.currentPage = 1;
//    [self.tableView setHeaderRefreshBlock:^{
//        self.currentPage = 1;
//        [self requestPublishedService];
//    }];
//    [self.tableView setFooterRefreshBlock:^{
//        self.currentPage++;
//        [self requestPublishedService];
//    }];
//    [self.tableView beginHeaderRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return self.dataSource.count;
    return 2;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    VotingManageCell *cell = (VotingManageCell *)[self creatCell:tableView indenty:@"VotingManageCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.serviceModel = self.dataSource[indexPath.section];
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
    
    return 100;
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

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
