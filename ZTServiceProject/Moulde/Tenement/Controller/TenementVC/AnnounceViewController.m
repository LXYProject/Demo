//
//  AnnounceViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AnnounceViewController.h"
#import "AnnounceCell.h"    
#import "TenementHttpManager.h"

@interface AnnounceViewController ()
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 小区公告的数据
@property (nonatomic,strong)NSMutableArray *announceDataSource;


@end

@implementation AnnounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"小区公告" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"筛选条件"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    [self.tableView setHeaderRefreshBlock:^{
        if (self.zoneId>0) {
            
            [self requestBulletinList];
        }
    }];
    [self.tableView beginHeaderRefreshing];

}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

// 请求小区公告
- (void)requestBulletinList{
    @weakify(self);
    [TenementHttpManager requestListOrPanorama:AnnouncementList
                                        zoneId:self.zoneId
                                       success:^(id response) {
                                           @strongify(self);
                                           [self.tableView endRefreshing];
                                           
                                           [self.announceDataSource removeAllObjects];
                                           
                                           [self.announceDataSource addObjectsFromArray:response];
                                           [self.tableView reloadData];
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           [self.tableView endRefreshing];
                                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.announceDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //指定cellIdentifier为自定义的cell
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    AnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnnounceCell" owner:self options:nil] lastObject];
        cell.model = self.announceDataSource[indexPath.section];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSArray *)announceDataSource {
    if (!_announceDataSource) {
        _announceDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _announceDataSource;
}
@end
