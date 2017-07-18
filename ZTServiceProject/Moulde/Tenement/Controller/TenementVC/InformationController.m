//
//  InformationController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "InformationController.h"
#import "DialheadCell.h"
#import "DetailsCell.h"
#import "TenementHttpManager.h"

@interface InformationController ()

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 便民服务的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation InformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"物业电话"
                  titleColor:[UIColor whiteColor]];
//    self.navigationBarBackGroudColor = [UIColor clearColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [Tools createImageWithColor:[UIColor clearColor]];
    
    [self.tableView setHeaderRefreshBlock:^{
        if (self.zoneId>0) {
            
            [self requestConvenience];
        }
    }];
    [self.tableView beginHeaderRefreshing];


}

// 便民服务
- (void)requestConvenience{
    [TenementHttpManager requestListOrPanorama:ConvenienceService
                                        zoneId:self.zoneId
                                       success:^(id response) {
                                           [self.tableView endRefreshing];
                                           
                                           [self.dataSource removeAllObjects];
                                           
                                           [self.dataSource addObjectsFromArray:response];
                                           [self.tableView reloadData];

                                       
                                       } failure:^(NSError *error, NSString *message) {
                                           [self.tableView endRefreshing];
                                       }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        DialheadCell *cell = (DialheadCell *)[self creatCell:tableView indenty:@"DialheadCell"];
        return cell;
    }else{
        DetailsCell *cell = (DetailsCell *)[self creatCell:tableView indenty:@"DetailsCell"];
        cell.model = self.dataSource[indexPath.section];
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    DetailsCell *cell = (DetailsCell *)[self creatCell:tableView indenty:@"DetailsCell"];
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
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 105;
        }else{
            return 109;
        }
    }else{
        return 109;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
