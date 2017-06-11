//
//  NearByViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByViewController.h"
#import "NearByItemsCell.h"
#import "NearByHttpManager.h"
@interface NearByViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;
@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 0;
        [self requestData];
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage = 1;
        [self requestData];
    }];
    [self.tableView beginHeaderRefreshing];
    
    [self requestData];
}

- (void)requestDataOne{
    
    [NearByHttpManager requestQuery:@"2" page:@"1" pageCount:@"1" success:^(NSArray *response) {
        [self.tableView endRefreshing];
        if (self.currentPage==0){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];

    } failure:^(NSError *error, NSString *message) {
        
    }];
}
- (void)requestDataTwo{
    
    [NearByHttpManager requestDataWithQuery:@"2" keyWords:_keywords city:_city district:_district categoryId:_categoryId sort:@"" page:self.currentPage success:^(NSArray *response) {
        [self.tableView endRefreshing];
        if (self.currentPage==0){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];
    }];
}

- (void)requestData{
    [NearByHttpManager requestDataWithQuery:2 KeyWord:_keywords city:_city district:_district categoryId:_categoryId sort:@"" page:self.currentPage success:^(NSArray * response) {
        [self.tableView endRefreshing];
        if (self.currentPage==0){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];
    }];
}

- (void)setCategoryId:(NSString *)categoryId {
    _categoryId = categoryId;
    [self requestData];
//    [self requestDataOne];

}

- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    [self requestData];
//    [self requestDataOne];

}

- (void)setDistrict:(NSString *)district {
    _district = district;
    [self requestData];
//    [self requestDataOne];

}

-(void)setCity:(NSString *)city {
    _city = city;
    [self requestData];
//    [self requestDataOne];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataSourceArray.count;
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearByItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByItemsCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByItemsCell" owner:nil options:nil] lastObject];
    }
//    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
