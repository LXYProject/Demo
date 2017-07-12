//
//  MineHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MineHttpManager.h"
#import "HttpAPIManager.h"
#import "BuyOrderModel.h"   
#import "HelpOrderModel.h"
#import "MyNeighborModel.h"
#import "NeighborCircleModel.h"

@implementation MineHttpManager

// 用户订单service
+ (void)requestLoginCustomerOrders:(CustomerOrders)customerOrders
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{};
                               
    NSString *url = nil;
    if (customerOrders == BuyOrder) {
        url = A_lookBuyOrderForm;
    }else if(customerOrders == SaleOrder){
        url = A_lookSaleOrderForm;
    }else if (customerOrders == HelpOrder){
        url = A_lookHelpOrderForm;
    }else{
        url = A_lookMyAppealOrderForm;
    }
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
//        NSLog(@"用户订单service==%@", response);
        
        if (customerOrders==BuyOrder || customerOrders==SaleOrder) {
            NSArray *modelArray = [BuyOrderModel mj_objectArrayWithKeyValuesArray:response[@"orders"]];
            success(modelArray);
        }else{
            NSArray *modelArray = [HelpOrderModel mj_objectArrayWithKeyValuesArray:response[@"indents"]];
            success(modelArray);
        }
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 发帖记录
+ (void)requestTopicId:(NSString *)topicId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"topicId":topicId?topicId:@"",
                               };

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_topicHis paramter:paramter success:^(id response) {
        NSLog(@"发帖纪录==%@", response);

        NSArray *modelArray = [NeighborCircleModel mj_objectArrayWithKeyValuesArray:response[@"topicList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 查看所有与我有关的房屋,小区
+ (void)requesHouseAddVillage:(HouseAddVillage)houseAddVillage
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{};

    NSString *url = nil;
    if (houseAddVillage == House) {
        url = A_lookAllHouseWithMe;
    }else{
        url = A_lookAllVillageWithMe;
    }

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        NSLog(@"查看所有与我有关的房屋,小区==%@", response);
        
            success(response);
//            NSArray *modelArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response];
//            success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 新增，添加，取消房屋关注
+ (void)requestAddToCancelHouse:(AddToCancelHouse)addToCancelHouse
                        houseId:(NSString *)houseId
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               };
    NSString *url = nil;
    if (addToCancelHouse == addBindHouse) {
        url = A_addBindHouse;
    }else if(addToCancelHouse == addLikeHouse){
        url = A_addLikeHouse;
    }else{
        url = A_unHouse;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        
        success(response);
        NSLog(@"新增，添加，取消房屋关注==%@", response);
        
        //        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        //        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 添加，取消小区关注
+ (void)requestAddToCancelVillage:(AddToCancelVillage)addToCancelVillage
                      communityId:(NSString *)communityId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"communityId":communityId?communityId:@"",
                               };
    NSString *url = nil;
    if (addToCancelVillage == AddVillage) {
        url = A_addConcernVillage;
    }else{
        url = A_unConcernVillage;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        
        success(response);
        NSLog(@"与我有关的小区==%@", response);
        
        //        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        //        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
