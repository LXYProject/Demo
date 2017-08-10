//
//  TenementHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

// 查看服务, 报事类型列表, 公告列表, 便民服务, 小区全景
typedef enum : NSUInteger {
    ServiceList,       //服务类型列表
    ListThings,        //报事类型列表
    AnnouncementList,  //公告列表
    ConvenienceService,//便民服务
    VillagePanorama    //查看小区全景
} ListOrPanorama;


typedef enum : NSUInteger {
    praise,        //表扬
    complaints     //投诉
} PraiseOrComplaint;

@interface TenementHttpManager : NSObject

//===============================================物业接口=======================================

// 查看小区全景, 服务, 报事类型列表
+ (void)requestListOrPanorama:(ListOrPanorama)ListOrPanorama
                       zoneId:(NSString *)zoneId
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;


// 发送上门服务信息
+ (void)requestZoneId:(NSString *)zoneId
         serviceTitle:(NSString *)serviceTitle
      serviceDiscribe:(NSString *)serviceDiscribe
      serviceCategory:(NSString *)serviceCategory
          serviceTime:(NSString *)serviceTime
          userAddress:(NSString *)userAddress
         userRealName:(NSString *)userRealName
         userPhoneNum:(NSString *)userPhoneNum
              houseId:(NSString *)houseId
            houseName:(NSString *)houseName
                    x:(NSString *)x
                    y:(NSString *)y
               images:(UIImage *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;

// 公共报事
+ (void)requestZoneId:(NSString *)zoneId
          affairTitle:(NSString *)affairTitle
       affairDiscribe:(NSString *)affairDiscribe
       affairCategory:(NSString *)affairCategory
          userAddress:(NSString *)userAddress
         userRealName:(NSString *)userRealName
         userPhoneNum:(NSString *)userPhoneNum
                    x:(NSString *)x
                    y:(NSString *)y
               images:(UIImage *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 表扬和投诉
+ (void)requestPraiseOrComplaint:(PraiseOrComplaint)praiseOrComplaint
                          zoneId:(NSString *)zoneId
                     affairTitle:(NSString *)affairTitle
                  affairDiscribe:(NSString *)affairDiscribe
                  affairCategory:(NSString *)affairCategory
                     userAddress:(NSString *)userAddress
                    userRealName:(NSString *)userRealName
                    userPhoneNum:(NSString *)userPhoneNum
                          images:(UIImage *)images
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure;


// 上报小区全景
+ (void)requestZoneId:(NSString *)zoneId
      featureCategory:(NSString *)featureCategory
          featureName:(NSString *)featureName
             featureX:(NSString *)featureX
             featureY:(NSString *)featureY
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 小区设施类型列表
+ (void)requestZoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;



// 查看待缴费账单
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
               status:(NSString *)status
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 缴纳物业费
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              billIds:(NSString *)billIds
                 cost:(NSString *)cost
          paymentMode:(NSString *)paymentMode
         paymentOrder:(NSString *)paymentOrder
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 查询缴费记录
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 获取物业费缴纳参数
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              billIds:(NSString *)billIds
          paymentMode:(NSString *)paymentMode
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


// 缴纳物业费成功后回执
+ (void)requestPaymentMode:(NSString *)paymentMode
                 paymentId:(NSString *)paymentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


//===============================================生活缴费服务=======================================

// 根据房屋及缴费类型获取公司
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
              cityCode:(NSString *)cityCode
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;


// 获取缴费基本信息
+ (void)requestPaymentInfoSuccess:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure;


// 绑定缴费账号
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
               company:(NSString *)company
               account:(NSString *)account
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;


// 缴费
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
               company:(NSString *)company
               account:(NSString *)account
                  cost:(NSString *)cost
           paymentMode:(NSString *)paymentMode
          paymentOrder:(NSString *)paymentOrder
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;


// 获取缴费记录
+ (void)requestHouseId:(NSString *)houseId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;


// 修改缴费账号
+ (void)requestAccountId:(NSString *)accountId
                 company:(NSString *)company
                 account:(NSString *)account
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;


// 删除缴费账号
+ (void)requestAccountId:(NSString *)accountId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;
@end
