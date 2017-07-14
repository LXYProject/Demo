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
#import "MyDoorServiceModel.h"
#import "MyPraiseModel.h"
#import "VillagesModel.h"
#import "BuildingListModel.h"
#import "HouseListModel.h"

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
    NSDictionary *paramter = @{@"topicId":topicId?topicId:@""};

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_topicHis paramter:paramter success:^(id response) {

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
            success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 新增，添加，取消房屋关注
+ (void)requestAddToCancelHouse:(AddToCancelHouse)addToCancelHouse
                        houseId:(NSString *)houseId
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@""};
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
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 添加，取消小区关注
+ (void)requestAddToCancelVillage:(AddToCancelVillage)addToCancelVillage
                      communityId:(NSString *)communityId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"communityId":communityId?communityId:@""};
    NSString *url = nil;
    if (addToCancelVillage == AddVillage) {
        url = A_addConcernVillage;
    }else{
        url = A_unConcernVillage;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 查看上门服务，公共报事，表扬，投诉信息
+ (void)requestTypeInformation:(TypeInformation)typeInformation
                        status:(NSString *)status
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"status":status?status:@""};

    NSString *url = nil;
    if (typeInformation == DoorService) {
        url = A_lookvisitService;
    }else if(typeInformation == PublicThings){
        url = A_publicAffairList;
    }else if (typeInformation == Praises){
        url = A_praiseList;
    }else{
        url = A_complainList;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        NSLog(@"查看上门服务，公共报事，表扬，投诉信息==%@", response);
        
        if (typeInformation==DoorService || typeInformation==PublicThings) {
            NSArray *modelArray = [MyDoorServiceModel mj_objectArrayWithKeyValuesArray:response];
            success(modelArray);
        }else{
            NSArray *modelArray = [MyPraiseModel mj_objectArrayWithKeyValuesArray:response];
            success(modelArray);
        }
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 关键字搜索小区
+ (void)requestKeywords:(NSString *)keywords
                   city:(NSString *)city
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"keywords":keywords?keywords:@"",
                               @"city":city?city:@""
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_searchVillagesByKeyWords paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [VillagesModel mj_objectArrayWithKeyValuesArray:response[@"zoneList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 小区id搜索楼
+ (void)requestZoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@""};
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_searchBuildingByVillage paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [BuildingListModel mj_objectArrayWithKeyValuesArray:response[@"buildingList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 根据楼查询房屋表
+ (void)requestZoneId:(NSString *)zoneId
           buildingId:(NSString *)buildingId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"buildingId":buildingId?buildingId:@""
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_searchHouses paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [HouseListModel mj_objectArrayWithKeyValuesArray:response[@"houseList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
