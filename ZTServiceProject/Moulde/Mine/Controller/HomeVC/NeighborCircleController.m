//
//  MyNeighborController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborCircleController.h"
#import "NeighborCircleCell.h"
#import "MineHttpManager.h"
#import "NeighborCircleModel.h"
#import "NeighborDetailController.h"

@interface NeighborCircleController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 发帖记录 的数据相关的
@property (nonatomic,strong)NSMutableArray *topicHisDataSource;//绑定的房屋
@property (nonatomic, strong)NSArray *listArray;

@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic, copy)NSArray *mouthsSection;

@end

@implementation NeighborCircleController
{
    NeighborCircleCell *neighborCircleCell;
    NeighborCircleModel *neighborCircleModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我的邻里圈" titleColor:[UIColor whiteColor]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.currentPage = 1;
    [self.tableView setHeaderRefreshBlock:^{
//        self.currentPage = 1;
        [self requestTopicHis];
    }];
//    [self.tableView setFooterRefreshBlock:^{
//        self.currentPage++;
//        [self requestTopicHis];
//    }];
    [self.tableView beginHeaderRefreshing];
    
}

// 发帖记录
- (void)requestTopicHis{
    
    [MineHttpManager requestTopicId:@"" success:^(NSArray* response) {
        //
        [self.tableView endRefreshing];
        
        self.listArray = (NSMutableArray *)response;
        
        NSMutableArray  *yearArray = [NSMutableArray arrayWithCapacity:1];
        //取出年份 tableView的section 以年份+月份为分组条件   day为每组内容
        [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NeighborCircleModel *model = obj;
            if (![yearArray containsObject:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
                [yearArray addObject:[self yearAndMonth:[self dateformatter:model.createTime]]];
            }
        }];
        //这里将数组进行排序，防止服务器数据有问题
        NSArray *result = [yearArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 compare:obj1]; //降序
        }];
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *year = obj;
            NSMutableArray *mothArr = [NSMutableArray arrayWithCapacity:1];
            [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NeighborCircleModel *model = obj;
                if ([year isEqualToString:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
                    [mothArr addObject:model];
                }
            }];
            [self.topicHisDataSource addObject:mothArr];

            
        }];
//        NSLog(@"%@",self.topicHisDataSource);
        
        
        //                                if (self.currentPage==1){
        //                                    [self.topicHisDataSource removeAllObjects];
        //                                }
        //                                [self.topicHisDataSource addObjectsFromArray:response];
//        if (response.count<10) {
//            [self.tableView endRefreshingWithNoMoreData];
//        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];
    }];
}

- (NSString *)yearAndMonth:(NSDate *)formaterDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:formaterDate];
}


- (NSDate *)dateformatter :(NSString *)str {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formaterDate = [dateFormatter dateFromString:str];
    return formaterDate;
}

- (NSString *)newYearAndMonth:(NSDate *)formaterDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月yyyy年"];
    return [formatter stringFromDate:formaterDate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return 2;
    return self.topicHisDataSource.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicHisDataSource.count>0?[self.topicHisDataSource[section] count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    NeighborCircleCell *cell = (NeighborCircleCell *)[self creatCell:tableView indenty:@"NeighborCircleCell"];
    cell.model = self.topicHisDataSource[indexPath.section][indexPath.row];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    
//    if (section ==0){
//        lable.attributedText = [self attrText:@"07月2017年"];
        NeighborCircleModel *model = self.topicHisDataSource[section][0];
        lable.attributedText = [self attrText:[self newYearAndMonth:[self dateformatter:model.createTime]]];
    
//    }
//    else if (section ==1){
//        lable.attributedText = [self attrText:@"06月2017年"];
//    }
//    else{
//        lable.attributedText = nil;
//    }
    
    
    [view addSubview:lable];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [Tools cellRadio:tableView cell:cell indexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [PushManager pushViewControllerWithName:@"NeighborDetailController" animated:YES block:^(NeighborDetailController* viewController) {
        viewController.model = self.topicHisDataSource[indexPath.section];
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 94;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSAttributedString *)attrText:(NSString *)text {
    if (text.length<8) {
        NSLog(@"文字的个数不足，需要添加更多的文字");
        return nil;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(0, 2)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(2, 1)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    NSAttributedString *attr5 = [[NSAttributedString alloc]initWithString:@" " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(3, 4)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(7, text.length-7)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    [attr appendAttributedString:attr1];
    [attr appendAttributedString:attr2];
    [attr appendAttributedString:attr5];
    [attr appendAttributedString:attr3];
    [attr appendAttributedString:attr4];
    
    return attr;
}

- (NSArray *)topicHisDataSource {
    if (!_topicHisDataSource) {
        _topicHisDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _topicHisDataSource;
}
@end
