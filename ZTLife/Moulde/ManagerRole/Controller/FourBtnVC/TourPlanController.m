//
//  TourPlanController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TourPlanController.h"
#import "TOPageTitleView.h"
#import "TourPlanCell.h"

@interface TourPlanController ()<TOPageTitleViewDelegate>
@property (nonatomic, strong) TOPageTitleView *titleView;
@property (nonatomic, strong) NSMutableArray<TOPageItem *> *titles;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *thinsDataSource;//头标题
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation TourPlanController
{
    NSInteger _selectIndexTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"巡查计划" titleColor:[UIColor whiteColor]];

    self.thinsDataSource = @[@"未开始", @"进行中", @"已开始"];
    
    // 创建 TitlesView
    [self createTitlesView];
    
}

- (void)createTitlesView{
    for (int i=0; i<self.thinsDataSource.count; i++) {
        [self.dataSource addObject:[TOPageItem itemWithTitle:self.thinsDataSource[i]]];
    }
    self.titleView.titles = self.titles;
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.titleView.titleViewDelegate = self;
    [self.view addSubview:self.titleView];
    
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

- (void)pageTitleView:(TOPageTitleView *)pageTitleView didSelecteIndex:(NSInteger)index oldIndex:(NSInteger)oldIndex{
    _selectIndexTitle = index;
    
    [self.tableView reloadData];
    //    [self requestData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    if (_selectIndexTitle==0) {
//        return 0;
//    }else if (_selectIndexTitle==1){
//        return 1;
//    }else{
//        return 0;
//    }
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return _selectIndexNum ==0?2:2;
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
//    if (_selectIndexTitle==1) {
//        TourPlanCell *cell = (TourPlanCell *)[self creatCell:tableView indenty:@"TourPlanCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }else{
//        static NSString *ID = @"cell";
//        // 根据标识去缓存池找cell
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        // 不写这句直接崩掉，找不到循环引用的cell
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        }
//        cell.textLabel.text = @"123";
//        return cell;
//        
//    }
    
    TourPlanCell *cell = (TourPlanCell *)[self creatCell:tableView indenty:@"TourPlanCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
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
