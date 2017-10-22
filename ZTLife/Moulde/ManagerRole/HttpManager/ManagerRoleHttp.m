//
//  ManagerRoleHttp.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ManagerRoleHttp.h"
#import "SignTokenModel.h"
#import "ShiftTypeModel.h"

@implementation ManagerRoleHttp

// 班次类型--查
+ (void)requestcode:(NSString *)code
               name:(NSString *)name
        workShiftId:(NSString *)workShiftId
          machineId:(NSString *)machineId
        machineName:(NSString *)machineName
         clientType:(NSString *)clientType
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"code":code?code:@"",
                               @"name":name?name:@"",
                               @"workShiftId":workShiftId?workShiftId:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_queryWorkShift paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [ShiftTypeModel mj_objectArrayWithKeyValuesArray:response[@"propertyWorkShiftList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//获取签到签退令牌
+ (void)requestSignTokenSuccess:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{};
    [[HttpAPIManager sharedHttpAPIManager]getWithOneUrl:A_getSignToken paramter:paramter success:^(id response) {
        
//        SignTokenModel *model = [SignTokenModel mj_objectWithKeyValues:response];
//        success(model);
        success(response);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

// 签到
+ (void)requestSignType:(SignType)signType
              SignToken:(NSString *)signToken
             workPlanId:(NSString *)workPlanId
                   gpsX:(NSString *)gpsX
                   gpsY:(NSString *)gpsY
              locationX:(NSString *)locationX
              locationY:(NSString *)locationY
           locationName:(NSString *)locationName
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;{
    NSDictionary *paramter = @{@"signToken":signToken?signToken:@"",
                               @"workPlanId":workPlanId?workPlanId:@"",
                               @"gpsX":gpsX?gpsX:@"",
                               @"gpsY":gpsY?gpsY:@"",
                               @"locationX":locationX?locationX:@"",
                               @"locationY":locationY?locationY:@"",
                               @"locationName":locationName?locationName:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    NSString *url = nil;
    if (signType == Sign_in) {
        url = A_signIn;
    }else {
        url = A_signOut;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        
//        NSArray *modelArray = [PublicThingsOneModel mj_objectArrayWithKeyValuesArray:response[@"propertyLeaveList"]];
//        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

@end
