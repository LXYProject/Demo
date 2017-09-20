//
//  ServiceOrderController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceOrderController.h"
#import "OrderDetailsController.h"  
#import "SaleOrderDetailsController.h"
#import "ServiceOrderCell.h"
#import "ServiceHeadCell.h"
#import "ServiceBodyCell.h"
#import "MineHttpManager.h"

@interface ServiceOrderController ()

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

//查看我购买,出售的服务订单 的数据相关的
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation ServiceOrderController
{
    UIButton *_selectedBtn;
    //0  代表我的购买 1、我的出售
    NSInteger _selectIndexNum;
    MBProgressHUD *_hud;
    NSString *_deviceUUID;
    NSString *_deviceModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"服务订单" titleColor:[UIColor whiteColor]];
    
    [self headerBtnClick:self.buyBtn];
    self.currentPage = 1;
    
    // 获取设备唯一标识符
    _deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    _deviceModel = [Tools deviceVersion];
}

- (IBAction)headerBtnClick:(UIButton *)sender {
    _selectedBtn.selected  = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    _selectIndexNum = sender == self.buyBtn?0:1;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation(sender==self.buyBtn?0:ScreenWidth/2, 0);
    }];
    
    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        if (_selectIndexNum==0) {
            [self requestBuyOrder];
        }else{
            [self requestSaleOrder];
        }
    }];
    
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        if (_selectIndexNum==0) {
            [self requestBuyOrder];
        }else{
            [self requestSaleOrder];
        }
        
    }];
    [self.tableView beginHeaderRefreshing];
    
    
//    [self requestData];
    //测试的用的
//    [self.tableView reloadData];
    
}

//查看我购买的服务订单
- (void)requestBuyOrder{
//    @weakify(self);
//    [MineHttpManager requestLoginCustomerOrders:BuyOrder
//                                        success:^(NSArray *response) {
//                                            @strongify(self);
//                                            [self.tableView endRefreshing];
//                                            [_hud hide:YES];
//
//                                            self.dataSource = (NSMutableArray *)response;
//
//                                            
////                                            if (self.currentPage==1){
////                                                [self.dataSource removeAllObjects];
////                                            }
////                                            [self.dataSource addObjectsFromArray:response];
////                                            if (response.count<10) {
////                                                [self.tableView endRefreshingWithNoMoreData];
////                                            }
//                                            [self.tableView reloadData];
//                                            
//                                        } failure:^(NSError *error, NSString *message) {
//                                            [self.tableView endRefreshing];
//                                            _hud.labelText = message;
//                                            [_hud hide:YES];
//                                        }];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
    @weakify(self);
    [MineHttpManager requestLoginCustomerOrders:BuyOrder machineId:_deviceUUID machineName:_deviceModel clientType:@"0" success:^(id response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        self.dataSource = (NSMutableArray *)response;
        
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        _hud.labelText = message;
        [_hud hide:YES];
    }];
}
//查看我出售的服务订单
- (void)requestSaleOrder{
//    @weakify(self);
//    [MineHttpManager requestLoginCustomerOrders:SaleOrder
//                                        success:^(NSArray *response) {
//                                            @strongify(self);
//                                            [self.tableView endRefreshing];
//                                            [_hud hide:YES];
//                                            
//                                            self.dataSource = (NSMutableArray *)response;
//
//                                            
////                                            if (self.currentPage==1){
////                                                [self.dataSource removeAllObjects];
////                                            }
////                                            [self.dataSource addObjectsFromArray:response];
////                                            if (response.count<10) {
////                                                [self.tableView endRefreshingWithNoMoreData];
////                                            }
//                                            [self.tableView reloadData];
//                                            
//                                        } failure:^(NSError *error, NSString *message) {
//                                            [self.tableView endRefreshing];
//                                            _hud.labelText = message;
//                                            [_hud hide:YES];
//                                        }];
    @weakify(self);
    [MineHttpManager requestLoginCustomerOrders:SaleOrder machineId:_deviceUUID machineName:_deviceModel clientType:@"0" success:^(id response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        self.dataSource = (NSMutableArray *)response;
        
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        _hud.labelText = message;
        [_hud hide:YES];

    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 10;
    if (_selectIndexNum==0) {
        return self.dataSource.count;
    }else{
        return self.dataSource.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectIndexNum ==0?2:2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
     if (indexPath.row==0){
        ServiceHeadCell *cell = (ServiceHeadCell *)[self creatCell:tableView indenty:@"ServiceHeadCell"];
         if (_selectIndexNum==0) {
             cell.model = self.dataSource[indexPath.section];
         }else{
             cell.model = self.dataSource[indexPath.section];
         }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        ServiceBodyCell *cell = (ServiceBodyCell *)[self creatCell:tableView indenty:@"ServiceBodyCell"];
        if (_selectIndexNum==0) {
            cell.model = self.dataSource[indexPath.section];
        }else{
            cell.model = self.dataSource[indexPath.section];
        }
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

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
    if (_selectIndexNum==0) {
        [PushManager pushViewControllerWithName:@"OrderDetailsController" animated:YES block:^(OrderDetailsController* orderDetailsVC) {
            orderDetailsVC.model = self.dataSource[indexPath.section];
        }];
    }else{
        [PushManager pushViewControllerWithName:@"SaleOrderDetailsController" animated:YES block:^(SaleOrderDetailsController* saleOrderDetailVC) {
            saleOrderDetailVC.model = self.dataSource[indexPath.section];
        }];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 44;
    }
    return 94;
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
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
@end
