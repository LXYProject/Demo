//
//  MineHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户订单service
typedef enum : NSUInteger {
    BuyOrder,        //查看我购买的服务订单
    SaleOrder,       //查看我出售的服务订单
    HelpOrder,       //查看我帮助的订单
    MyAppealOrder    //查看我求助的订单
} CustomerOrders;

// 查看所有与我有关的房屋,小区
typedef enum : NSUInteger {
    House,      //查看所有与我有关的房屋
    Village     //查看所有与我有关的小区
} HouseAddVillage;

// 房屋接口
typedef enum : NSUInteger {
    addBindHouse,    //新增绑定房屋
    addLikeHouse,    //添加房屋关注
    unHouse          //取消绑定，取消关注
} AddToCancelHouse;

// 房屋接口
typedef enum : NSUInteger {
    BindHouse,       //绑定房屋
    CancelBind,      //取消绑定
} BindToCancelHouse;

// 房屋接口
typedef enum : NSUInteger {
    FocusHouse,       //关注房屋
    CancelFocus,      //取消关注
} FocusToCancelHouse;

// 小区接口
typedef enum : NSUInteger {
    AddVillage,      //添加小区关注
    CancelVillage    //取消小区关注
} AddToCancelVillage;

// 查看上门服务，公共报事，表扬，投诉信息
typedef enum : NSUInteger {
    DoorService,    //查看上门服务信息
    PublicThings,   //查看公共报事信息
    Praises,         //查看我帮助的订单
    Complaints      //查看我求助的订单
} TypeInformation;


// 好友接口
typedef enum : NSUInteger {
    AddFriend,      //添加好友关注
    CancelFriend    //取消好友关注
} AddToCancelFriend;

@interface MineHttpManager : NSObject

// 发帖记录
+ (void)requestTopicId:(NSString *)topicId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;

// 查看我出售的服务订单
+ (void)requestLoginCustomerOrders:(CustomerOrders)customerOrders
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure;

+ (void)requestLoginCustomerOrders:(CustomerOrders)customerOrders
                         machineId:(NSString *)machineId
                       machineName:(NSString *)machineName
                        clientType:(NSString *)clientType
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure;


// 查看所有与我有关的房屋,小区
+ (void)requesHouseAddVillage:(HouseAddVillage)HouseAddVillage
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;

+ (void)requestHouseAddVillage:(HouseAddVillage)houseAddVillage
                     machineId:(NSString *)machineId
                   machineName:(NSString *)machineName
                    clientType:(NSString *)clientType
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;

// 新增，添加，取消房屋关注
+ (void)requestAddToCancelHouse:(AddToCancelHouse)addToCancelHouse
                        houseId:(NSString *)houseId
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure;

// 绑定房屋, 取消绑定
+ (void)requestBindToCancelHouse:(BindToCancelHouse)bindToCancelHouse
                       machineId:(NSString *)machineId
                     machineName:(NSString *)machineName
                      clientType:(NSString *)clientType
                       villageId:(NSString *)villageId
                         houseId:(NSString *)houseId
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure;

// 关注房屋, 取消关注
+ (void)requestFocusToCancelHouse:(FocusToCancelHouse)focusToCancelHouse
                        machineId:(NSString *)machineId
                      machineName:(NSString *)machineName
                       clientType:(NSString *)clientType
                          houseId:(NSString *)houseId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;

// 添加，取消小区关注
+ (void)requestAddToCancelVillage:(AddToCancelVillage)addToCancelVillage
                      communityId:(NSString *)communityId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;


// 添加，取消小区关注
+ (void)requestAddToCancelVillage:(AddToCancelVillage)addToCancelVillage
                        machineId:(NSString *)machineId
                      machineName:(NSString *)machineName
                       clientType:(NSString *)clientType
                        villageId:(NSString *)villageId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;


// 查看上门服务，公共报事，表扬，投诉信息
+ (void)requestTypeInformation:(TypeInformation)typeInformation
                        status:(NSString *)status
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;

// 小区-关键字搜索
+ (void)requestKeywords:(NSString *)keywords
                   city:(NSString *)city
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;

// 楼栋-根据小区ID搜索
+ (void)requestZoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 单元-根据楼栋ID搜索
+ (void)requestBuildingId:(NSString *)buildingId
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure;

// 楼层-根据单元ID搜索
+ (void)requestBuildingUnitId:(NSString *)buildingUnitId
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;

// 房屋-根据楼层ID查询
+ (void)requestBuildingFloorId:(NSString *)buildingFloorId
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;


// 根据楼查询房屋表
+ (void)requestZoneId:(NSString *)zoneId
           buildingId:(NSString *)buildingId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 根据小区查看附近的人
+ (void)requestPeopleZoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 添加, 取消好友关注
+ (void)requestAddToCancelFriend:(AddToCancelFriend)AddToCancelFriend
                    FriendUserId:(NSString *)friendUserId
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure;

// 查看我的好友列表
+ (void)requestFriendsListSuccess:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;


// 查找最近登录的人
+ (void)requestDays:(NSString *)days
             gender:(NSString *)gender
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure;


// 查看用户详细信息
+ (void)requestTargetUserId:(NSString *)targetUserId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure;
@end

