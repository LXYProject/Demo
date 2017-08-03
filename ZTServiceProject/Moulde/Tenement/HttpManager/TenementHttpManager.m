//
//  TenementHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenementHttpManager.h"
#import "AnnounceModel.h"
#import "ServiceModel.h"
#import "ConvenServiceModel.h"
#import "VillagePanoramaModel.h"

@implementation TenementHttpManager

//===============================================物业接口=======================================

// 查看服务, 报事类型列表, 公告列表, 便民服务, 小区全景
+ (void)requestListOrPanorama:(ListOrPanorama)ListOrPanorama
                       zoneId:(NSString *)zoneId
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@""};
    
    NSString *url = nil;
    if (ListOrPanorama == ServiceList) {
        url = A_serviceList;
    }else if (ListOrPanorama==ListThings){
        url = A_affairCategoryList;
    }else if (ListOrPanorama==AnnouncementList){
        url = A_bulletinList;
    }else if (ListOrPanorama==ConvenienceService){
        url = A_convenience;
    }else{
        url = A_lookVillagePanorama;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        //success(response);
        if (ListOrPanorama==ServiceList) {
            NSArray *modelArray = [ServiceModel mj_objectArrayWithKeyValuesArray:response[@"serviceCategoryList"]];
            success(modelArray);
        }else if (ListOrPanorama==ListThings){
            NSArray *modelArray = [ServiceModel mj_objectArrayWithKeyValuesArray:response[@"affairCategoryList"]];
            success(modelArray);
        }else if (ListOrPanorama==AnnouncementList){
            NSArray *modelArray = [AnnounceModel mj_objectArrayWithKeyValuesArray:response[@"bulletinList"]];
            success(modelArray);
        }else if (ListOrPanorama==ConvenienceService){
            NSArray *modelArray = [ConvenServiceModel mj_objectArrayWithKeyValuesArray:response[@"serviceList"]];
            success(modelArray);
        }else{
            NSArray *modelArray = [VillagePanoramaModel mj_objectArrayWithKeyValuesArray:response[@"featureList"]];
            success(modelArray);
        }
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
// 发送上门服务信息
+ (void)requestZoneId:(NSString *)zoneId
         serviceTitle:(NSString *)serviceTitle
      serviceDiscribe:(NSString *)serviceDiscribe
      serviceCategory:(NSString *)serviceCategory
          serviceTime:(NSString *)serviceTime
          userAddress:(NSString *)userAddress
         userRealName:(NSString *)userRealName
         userPhoneNum:(NSString *)userPhoneNum
              houseId:(NSString *)houseId
            houseName:(NSString *)houseName
               images:(UIImage *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;

    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"serviceTitle":serviceTitle?serviceTitle:@"",
                               @"serviceDiscribe":serviceDiscribe?serviceDiscribe:@"",
                               @"serviceCategory":serviceCategory?serviceCategory:@"",
                               @"serviceTime":serviceTime?serviceTime:@"",
                               @"userAddress":userAddress?userAddress:@"",
                               @"userRealName":userRealName?userRealName:@"",
                               @"userPhoneNum":userPhoneNum?userPhoneNum:@"",
                               @"houseId":houseId?houseId:@"",
                               @"houseName":houseName?houseName:@"",
                               @"x":@(x),
                               @"y":@(y),
                               @"images":images?images:@""
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_lookvisitService paramter:paramter success:^(id response) {
        
//        NSArray *modelArray = [HouseListModel mj_objectArrayWithKeyValuesArray:response[@"houseList"]];
//        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 公共报事
+ (void)requestZoneId:(NSString *)zoneId
          affairTitle:(NSString *)affairTitle
       affairDiscribe:(NSString *)affairDiscribe
       affairCategory:(NSString *)affairCategory
          userAddress:(NSString *)userAddress
         userRealName:(NSString *)userRealName
         userPhoneNum:(NSString *)userPhoneNum
               images:(UIImage *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"affairTitle":affairTitle?affairTitle:@"",
                               @"affairDiscribe":affairDiscribe?affairDiscribe:@"",
                               @"affairCategory":affairCategory?affairCategory:@"",
                               @"userAddress":userAddress?userAddress:@"",
                               @"userRealName":userRealName?userRealName:@"",
                               @"userPhoneNum":userPhoneNum?userPhoneNum:@"",
                               @"x":@(x),
                               @"y":@(y),
                               @"images":images?images:@""
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_publicAffairList paramter:paramter success:^(id response) {
        
        //        NSArray *modelArray = [HouseListModel mj_objectArrayWithKeyValuesArray:response[@"houseList"]];
        //        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 表扬和投诉
+ (void)requestPraiseOrComplaint:(PraiseOrComplaint)praiseOrComplaint
                          zoneId:(NSString *)zoneId
                     affairTitle:(NSString *)affairTitle
                  affairDiscribe:(NSString *)affairDiscribe
                  affairCategory:(NSString *)affairCategory
                     userAddress:(NSString *)userAddress
                    userRealName:(NSString *)userRealName
                    userPhoneNum:(NSString *)userPhoneNum
                          images:(UIImage *)images
                         success:(HttpRequestSuccess)success
                         failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"affairTitle":affairTitle?affairTitle:@"",
                               @"affairDiscribe":affairDiscribe?affairDiscribe:@"",
                               @"affairCategory":affairCategory?affairCategory:@"",
                               @"userAddress":userAddress?userAddress:@"",
                               @"userRealName":userRealName?userRealName:@"",
                               @"userPhoneNum":userPhoneNum?userPhoneNum:@"",
                               @"images":images?images:@""
                               };

    
    NSString *url = nil;
    if (praiseOrComplaint == praise) {
        url = A_praise;
    }else{
        url = A_complain;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

// 查看待缴费账单
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
               status:(NSString *)status
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"houseId":houseId?houseId:@""};

    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_billList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 缴纳物业费
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              billIds:(NSString *)billIds
                 cost:(NSString *)cost
          paymentMode:(NSString *)paymentMode
         paymentOrder:(NSString *)paymentOrder
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"houseId":houseId?houseId:@"",
                               @"billIds":billIds?billIds:@"",
                               @"cost":cost?cost:@"",
                               @"paymentMode":paymentMode?paymentMode:@"",
                               @"paymentOrder":paymentOrder?paymentOrder:@"",
                               };

    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_pay paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}

// 查询缴费记录
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              success:(HttpRequestSuccess)success

              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"houseId":houseId?houseId:@""};
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_paymentList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 上报小区全景
+ (void)requestZoneId:(NSString *)zoneId
      featureCategory:(NSString *)featureCategory
          featureName:(NSString *)featureName
             featureX:(NSString *)featureX
             featureY:(NSString *)featureY
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"featureCategory":featureCategory?featureCategory:@"",
                               @"featureName":featureName?featureName:@"",
                               @"featureX":featureX?featureX:@"",
                               @"featureY":featureY?featureY:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_sendVillagePanorama paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 小区设施类型列表
+ (void)requestZoneId:(NSString *)zoneId
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@""};
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_villageFeatureTypeList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


// 获取物业费缴纳参数
+ (void)requestZoneId:(NSString *)zoneId
              houseId:(NSString *)houseId
              billIds:(NSString *)billIds
          paymentMode:(NSString *)paymentMode
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"zoneId":zoneId?zoneId:@"",
                               @"houseId":houseId?houseId:@"",
                               @"billIds":billIds?billIds:@"",
                               @"paymentMode":paymentMode?paymentMode:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_getCostParam paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


// 缴纳物业费成功后回执
+ (void)requestPaymentMode:(NSString *)paymentMode
                 paymentId:(NSString *)paymentId
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"paymentMode":paymentMode?paymentMode:@"",
                               @"paymentId":paymentId?paymentId:@""};
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_costSuccess paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


//===============================================生活缴费服务=======================================

// 根据房屋及缴费类型获取公司
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
              cityCode:(NSString *)cityCode
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               @"type":type?type:@"",
                               @"cityCode":cityCode?cityCode:@""
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_companyList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
 
}


// 获取缴费基本信息
+ (void)requestPaymentInfoSuccess:(HttpRequestSuccess)success
                          failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{};
                               
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_costBaseList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 绑定缴费账号
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
               company:(NSString *)company
               account:(NSString *)account
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               @"type":type?type:@"",
                               @"company":company?company:@"",
                               @"account":account?account:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_bindAccount paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


// 缴费
+ (void)requestHouseId:(NSString *)houseId
                  type:(NSString *)type
               company:(NSString *)company
               account:(NSString *)account
                  cost:(NSString *)cost
           paymentMode:(NSString *)paymentMode
          paymentOrder:(NSString *)paymentOrder
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               @"type":type?type:@"",
                               @"company":company?company:@"",
                               @"account":account?account:@"",
                               @"cost":cost?cost:@"",
                               @"paymentMode":paymentMode?paymentMode:@"",
                               @"paymentOrder":paymentOrder?paymentOrder:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_costing paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 获取缴费记录
+ (void)requestHouseId:(NSString *)houseId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"houseId":houseId?houseId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_costRecordList paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
}


// 修改缴费账号
+ (void)requestAccountId:(NSString *)accountId
                 company:(NSString *)company
                 account:(NSString *)account
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"accountId":accountId?accountId:@"",
                               @"company":company?company:@"",
                               @"account":account?account:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateCostAccount paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


// 删除缴费账号
+ (void)requestAccountId:(NSString *)accountId
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"accountId":accountId?accountId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_delCostAccount paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
