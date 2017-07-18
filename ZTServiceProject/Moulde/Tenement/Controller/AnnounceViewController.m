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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 小区公告的数据
@property (nonatomic,strong)NSMutableArray *announceDataSource;


@end

@implementation AnnounceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self titleViewWithTitle:@"小区公告" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"筛选条件"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    [self requestBulletinList];
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

// 请求小区公告
- (void)requestBulletinList{
    [TenementHttpManager requestListOrPanorama:AnnouncementList
                                        zoneId:@"510018177815"
                                       success:^(id response) {
                                           
                                           [self.announceDataSource addObject:response];
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           
                                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
