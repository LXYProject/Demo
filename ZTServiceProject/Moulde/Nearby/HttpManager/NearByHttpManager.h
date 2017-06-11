//
//  NearByHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.

//

#import <Foundation/Foundation.h>

@interface NearByHttpManager : NSObject


//去帮忙
+ (void)requestQuery:(NSString *)query
                 page:(NSString *)page
            pageCount:(NSString *)pageCount
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;

+ (void)requestDataWithQuery:(NSString *)query
                    keyWords:(NSString *)keyWords
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


//周边的网络请求
+ (void)requestDataWithQuery:(NSInteger)query
                     KeyWord:(NSString *)keyWord
                        city:(NSString *)city
                    district:(NSString *)district
                  categoryId:(NSString *)categoryId
                        sort:(NSString *)sort
                        page:(NSInteger)pageNum
                     success:(HttpRequestSuccess)success
                     failure:(HttpRequestFailure)failure;

@end
