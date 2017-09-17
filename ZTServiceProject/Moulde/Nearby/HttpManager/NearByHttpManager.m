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
#import "ServiceModel.h"
@implementation NearByHttpManager

+ (void)requestDataWithNearType:(NaerType)nearType
                         query:(NSInteger )query
                       keyWord:(NSString *)keyWord
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
    
    if (nearType == ToHelp) {
    
        [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_HelpUrl paramter:paramter success:^(id response) {
            NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response];
            success(modelArray);
        } failure:^(NSError *error, NSString *message) {
            failure(error,message);
        }];
    }else {
        [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_FindUrl paramter:paramter success:^(id response) {
            NSArray *modelArray = [ServiceModel mj_objectArrayWithKeyValuesArray:response];
            success(modelArray);
        } failure:^(NSError *error, NSString *message) {
            failure(error,message);
        }];

    }

}

+ (void)requestDataWithNearType:(NaerType)nearType
                      machineId:(NSString *)machineId
                    machineName:(NSString *)machineName
                     clientType:(NSString *)clientType
                          query:(NSInteger)query
                     categoryId:(NSString *)categoryId
                           page:(NSInteger)page
                        success:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               @"query":@(query),
                               @"page":@(page),
                               @"pageCount":@(10),
                               };
    
    if (nearType == ToHelp) {
        
        [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_HelpUrl paramter:paramter success:^(id response) {
            NSArray *modelArray = [NearByItemModel mj_objectArrayWithKeyValuesArray:response[@"appealList"]];
            success(modelArray);
        } failure:^(NSError *error, NSString *message) {
            failure(error,message);
        }];
    }else {
        [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_FindUrl paramter:paramter success:^(id response) {
            NSArray *modelArray = [ServiceModel mj_objectArrayWithKeyValuesArray:response[@"serviceList"]];
            success(modelArray);
        } failure:^(NSError *error, NSString *message) {
            failure(error,message);
        }];
        
    }

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


//根据类型获取系统字典
+ (void)requestDictType:(NSString *)dictType
           parentDictId:(NSString *)parentDictId
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"dictType":dictType?dictType:@"",
                               @"parentDictId":parentDictId?parentDictId:@"",
                               @"parentDictId":parentDictId?parentDictId:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                                };

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_querySystemDict paramter:paramter success:^(id response) {
        NSArray *modelArray = [NearByTitleModel mj_objectArrayWithKeyValuesArray:response[@"dictItemList"]];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

    
}
//发布服务
+ (void)rqeuestTitle:(NSString *)title
             content:(NSString *)content
             address:(NSString *)address
              online:(int)online
               price:(NSString *)price
                unit:(NSString *)unit
          categoryId:(int)categoryId
        categoryName:(NSString *)categoryName
                area:(NSString *)area
              cityId:(NSString *)cityId
          districtId:(NSString *)districtId
                   x:(NSString *)x
                   y:(NSString *)y
               resId:(NSString *)resId
             resName:(NSString *)resName
              images:(NSString *)images
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"title":title?title:@"",
                               @"content":content?content:@"",
                               @"address":address?address:@"",
                               @"online":@(online),
                               @"price":price?price:@"",
                               @"unit":unit?unit:@"",
                               @"categoryId":@(categoryId),
                               @"categoryName":categoryName?categoryName:@"",
                               @"area":area?area:@"",
                               @"cityId":cityId?cityId:@"",
                               @"districtId":districtId?districtId:@"",
                               @"x":x?x:@"",
                               @"y":y?y:@"",
                               @"resId":resId?resId:@"",
                               @"resName":resName?resName:@"",
                               @"images":images?images:@"",
                               };

    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_releaseService paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//发布求助
+ (void)rqeuestTitle:(NSString *)title
             content:(NSString *)content
             address:(NSString *)address
               price:(NSString *)price
          categoryId:(int)categoryId
        categoryName:(NSString *)categoryName
           validDate:(NSString *)validDate
              cityId:(NSString *)cityId
          districtId:(NSString *)districtId
                   x:(NSString *)x
                   y:(NSString *)y
               resId:(NSString *)resId
             resName:(NSString *)resName
              images:(NSString *)images
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    //  @"categoryId":categoryId?categoryId:@"",

    NSDictionary *paramter = @{@"title":title?title:@"",
                               @"content":content?content:@"",
                               @"address":address?address:@"",
                               @"price":price?price:@"",
                               @"categoryId":@(categoryId),
                               @"categoryName":categoryName?categoryName:@"",
                               @"validDate":validDate?validDate:@"",
                               @"cityId":cityId?cityId:@"",
                               @"districtId":districtId?districtId:@"",
                               @"x":x?x:@"",
                               @"y":y?y:@"",
                               @"resId":resId?resId:@"",
                               @"resName":resName?resName:@"",
                               @"images":images?images:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_releaseAppeal paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//购买服务
+ (void)rqeuestPhoneNum:(NSString *)phoneNum
          serviceUserId:(NSString *)serviceUserId
              serviceId:(NSString *)serviceId
           serviceTitle:(NSString *)serviceTitle
         serviceContent:(NSString *)serviceContent
                  count:(NSString *)count
                  total:(NSString *)total
        appointmentTime:(NSString *)appointmentTime
           servicePrice:(NSString *)servicePrice
             serviceImg:(NSString *)serviceImg
            serviceUnit:(NSString *)serviceUnit
                 remark:(NSString *)remark
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"serviceUserId":serviceUserId?serviceUserId:@"",
                               @"serviceId":serviceId?serviceId:@"",
                               @"serviceTitle":serviceTitle?serviceTitle:@"",
                               @"serviceContent":serviceContent?serviceContent:@"",
                               @"count":count?count:@"",
                               @"total":total?total:@"",
                               @"appointmentTime":appointmentTime?appointmentTime:@"",
                               @"servicePrice":servicePrice?servicePrice:@"",
                               @"serviceImg":serviceImg?serviceImg:@"",
                               @"serviceUnit":serviceUnit?serviceUnit:@"",
                               @"remark":remark?remark:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_buyServiceOrderForm paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//购买求助
+ (void)rqeuestPhoneNum:(NSString *)phoneNum
          userHuanxinId:(NSString *)userHuanxinId
               appealId:(NSString *)appealId
            appealTitle:(NSString *)appealTitle
          appealContent:(NSString *)appealContent
            appealPrice:(NSString *)appealPrice
           appealUserId:(NSString *)appealUserId
        appointmentTime:(NSString *)appointmentTime
              appealImg:(NSString *)appealImg
                 remark:(NSString *)remark
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"userHuanxinId":userHuanxinId?userHuanxinId:@"",
                               @"appealId":appealId?appealId:@"",
                               @"appealTitle":appealTitle?appealTitle:@"",
                               @"appealContent":appealContent?appealContent:@"",
                               @"appealPrice":appealPrice?appealPrice:@"",
                               @"appointmentTime":appointmentTime?appointmentTime:@"",
                               @"appointmentTime":appointmentTime?appointmentTime:@"",
                               @"appealImg":appealImg?appealImg:@"",
                               @"remark":remark?remark:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_buyAppealOrderForm paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//对方接单前撤销购买服务, 求助
+ (void)requestServiceOrAppealCancel:(ServiceOrAppealCancel)serviceOrAppealCancel
                             orderId:(NSString *)orderId
                             success:(HttpRequestSuccess)success
                             failure:(HttpRequestFailure)failure{
    
    
    NSDictionary *paramter = @{@"orderId":orderId?orderId:@"",
                               };
    
    NSString *url = nil;
    
    if (serviceOrAppealCancel==BuyServiceCancel) {
        url = A_buyServiceCancelOrderAgo;
    }else{
        url = A_appealCancelOrderAgo;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//修改发布的服务状态
+ (void)rqeuestServiceId:(NSString *)serviceId
                  status:(int)status
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"serviceId":serviceId?serviceId:@"",
                               @"status":@(status)
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_cancelReleaseService paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}


//修改求助状态
+ (void)rqeuestAppealId:(NSString *)appealId
                 status:(int)status
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"appealId":appealId?appealId:@"",
                               @"status":@(status)
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_cancelReleaseAppeal paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//接受服务, 求助订单或拒绝
+ (void)requestDealServiceOrAppeal:(DealServiceOrAppeal)dealServiceOrAppeal
                           orderId:(NSString *)orderId
                        dealResult:(NSString *)dealResult
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"orderId":orderId?orderId:@"",
                               @"dealResult":dealResult?dealResult:@""
                               };
    
    NSString *url = nil;
    
    if (dealServiceOrAppeal==DealServiceOrder) {
        url = A_dealServiceOrderForm;
    }else{
        url = A_dealAppealOrderForm;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}
@end
