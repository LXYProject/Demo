//
//  ManagerRoleHttp.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Sign_in,    //签到
    Sign_back   //签退
} SignType;

@interface ManagerRoleHttp : NSObject


// 班次类型--查
+ (void)requestcode:(NSString *)code
               name:(NSString *)name
        workShiftId:(NSString *)workShiftId
          machineId:(NSString *)machineId
        machineName:(NSString *)machineName
         clientType:(NSString *)clientType
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure;


// 获取签到签退令牌
+ (void)requestSignTokenSuccess:(HttpRequestSuccess)success
                        failure:(HttpRequestFailure)failure;


// 签到, 签退
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
                 failure:(HttpRequestFailure)failure;

@end
