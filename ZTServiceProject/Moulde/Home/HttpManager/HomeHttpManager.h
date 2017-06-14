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
;
@end
