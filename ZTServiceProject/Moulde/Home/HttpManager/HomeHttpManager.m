//
//  HomeHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HomeHttpManager.h"
#import "AdvertisementModel.h"
@implementation HomeHttpManager

+ (void)requestBanner:(BannerType)bannerType
                 city:(NSString *)city
               zoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure {
    NSMutableDictionary *paramter = [[NSMutableDictionary alloc]init];
    [paramter setValue:city forKey:@"city"];
    if (bannerType == Home_Banner) {
    }
    else {
        [paramter setValue:zoneId forKey:@"zoneId"];
        NSAssert(zoneId.length==0, @"请求物业的banner的时候zoneId不能为空");
    }
    [[HttpAPIManager sharedHttpAPIManager]postWithUrl:@"" paramter:nil success:^(id response) {
        NSArray *modelArray = [AdvertisementModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}
@end
