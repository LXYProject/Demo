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
    VillagePanorama,   //查看小区全景
    AnnouncementList,  //公告列表
    ConvenienceService //便民服务
} ListOrPanorama;


typedef enum : NSUInteger {
    praise,        //表扬
    complaints     //投诉
} PraiseOrComplaint;

@interface TenementHttpManager : NSObject

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


@end
