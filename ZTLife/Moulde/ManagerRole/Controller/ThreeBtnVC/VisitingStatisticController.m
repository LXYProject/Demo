//
//  VisitingStatisticController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VisitingStatisticController.h"
#import "QZConditionFilterView.h"
#import "UIView+Extension.h"
#import "VisitingStatisticCell.h"

@interface VisitingStatisticController ()
{
    // *存储* 网络请求url中的筛选项 数据来源：View中_dataSource1或者一开始手动的初值
    NSArray *_selectedDataSource1Ary;
    NSArray *_selectedDataSource2Ary;
    NSArray *_selectedDataSource3Ary;
    
    QZConditionFilterView *_conditionFilterView;
}
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation VisitingStatisticController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"来访统计" titleColor:[UIColor whiteColor]];

    [self createHeadView];
}

// 创建头视图
- (void)createHeadView{
    // 设置初次加载显示的默认数据
    _selectedDataSource1Ary = @[@"类型"];
    _selectedDataSource2Ary = @[@"时间"];
    _selectedDataSource3Ary = @[@"排序"];
    
    _conditionFilterView = [QZConditionFilterView conditionFilterViewWithFilterBlock:^(BOOL isFilter, NSArray *dataSource1Ary, NSArray *dataSource2Ary, NSArray *dataSource3Ary) {
        if (isFilter) {
            //网络加载请求 存储请求参数
            _selectedDataSource1Ary = dataSource1Ary;
            _selectedDataSource2Ary = dataSource2Ary;
            _selectedDataSource3Ary = dataSource3Ary;
        }else{
            // 不是筛选，全部赋初值（在这个工程其实是没用的，因为tableView是选中后必选的，即一旦选中就没有空的情况，但是如果可以清空筛选条件的时候就有必要 *重新* reset data）
            _selectedDataSource1Ary = @[@"类型"];
            _selectedDataSource2Ary = @[@"时间"];
            _selectedDataSource3Ary = @[@"排序"];
        }
        [self startRequest];
    }];
    _conditionFilterView.y += 0;
    // 传入数据源，对应三个tableView顺序
    _conditionFilterView.dataAry1 = @[@"不限",@"送外卖",@"探亲",@"上门服务啊",@"快递"];
    _conditionFilterView.dataAry2 = @[@"不限",@"今天",@"一天前",@"一周以内",@"一个月以内", @"三个月以内"];
    _conditionFilterView.dataAry3 = @[@"默认排序",@"时间正序",@"时间倒序"];
    
    // 初次设置默认显示数据，内部会调用block 进行第一次数据加载
    [_conditionFilterView bindChoseArrayDataSource1:_selectedDataSource1Ary DataSource2:_selectedDataSource2Ary DataSource3:_selectedDataSource3Ary];
    
    [self.view addSubview:_conditionFilterView];

}

- (void)startRequest
{
    
    NSString *source1 = [NSString stringWithFormat:@"%@",_selectedDataSource1Ary.firstObject];
    NSString *source2 = [NSString stringWithFormat:@"%@",_selectedDataSource2Ary.firstObject];
    NSString *source3 = [NSString stringWithFormat:@"%@",_selectedDataSource3Ary.firstObject];
    //NSDictionary *dic = [_conditionFilterView keyValueDic];
    // 可以用字符串在dic换成对应英文key
    
    NSLog(@"\n第一个条件:%@\n  第二个条件:%@\n  第三个条件:%@\n",source1,source2,source3);
    
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
    VisitingStatisticCell *cell = (VisitingStatisticCell *)[self creatCell:tableView indenty:@"VisitingStatisticCell"];
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
    
    return 150;
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

//- (NSArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [NSMutableArray arrayWithCapacity:1];
//    }
//    return _dataSource;
//}


@end
