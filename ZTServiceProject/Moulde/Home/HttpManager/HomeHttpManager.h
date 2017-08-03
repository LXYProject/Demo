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


//=============================房屋服务=============================

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



//停止出租
+(void)requestHouseRentId:(NSString *)houseRentId
                  houseId:(NSString *)houseId
               rentStatus:(NSString *)rentStatus
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure;



//收藏租房信息
+(void)requestHouseRentId:(NSString *)houseRentId
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure;



//小区信息
+(void)requestVillageId:(NSString *)villageId
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;


//房屋信息
+(void)requestHouseId:(NSString *)houseId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;





//=============================二手物品=============================

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


//停止发布
+(void)requestSecondHandId:(NSString *)secondHandId
                    status:(NSString *)status
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;

//删除回复
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
              subCommentId:(NSString *)subCommentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


//对评论点赞
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


//收藏
+(void)requestSecondHandId:(NSString *)secondHandId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


//评论
+(void)requestSecondHandId:(NSString *)secondHandId
                   comment:(NSString *)comment
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


//对评论回复
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
                   comment:(NSString *)comment
               commentType:(NSString *)commentType
              subCommentId:(NSString *)subCommentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;
@end
