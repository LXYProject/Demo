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

@interface MineHttpManager : NSObject

// 发帖记录
+ (void)requestTopicId:(NSString *)topicId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;

// 查看我出售的服务订单
+ (void)requestLoginCustomerOrders:(CustomerOrders)customerOrders
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure;


// 查看所有与我有关的房屋,小区
+ (void)requesHouseAddVillage:(HouseAddVillage)HouseAddVillage
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;


// 新增，添加，取消房屋关注
+ (void)requestAddToCancelHouse:(AddToCancelHouse)addToCancelHouse
                        houseId:(NSString *)houseId
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure;



// 添加，取消小区关注
+ (void)requestAddToCancelVillage:(AddToCancelVillage)addToCancelVillage
                      communityId:(NSString *)communityId
                          success:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;


// 查看上门服务，公共报事，表扬，投诉信息
+ (void)requestTypeInformation:(TypeInformation)typeInformation
                        status:(NSString *)status
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;

// 关键字搜索小区
+ (void)requestKeywords:(NSString *)keywords
                   city:(NSString *)city
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;

// 小区id搜索楼
+ (void)requestZoneId:(NSString *)zoneId
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

@end

