//
//  NearByHttpManager.h
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearByHttpManager : NSObject

//周边的网络请求
+ (void)requestDataWithKeyWord:(NSString *)keyWord
                          city:(NSString *)city
                      district:(NSString *)district
                    categoryId:(NSString *)categoryId
                          sort:(NSString *)sort
                          page:(NSInteger)pageNum
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;
@end
