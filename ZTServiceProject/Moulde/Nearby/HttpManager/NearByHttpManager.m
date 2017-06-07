//
//  NearByHttpManager.m
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByHttpManager.h"
#import "NearByItemModel.h"
@implementation NearByHttpManager
+ (void)requestDataWithKeyWord:(NSString *)keyWord
                          city:(NSString *)city
                      district:(NSString *)district
                    categoryId:(NSString *)categoryId
                          sort:(NSString *)sort
                          page:(NSInteger)pageNum
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure {
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    CGFloat radius = 0.0;
    NSDictionary *paramter = @{@"keyWords":keyWord?keyWord:@"",
                               @"x":@(x),
                               @"y":@(y),
                               @"radius":@(radius),
                               @"city":city?city:@"",
                               @"district":district?district:@"",
                               @"categoryId":categoryId?categoryId:@"",
                               @"sort":sort?sort:@"",
                               @"page":@(pageNum),
                               @"pageCount":@(10),
                               };
    [[HttpAPIManager sharedHttpAPIManager]postWithUrl:@"" paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}
@end
