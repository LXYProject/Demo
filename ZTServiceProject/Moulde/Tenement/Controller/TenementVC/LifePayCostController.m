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

@interface LifePayCostController ()

//查看所有与我有关的房屋 的数据相关的
@property (nonatomic,strong)NSMutableArray *bindHousesDataSource;//绑定的房屋

@property (nonatomic,strong) TOPageTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray<TOPageItem *> *titles;

@end

@implementation LifePayCostController

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
@end
