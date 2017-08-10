//
//  MyReleasedHouseController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyReleasedHouseController.h"
#import "MyReleasedHouseCell.h"
#import "HomeHttpManager.h"

@interface MyReleasedHouseController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//我发布的出租屋 的数据相关的
@property (nonatomic,strong)NSMutableArray *dataSource;//绑定的房屋
@property (nonatomic,assign)NSInteger currentPage;


@end

@implementation MyReleasedHouseController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我发布的出租屋" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];


    self.currentPage = 1;
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        [self reuqestReleaseHouse];
    }];
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        [self reuqestReleaseHouse];
    }];
    [self.tableView beginHeaderRefreshing];

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = @"正在加载";
}

// 我发布的出租屋
- (void)reuqestReleaseHouse{
    @weakify(self);
    [HomeHttpManager requestQueryType:0
                             keywords:@""
                               cityId:@""
                           districtId:@""
                             minPrice:@""
                             maxPrice:@""
                            houseType:@""
                            direction:@""
                              minArea:@""
                              maxArea:@""
                          heatingMode:@""
                                floor:@""
                          hasElevator:@""
                         houseFitment:@""
                      basicFacilities:@""
                   extendedFacilities:@""
                                 sort:@"0"
                              pageNum:self.currentPage
                              success:^(NSArray *response) {
                                  @strongify(self);
                                  [self.tableView endRefreshing];
                                  [_hud hideAnimated:YES];
                                  
                                  if (self.currentPage==1){
                                      [self.dataSource removeAllObjects];
                                  }
                                  [self.dataSource addObjectsFromArray:response];
                                  if (response.count<10) {
                                      [self.tableView endRefreshingWithNoMoreData];
                                  }
                                  [self.tableView reloadData];
                              } failure:^(NSError *error, NSString *message) {
                                  [self.tableView endRefreshing];
                                  _hud.label.text = message;
                                  [_hud hideAnimated:YES];
                              }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
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
    MyReleasedHouseCell *cell = (MyReleasedHouseCell *)[self creatCell:tableView indenty:@"MyReleasedHouseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.section];
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
    
    return 94;
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
