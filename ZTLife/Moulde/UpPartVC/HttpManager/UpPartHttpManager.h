//
//  UpPartHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpPartHttpManager : NSObject

// 请假--请假或审批查询
+ (void)requestApplyUserId:(NSString *)applyUserId
             approveUserId:(NSString *)approveUserId
                   leaveId:(NSString *)leaveId
               leaveTypeId:(NSString *)leaveTypeId
                  timeType:(NSString *)timeType
                 startTime:(NSString *)startTime
                   endTime:(NSString *)endTime
             approveStatus:(NSString *)approveStatus
                 machineId:(NSString *)machineId
               machineName:(NSString *)machineName
                clientType:(NSString *)clientType
                   success:(HttpRequestSuccess)success
                   failure:(HttpRequestFailure)failure;


// 获取同事列表
+ (void)requestMachineId:(NSString *)machineId
             machineName:(NSString *)machineName
              clientType:(NSString *)clientType
                   orgId:(NSString *)orgId
                  deptId:(NSString *)deptId
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;


// 排班计划--查
+ (void)requestWorkerId:(NSString *)workerId
                  orgId:(NSString *)orgId
                 deptId:(NSString *)deptId
              startTime:(NSString *)startTime
                endTime:(NSString *)endTime
          workShiftType:(NSString *)workShiftType
             workPlanId:(NSString *)workPlanId
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;


@end
