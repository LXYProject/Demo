//
//  LifePayCostController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LifePayCostController.h"
#import "MineHttpManager.h"
#import "MyHouseModel.h"
#import "TOPageTitleView.h"

@interface LifePayCostController ()<UITableViewDelegate, UITableViewDataSource>

//查看所有与我有关的房屋 的数据相关的
@property (nonatomic,strong)NSMutableArray *bindHousesDataSource;//绑定的房屋

@property (nonatomic,strong) TOPageTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray<TOPageItem *> *titles;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LifePayCostController
{
    NSArray *_titleArr;
    NSArray *_detailArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"生活缴费" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"缴费历史"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    [self requestLookAllHouseWithMe];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _titleArr = @[@"水费", @"电费", @"天然气费"];
    _detailArr = @[@"账单号|*用户名", @"电费", @"天然气费"];
}

- (void)rightBarClick{
    [PushManager pushViewControllerWithName:@"PaymentHistoryController" animated:YES block:nil];
}

- (void)createTitlesView{
    for (int i=0; i<self.bindHousesDataSource.count; i++) {
        [self.dataSource addObject:[TOPageItem itemWithTitle:[self.bindHousesDataSource[i] title]]];
    }
    self.titleView.titles = self.titles;
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.titleView];
}
// 查看所有与我有关的房屋
- (void)requestLookAllHouseWithMe{
    @weakify(self);
    [MineHttpManager requesHouseAddVillage:House
                                   success:^(NSDictionary* response) {
                                       @strongify(self);
                                       
                                       NSMutableArray *bindHouseArray = [MyHouseModel mj_objectArrayWithKeyValuesArray:response[@"bindHouses"]];
                                       
                                       [self.bindHousesDataSource addObjectsFromArray:bindHouseArray];
                                       
                                       // 创建 TitlesView
                                       [self createTitlesView];

                                       
                                   } failure:^(NSError *error, NSString *message) {
                                   }];
}


- (NSArray *)bindHousesDataSource {
    if (!_bindHousesDataSource) {
        _bindHousesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _bindHousesDataSource;
}

#pragma mark - Getter
- (TOPageTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[TOPageTitleView alloc] init];
        _titleView.miniGap = 20;
    }
    return _titleView;
}
- (NSMutableArray<TOPageItem *> *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:self.dataSource];
    }
    return _titles;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, SCREEN_HEIGHT-100) style:UITableViewStylePlain];
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.detailTextLabel.text = @"账单号|*用户名";
    cell.textLabel.textColor = TEXT_COLOR;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [PushManager pushViewControllerWithName:@"PayAccountInfoController" animated:YES block:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
@end
