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

@implementation HomeHttpManager

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
    CGFloat radius = 0.0;
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
                               @"radius":@(radius),
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
@end
