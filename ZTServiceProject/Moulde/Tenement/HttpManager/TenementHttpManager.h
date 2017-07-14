//
//  TenementHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

// 查看所有与我有关的房屋,小区
typedef enum : NSUInteger {
    praise,        //表扬
    complaints     //投诉
} PraiseOrComplaint;

@interface TenementHttpManager : NSObject

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
