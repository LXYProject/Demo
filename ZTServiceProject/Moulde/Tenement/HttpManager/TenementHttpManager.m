//
//  TenementHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenementHttpManager.h"
#import "AnnounceModel.h"

@implementation TenementHttpManager

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
    }else if (ListOrPanorama==VillagePanorama){
        url = A_lookVillagePanorama;
    }else if (ListOrPanorama==AnnouncementList){
        url = A_bulletinList;
    }else{
        url = A_convenience;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        //success(response);
        if (ListOrPanorama==ServiceList) {
            
        }else if (ListOrPanorama==ListThings){
            
        }else if (ListOrPanorama==VillagePanorama){
            
        }else if (ListOrPanorama==AnnouncementList){
            NSArray *modelArray = [AnnounceModel mj_objectArrayWithKeyValuesArray:response[@"bulletinList"]];
            success(modelArray);
        }else{
            
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
        url = A_praiseList;
    }else{
        url = A_complainList;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
