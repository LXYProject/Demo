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
#import "MyPublicThingsModel.h"
#import "MyPraiseModel.h"
#import "VillagesModel.h"
#import "BuildingListModel.h"
#import "HouseListModel.h"
#import "CommunityPeopleModel.h"

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

+ (void)requestLoginCustomerOrders:(CustomerOrders)customerOrders
                         machineId:(NSString *)machineId
                       machineName:(NSString *)machineName
                        clientType:(NSString *)clientType
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@""
                               };
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
            NSArray *modelArray = [BuyOrderModel mj_objectArrayWithKeyValuesArray:response[@"serviceOrderList"]];
            success(modelArray);
        }else{
            NSArray *modelArray = [HelpOrderModel mj_objectArrayWithKeyValuesArray:response[@"appealOrderList"]];
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

+ (void)requestHouseAddVillage:(HouseAddVillage)houseAddVillage
                     machineId:(NSString *)machineId
                   machineName:(NSString *)machineName
                    clientType:(NSString *)clientType
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@""
                               };
    
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
        
        if (typeInformation==DoorService) {
            NSArray *modelArray = [MyDoorServiceModel mj_objectArrayWithKeyValuesArray:response[@"visitServiceList"]];
            success(modelArray);
        }else if(typeInformation==PublicThings){
            NSArray *modelArray = [MyPublicThingsModel mj_objectArrayWithKeyValuesArray:response[@"publicAffairList"]];
            success(modelArray);
        }else if (typeInformation==Praises){
            NSArray *modelArray = [MyPraiseModel mj_objectArrayWithKeyValuesArray:response[@"praiseList"]];
            success(modelArray);
        }else{
            NSArray *modelArray = [MyPraiseModel mj_objectArrayWithKeyValuesArray:response[@"complainList"]];
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


// 根据小区查看附近的人
+ (void)requestPeopleZoneId:(NSString *)zoneId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@""};
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_lookPepoleByVillage paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [CommunityPeopleModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 添加, 取消好友关注
+ (void)requestAddToCancelFriend:(AddToCancelFriend)AddToCancelFriend
                    FriendUserId:(NSString *)friendUserId
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"friendUserId":friendUserId?friendUserId:@""};
    NSString *url = nil;
    if (AddToCancelFriend == AddFriend) {
        url = A_addFriend;
    }else{
        url = A_deleteFriend;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

// 查看我的好友列表
+ (void)requestFriendsListSuccess:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{};

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_myFriends paramter:paramter success:^(id response) {
        
//        NSArray *modelArray = [CommunityPeopleModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
//        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 查找最近登录的人
+ (void)requestDays:(NSString *)days
             gender:(NSString *)gender
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"days":days?days:@"",
                               @"gender":gender?gender:@""};

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_lookRecentLoginUser paramter:paramter success:^(id response) {
        
        //        NSArray *modelArray = [CommunityPeopleModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
        //        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 查看用户详细信息
+ (void)requestTargetUserId:(NSString *)targetUserId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"targetUserId":targetUserId?targetUserId:@""};
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_lookUserAll paramter:paramter success:^(id response) {
        
        //        NSArray *modelArray = [CommunityPeopleModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
        //        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}
@end
