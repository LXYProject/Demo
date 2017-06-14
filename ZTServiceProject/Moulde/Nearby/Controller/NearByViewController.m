//
//  NearByViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByViewController.h"
#import "NearByCell.h"
#import "NearByItemsCell.h"
#import "NearByHttpManager.h"
#import "TenementViewController.h"
#import "NearByHomeViewController.h"

@interface NearByViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;
@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;

 
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        if (_isFindService) {
            [self requestServiceData];
        }
        [self requestData];
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        if (_isFindService) {
            [self requestServiceData];
        }
        [self requestData];
    }];
    [self.tableView beginHeaderRefreshing];
    
//    [self requestData];

}
// 去帮忙
- (void)requestData{
    [NearByHttpManager requestDataWithNearType:ToHelp query:2 keyWord:_keywords city:_city district:_district categoryId:@"" sort:@"" page:self.currentPage success:^(NSArray * response) {
        [self.tableView endRefreshing];
        if (self.currentPage==1){
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
// 找服务
- (void)requestServiceData
{
    [NearByHttpManager requestDataWithNearType:LookingService query:2 keyWord:_keywords city:_city district:_district categoryId:@"" sort:@"" page:self.currentPage success:^(NSArray * response) {
        [self.tableView endRefreshing];
        if (self.currentPage==1){
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
    if (_isFindService) {
        [self requestServiceData];
    }
    [self requestData];
}

- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    if (_isFindService) {
        [self requestServiceData];
    }
    [self requestData];
}

- (void)setDistrict:(NSString *)district {
    _district = district;
    if (_isFindService) {
        [self requestServiceData];
    }
    [self requestData];
}

-(void)setCity:(NSString *)city {
    _city = city;
    if (_isFindService) {
        [self requestServiceData];
    }
    [self requestData];
}

- (void)setIsFindService:(BOOL)isFindService {
    _isFindService = isFindService;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
//    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isFindService) {
        NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByCell" owner:nil options:nil] lastObject];
        }
        cell.model = self.dataSource[indexPath.section];
        return cell;

    }
    
    NearByItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByItemsCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByItemsCell" owner:nil options:nil] lastObject];
    }
    cell.model = self.dataSource[indexPath.section];
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFindService) {
        return 140;
    }
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    @weakify(self);
//    [PushManager pushViewControllerWithName:@"TenementViewController" animated:YES block:^(TenementViewController* viewController) {
//        @strongify(self);
//        viewController.categrayId = [self.dataSource[indexPath.row] categrayId];
//    }];
}


- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end
