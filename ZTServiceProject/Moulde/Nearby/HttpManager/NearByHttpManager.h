//
//  NearByHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.

//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ToHelp,
    LookingService
} NaerType;

@interface NearByHttpManager : NSObject

//周边的网络请求
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


@end
