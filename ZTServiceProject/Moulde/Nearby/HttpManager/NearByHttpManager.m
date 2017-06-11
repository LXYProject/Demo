//
//  NearByHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByHttpManager.h"
#import "NearByItemModel.h"
#import "NearByTitleModel.h"
@implementation NearByHttpManager

+ (void)requestQuery:(NSString *)query
                page:(NSString *)page
           pageCount:(NSString *)pageCount
             success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    NSMutableDictionary *paramter = [[NSMutableDictionary alloc]init];
    [paramter setValue:query forKey:@"query"];
    [paramter setValue:page forKey:@"page"];
    [paramter setValue:pageCount forKey:@"pageCount"];
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_HelpUrl paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


+ (void)requestDataWithQuery:(NSString *)query
                      keyWords:(NSString *)keyWords
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
    NSDictionary *paramter = @{@"query":query?query:@"",
                               @"x":@(x),
                               @"y":@(y),
                               @"radius":@(radius),
                               @"city":city?city:@"",
                               @"keyWords":keyWords?keyWords:@"",
                               @"district":district?district:@"",
                               @"categoryId":categoryId?categoryId:@"",
                               @"sort":sort?sort:@"",
                               @"page":@(pageNum),
                               @"pageCount":@(10),
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_HelpUrl paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 请求周边上面的滚动title
+ (void)rqeuestQueryType:(NSInteger)queryType
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure {
    NSDictionary *paramter = @{@"queryType":@(queryType)};
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_Leixin paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByTitleModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


+ (void)requestDataWithQuery:(NSInteger )query
                     KeyWord:(NSString *)keyWord
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
    NSDictionary *paramter = @{@"query":@(query),
                               @"keyWords":keyWord?keyWord:@"",
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
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_HelpUrl paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

@end
