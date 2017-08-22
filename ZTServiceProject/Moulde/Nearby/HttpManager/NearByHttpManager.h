//
//  NearByHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.

//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HelpTitle,   //去帮忙
    ServiceTitle //找服务
} TitleType;


typedef enum : NSUInteger {
    ToHelp,        //去帮忙 搜索发布的服务
    LookingService //找服务 搜索发布的求助
} NaerType;

//对方接单前撤销购买服务, 求助
typedef enum : NSUInteger {
    BuyServiceCancel, //对方接单前撤销购买服务
    appealCancel      //对方接单前撤销下单的求助
} ServiceOrAppealCancel;

//接受服务, 求助订单或拒绝
typedef enum : NSUInteger {
    DealServiceOrder, //接受服务订单或拒绝
    DealAppealOrder   //接受求助订单或拒绝
} DealServiceOrAppeal;

@interface NearByHttpManager : NSObject

//周边的网络请求 搜索发布的服务,求助
+ (void)requestDataWithNearType:(NaerType)nearType
                       query:(NSInteger)query
                     keyWord:(NSString *)keyWord
                        city:(NSString *)city
                    district:(NSString *)district
                  categoryId:(NSString *)categoryId
                        sort:(NSString *)sort
                        page:(NSInteger)pageNum
                     success:(HttpRequestSuccess)success
                     failure:(HttpRequestFailure)failure;


//请求周边上面的滚动title
+ (void)rqeuestQueryType:(NSInteger)queryType
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;


//根据类型获取系统字典
+ (void)requestDictType:(NSString *)dictType
           parentDictId:(NSString *)parentDictId
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;
 

//发布服务
+ (void)rqeuestTitle:(NSString *)title
             content:(NSString *)content
             address:(NSString *)address
              online:(int)online
               price:(NSString *)price
                unit:(NSString *)unit
          categoryId:(int)categoryId
        categoryName:(NSString *)categoryName
                area:(NSString *)area
              cityId:(NSString *)cityId
          districtId:(NSString *)districtId
                   x:(NSString *)x
                   y:(NSString *)y
               resId:(NSString *)resId
             resName:(NSString *)resName
              images:(NSString *)images
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;


//发布求助
+ (void)rqeuestTitle:(NSString *)title
             content:(NSString *)content
             address:(NSString *)address
               price:(NSString *)price
          categoryId:(int)categoryId
        categoryName:(NSString *)categoryName
           validDate:(NSString *)validDate
              cityId:(NSString *)cityId
          districtId:(NSString *)districtId
                   x:(NSString *)x
                   y:(NSString *)y
               resId:(NSString *)resId
             resName:(NSString *)resName
              images:(NSString *)images
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;


//购买服务
+ (void)rqeuestPhoneNum:(NSString *)phoneNum
          serviceUserId:(NSString *)serviceUserId
              serviceId:(NSString *)serviceId
           serviceTitle:(NSString *)serviceTitle
         serviceContent:(NSString *)serviceContent
                  count:(NSString *)count
                  total:(NSString *)total
        appointmentTime:(NSString *)appointmentTime
           servicePrice:(NSString *)servicePrice
             serviceImg:(NSString *)serviceImg
            serviceUnit:(NSString *)serviceUnit
                 remark:(NSString *)remark
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;


//购买求助
+ (void)rqeuestPhoneNum:(NSString *)phoneNum
          userHuanxinId:(NSString *)userHuanxinId
               appealId:(NSString *)appealId
            appealTitle:(NSString *)appealTitle
          appealContent:(NSString *)appealContent
            appealPrice:(NSString *)appealPrice
           appealUserId:(NSString *)appealUserId
        appointmentTime:(NSString *)appointmentTime
              appealImg:(NSString *)appealImg
                 remark:(NSString *)remark
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;



//对方接单前撤销购买服务, 求助
+ (void)requestServiceOrAppealCancel:(ServiceOrAppealCancel)serviceOrAppealCancel
                             orderId:(NSString *)orderId
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure;


//修改发布的服务状态
+ (void)rqeuestServiceId:(NSString *)serviceId
                  status:(int)status
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;


//修改求助状态 DealServiceOrAppeal
+ (void)rqeuestAppealId:(NSString *)appealId
                 status:(int)status
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;


//接受服务, 求助订单或拒绝
+ (void)requestDealServiceOrAppeal:(DealServiceOrAppeal)dealServiceOrAppeal
                           orderId:(NSString *)orderId
                        dealResult:(NSString *)dealResult
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure;
@end
