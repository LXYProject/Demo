//
//  HomeHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Home_Banner,
    Tenement_Banner
} BannerType;

@interface HomeHttpManager : NSObject

//首页物业轮播图
+ (void)requestBanner:(BannerType)bannerType
                 city:(NSString *)city
               zoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;


//二手物品查询
+ (void)requestQueryType:(NSInteger)queryType
            secondInfoId:(NSString *)secondInfoId
                keywords:(NSString *)keywords
                 classId:(NSString *)classId
                   resId:(NSString *)resId
                  cityId:(NSString *)cityId
              districtId:(NSString *)districtId
                minPrice:(NSString *)minPrice
                maxPrice:(NSString *)maxPrice
                newOrOld:(NSString *)newOrOld
                delivery:(NSString *)delivery
                    sort:(NSString *)sort
                 pageNum:(NSInteger)pageNum
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;

//租房查询
+ (void)requestQueryType:(NSInteger)queryType
                keywords:(NSString *)keywords
                  cityId:(NSString *)cityId
              districtId:(NSString *)districtId
                minPrice:(NSString *)minPrice
                maxPrice:(NSString *)maxPrice
               houseType:(NSString *)houseType
               direction:(NSString *)direction
                 minArea:(NSString *)minArea
                 maxArea:(NSString *)maxArea
             heatingMode:(NSString *)heatingMode
                   floor:(NSString *)floor
             hasElevator:(NSString *)hasElevator
            houseFitment:(NSString *)houseFitment
         basicFacilities:(NSString *)basicFacilities
      extendedFacilities:(NSString *)extendedFacilities
                    sort:(NSString *)sort
                 pageNum:(NSInteger)pageNum
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;

//二手物品发布
+ (void)requestTitle:(NSString *)title
             content:(NSString *)content
            pictures:(NSString *)pictures
              cityId:(NSString *)cityId
          districtId:(NSString *)districtId
             address:(NSString *)address
               resId:(NSString *)resId
             resName:(NSString *)resName
                   x:(NSString *)x
                   y:(NSString *)y
            oriPrice:(NSString *)oriPrice
            secPrice:(NSString *)secPrice
            delivery:(NSString *)delivery
             classId:(NSString *)classId
            newOrOld:(NSString *)newOrOld
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;


//二手物品分类
+(void)requestItemsId:(NSString *)ItemsId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;



@end
