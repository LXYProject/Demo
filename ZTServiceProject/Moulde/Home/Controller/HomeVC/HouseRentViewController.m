//
//  HouseRentViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HouseRentViewController.h"
#import "HouseRentCell.h"
#import "HomeHttpManager.h"
#import "RentHouseModel.h"
@interface HouseRentViewController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//租房查询 的数据相关的
@property (nonatomic,strong)NSMutableArray *rentHouseDataSource;
@property (nonatomic,assign)NSInteger currentPage;


@end

@implementation HouseRentViewController
{
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    RentHouseModel *model = [[RentHouseModel alloc]init];
//    model.basicFacilities = @[@"asd",@"asd",@"asdsad"];
//    model.extendedFacilities = @[@"asd",@"asd",@"asdsad"];
//    model.rentLimit = @[@"asd",@"asd",@"asdsad"];
//    [self.rentHouseDataSource addObject:model];
//    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
    
    [self titleViewWithTitle:@"房屋租赁" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"搜索"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    self.currentPage = 1;
    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        [self requestRentHouseData];
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        [self requestRentHouseData];
    }];
    [self.tableView beginHeaderRefreshing];
    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

//请求租房查询
- (void)requestRentHouseData{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    @weakify(self);
    [HomeHttpManager requestQueryType:2
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
                                  [_hud hide:YES];
                                  
                                  if (self.currentPage==1){
                                      [self.rentHouseDataSource removeAllObjects];
                                  }
                                  [self.rentHouseDataSource addObjectsFromArray:response];
                                  if (response.count<10) {
                                      [self.tableView endRefreshingWithNoMoreData];
                                  }
                                  [self.tableView reloadData];
                              } failure:^(NSError *error, NSString *message) {
                                  [self.tableView endRefreshing];
                                  _hud.labelText = message;
                                  [_hud hide:YES];
                              }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rentHouseDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    HouseRentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HouseRentCell" owner:self options:nil] lastObject];
    }
    cell.rentHouseModel = self.rentHouseDataSource[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSMutableArray *)rentHouseDataSource {
    if (!_rentHouseDataSource) {
        _rentHouseDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _rentHouseDataSource;
}

@end
