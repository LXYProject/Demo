//
//  HomeHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HomeHttpManager.h"
#import "AdvertisementModel.h"
#import "SecondHandModel.h" 
#import "RentHouseModel.h"
#import "ItemsModel.h"

@implementation HomeHttpManager

//首页物业轮播图
+ (void)requestBanner:(BannerType)bannerType
                 city:(NSString *)city
               zoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure {
    NSMutableDictionary *paramter = [[NSMutableDictionary alloc]init];
    [paramter setValue:city forKey:@"city"];
    NSString *url = nil;
    if (bannerType == Home_Banner) {
        url = A_UrlA;
    }
    else {
        [paramter setValue:zoneId forKey:@"zoneId"];
        url = A_UrlB;

        NSAssert(zoneId.length>0, @"请求物业的banner的时候zoneId不能为空");
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        NSArray *modelArray = [AdvertisementModel mj_objectArrayWithKeyValuesArray:response[@"adList"]];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//=======================================房屋服务====================================

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
                 failure:(HttpRequestFailure)failure{
    
//    CGFloat x = 0.0;
//    CGFloat y = 0.0;
//        CGFloat radius = 0.0;
    NSDictionary *paramter = @{@"queryType":@(queryType),
//                               @"keywords":keywords?keywords:@"",
//                               @"cityId":cityId?cityId:@"",
//                               @"districtId":districtId?districtId:@"",
//                               @"minPrice":minPrice?minPrice:@"",
//                               @"maxPrice":maxPrice?maxPrice:@"",
//                               @"houseType":houseType?houseType:@"",
//                               @"direction":direction?direction:@"",
//                               @"minArea":minArea?minArea:@"",
//                               @"maxArea":maxArea?maxArea:@"",
//                               @"heatingMode":heatingMode?heatingMode:@"",
//                               @"floor":floor?floor:@"",
//                               @"hasElevator":hasElevator?hasElevator:@"",
                               @"sort":sort?sort:@"",
//                               @"x":@(x),
//                               @"y":@(y),
//                               @"radius":@(radius),
                               @"page":@(pageNum),
                               @"pageCount":@(10),
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_queryRent paramter:paramter success:^(id response) {
        NSArray *modelArray = [RentHouseModel mj_objectArrayWithKeyValuesArray:response[@"houseRentList"]];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//出租
+ (void)requestHouseId:(NSString *)houseId
           houseNumber:(NSString *)houseNumber
            buildingId:(NSString *)buildingId
          buildingName:(NSString *)buildingName
             villageId:(NSString *)villageId
           villageName:(NSString *)villageName
          isMaisonette:(NSString *)isMaisonette
             houseType:(NSString *)houseType
           heatingMode:(NSString *)heatingMode
         elevatorRatio:(NSString *)elevatorRatio
           hasElevator:(int)hasElevator
            houseFloor:(int)houseFloor
              floorAll:(int)floorAll
              rentArea:(double)rentArea
             direction:(NSString *)direction
            isBasement:(int)isBasement
          houseFitment:(NSString *)houseFitment
           houseUseful:(NSString *)houseUseful
             housePics:(NSString *)housePics
                cityId:(NSString *)cityId
              cityName:(NSString *)cityName
            districtId:(NSString *)districtId
          districtName:(NSString *)districtName
            provinceId:(NSString *)provinceId
          provinceName:(double)provinceName
                     x:(double)x
                     y:(double)y
              roadName:(NSString *)roadName
               address:(NSString *)address
             rentPrice:(double)rentPrice
           partOrTotal:(int)partOrTotal
       basicFacilities:(NSString *)basicFacilities
    extendedFacilities:(NSString *)extendedFacilities
             rentLimit:(NSString *)rentLimit
           description:(NSString *)description
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               @"houseNumber":houseNumber?houseNumber:@"",
                               @"buildingId":buildingId?buildingId:@"",
                               @"buildingName":buildingName?buildingName:@"",
                               @"villageId":villageId?villageId:@"",
                               @"villageName":villageName?villageName:@"",
                               @"isMaisonette":isMaisonette?isMaisonette:@"",
                               @"houseType":houseType?houseType:@"",
                               @"heatingMode":heatingMode?heatingMode:@"",
                               @"elevatorRatio":elevatorRatio?elevatorRatio:@"",
                               @"hasElevator":@(hasElevator),
                               @"houseFloor":@(houseFloor),
                               @"floorAll":@(floorAll),
                               @"rentArea":@(rentArea),
                               @"direction":direction?direction:@"",
                               @"isBasement":@(isBasement),
                               @"houseFitment":houseFitment?houseFitment:@"",
                               @"houseUseful":houseUseful?houseUseful:@"",
                               @"housePics":housePics?housePics:@"",
                               @"cityId":cityId?cityId:@"",
                               @"cityName":cityName?cityName:@"",
                               @"districtId":districtId?districtId:@"",
                               @"districtName":districtName?districtName:@"",
                               @"provinceId":provinceId?provinceId:@"",
                               @"provinceName":@(provinceName),
                               @"x":@(x),
                               @"y":@(y),
                               @"roadName":roadName?roadName:@"",
                               @"address":address?address:@"",
                               @"rentPrice":@(rentPrice),
                               @"partOrTotal":@(partOrTotal),
                               @"basicFacilities":basicFacilities?basicFacilities:@"",
                               @"extendedFacilities":extendedFacilities?extendedFacilities:@"",
                               @"rentLimit":rentLimit?rentLimit:@"",
                               @"description":description?description:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_rent paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//停止出租
+(void)requestHouseRentId:(NSString *)houseRentId
                  houseId:(NSString *)houseId
               rentStatus:(NSString *)rentStatus
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseRentId":houseRentId?houseRentId:@"",
                               @"houseId":houseId?houseId:@"",
                               @"rentStatus":rentStatus?rentStatus:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_stopRent paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//收藏租房信息
+(void)requestHouseRentId:(NSString *)houseRentId
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure{
   
    
    NSDictionary *paramter = @{@"houseRentId":houseRentId?houseRentId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_keepRent paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//小区信息
+(void)requestVillageId:(NSString *)villageId
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
  
    NSDictionary *paramter = @{@"villageId":villageId?villageId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_villageInfo paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//房屋信息
+(void)requestHouseId:(NSString *)houseId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_houseInfo paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}




//=========================================二手物品=======================================

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
                 failure:(HttpRequestFailure)failure{
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    //    CGFloat radius = 0.0;
    NSDictionary *paramter = @{@"queryType":@(queryType),
                               @"secondInfoId":secondInfoId?secondInfoId:@"",
                               @"keywords":keywords?keywords:@"",
                               @"classId":classId?classId:@"",
                               @"resId":resId?resId:@"",
                               @"cityId":cityId?cityId:@"",
                               @"districtId":districtId?districtId:@"",
                               @"minPrice":minPrice?minPrice:@"",
                               @"maxPrice":maxPrice?maxPrice:@"",
                               @"newOrOld":newOrOld?newOrOld:@"",
                               @"delivery":delivery?delivery:@"",
                               @"sort":sort?sort:@"",
                               @"x":@(x),
                               @"y":@(y),
                               //                               @"radius":@(radius),
                               @"page":@(pageNum),
                               @"pageCount":@(10),
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_query paramter:paramter success:^(id response) {
        NSArray *modelArray = [SecondHandModel mj_objectArrayWithKeyValuesArray:response[@"secondHandList"]];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
    
}


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
            oriPrice:(double)oriPrice
            secPrice:(double)secPrice
            delivery:(int)delivery
             classId:(NSString *)classId
            newOrOld:(double)newOrOld
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"title":title?title:@"",
                               @"content":content?content:@"",
                               @"pictures":pictures?pictures:@"",
                               @"cityId":cityId?cityId:@"",
                               @"districtId":districtId?districtId:@"",
                               @"address":address?address:@"",
                               @"resId":resId?resId:@"",
                               @"resName":resName?resName:@"",
                               @"x":x?x:@"",
                               @"y":y?y:@"",
                               @"oriPrice":@(oriPrice),
                               @"secPrice":@(secPrice),
                               @"delivery":@(delivery),
                               @"classId":classId?classId:@"",
                               @"newOrOld":@(newOrOld),
                               };

    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_publish paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//二手物品分类
+(void)requestItemsId:(NSString *)ItemsId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"id":ItemsId?ItemsId:@""};
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_catalog paramter:paramter success:^(id response) {
//        NSArray *modelArray = [ItemsModel mj_objectArrayWithKeyValuesArray:response[@"childList"]];
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//停止发布
+(void)requestSecondHandId:(NSString *)secondHandId
                    status:(NSString *)status
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               @"status":status?status:@""};
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_stopPublish paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//删除回复
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
              subCommentId:(NSString *)subCommentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               @"commentId":commentId?commentId:@"",
                               @"subCommentId":subCommentId?subCommentId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_seconddeleteReply paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//对评论点赞
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               @"commentId":commentId?commentId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_commentThumbsUp paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//收藏
+(void)requestSecondHandId:(NSString *)secondHandId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_keep paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//评论
+(void)requestSecondHandId:(NSString *)secondHandId
                   comment:(NSString *)comment
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               @"comment":comment?comment:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_secondReply paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//对评论回复
+(void)requestSecondHandId:(NSString *)secondHandId
                 commentId:(NSString *)commentId
                   comment:(NSString *)comment
               commentType:(NSString *)commentType
              subCommentId:(NSString *)subCommentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"secondHandId":secondHandId?secondHandId:@"",
                               @"commentId":commentId?commentId:@"",
                               @"comment":comment?comment:@"",
                               @"commentType":commentType?commentType:@"",
                               @"subCommentId":subCommentId?subCommentId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_replyComment paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
