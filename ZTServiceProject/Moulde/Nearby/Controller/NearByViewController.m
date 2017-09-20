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
#import "ServiceDetailsController.h"
#import "HelpDetailsController.h"

@interface NearByViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;
@end

@implementation NearByViewController
{
    MBProgressHUD *_hud;
    NSString *_deviceUUID;
    NSString *_deviceModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;

    // 获取设备唯一标识符和手机型号
    _deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    _deviceModel = [Tools deviceVersion];
    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        if (_isFindService) {
            [self requestServiceData];
        }else{
            [self requestData];
        }
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        if (_isFindService) {
            [self requestServiceData];
        }else{
            [self requestData];
        }
    }];
    [self.tableView beginHeaderRefreshing];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    
//    [self requestData];

}
// 去帮忙
- (void)requestData{
//    @weakify(self);
//    [NearByHttpManager requestDataWithNearType:ToHelp
//                                         query:2
//                                       keyWord:_keywords
//                                          city:_city
//                                      district:_district
//                                    categoryId:@""
//                                          sort:@""
//                                          page:self.currentPage
//                                       success:^(NSArray * response) {
//                                           @strongify(self);
//                                           [self.tableView endRefreshing];
//                                           [_hud hide:YES];
//                                           
//                                           if (self.currentPage==1){
//                                               [self.dataSource removeAllObjects];
//                                           }
//                                           [self.dataSource addObjectsFromArray:response];
//                                           if (response.count<10) {
//                                               [self.tableView endRefreshingWithNoMoreData];
//                                           }
//                                           [self.tableView reloadData];
//                                       } failure:^(NSError *error, NSString *message) {
//                                           [self.tableView endRefreshing];
//                                           _hud.labelText = message;
//                                           [_hud hide:YES];
//                                       }];
    
    @weakify(self);
    [NearByHttpManager requestDataWithNearType:ToHelp machineId:_deviceUUID machineName:_deviceModel clientType:@"0" query:2 categoryId:_categoryId page:self.currentPage success:^(NSArray * response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        if (self.currentPage==1){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        _hud.labelText = message;
        [_hud hide:YES];
    }];

}
// 找服务
- (void)requestServiceData
{
//    @weakify(self);
//    [NearByHttpManager requestDataWithNearType:LookingService
//                                         query:2
//                                       keyWord:_keywords
//                                          city:_city
//                                      district:_district
//                                    categoryId:@""
//                                          sort:@""
//                                          page:self.currentPage
//                                       success:^(NSArray * response) {
//                                           @strongify(self);
//                                           [self.tableView endRefreshing];
//                                           [_hud hide:YES];
//                                           
//                                           if (self.currentPage==1){
//                                               [self.dataSource removeAllObjects];
//                                           }
//                                           [self.dataSource addObjectsFromArray:response];
//                                           if (response.count<10) {
//                                               [self.tableView endRefreshingWithNoMoreData];
//                                           }
//                                           [self.tableView reloadData];
//                                       } failure:^(NSError *error, NSString *message) {
//                                           [self.tableView endRefreshing];
//                                           _hud.labelText = message;
//                                           [_hud hide:YES];
//                                       }];
    @weakify(self);
    [NearByHttpManager requestDataWithNearType:LookingService machineId:_deviceUUID machineName:_deviceModel clientType:@"0" query:2 categoryId:_categoryId page:self.currentPage success:^(NSArray * response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        if (self.currentPage==1){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        _hud.labelText = message;
        [_hud hide:YES];
    }];
}
- (void)setCategoryId:(NSString *)categoryId {
    _categoryId = categoryId;
    if (_isFindService) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    if (_isFindService) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

- (void)setDistrict:(NSString *)district {
    _district = district;
    if (_isFindService) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
}

-(void)setCity:(NSString *)city {
    _city = city;
    if (_isFindService) {
        [self requestServiceData];
    }else{
        [self requestData];
    }
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

    }else{
        NearByItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByItemsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByItemsCell" owner:nil options:nil] lastObject];
        }
        cell.model = self.dataSource[indexPath.section];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isFindService) {
        [PushManager pushViewControllerWithName:@"ServiceDetailsController" animated:YES block:^(ServiceDetailsController* serviceDetailsVC) {
            serviceDetailsVC.model = self.dataSource[indexPath.section];
        }];
    }else{
        [PushManager pushViewControllerWithName:@"HelpDetailsController" animated:YES block:^(HelpDetailsController* helpDetailsVC) {
            helpDetailsVC.model = self.dataSource[indexPath.section];
        }];
    }

    //    @weakify(self);
    //    [PushManager pushViewControllerWithName:@"TenementViewController" animated:YES block:^(TenementViewController* viewController) {
    //        @strongify(self);
    //        viewController.categrayId = [self.dataSource[indexPath.row] categoryId];
    //    }];
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
    return 5;
}


- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//}

@end
