//
//  UpPartHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "UpPartHttpManager.h"
#import "AddressBookModel.h"
#import "PublicThingsOneModel.h"

@implementation UpPartHttpManager


// 获取同事列表
+ (void)requestMachineId:(NSString *)machineId
             machineName:(NSString *)machineName
              clientType:(NSString *)clientType
                   orgId:(NSString *)orgId
                  deptId:(NSString *)deptId
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure{
   
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               @"orgId":orgId?orgId:@"",
                               @"deptId":deptId?deptId:@"",
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_queryColleagueList paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [AddressBookModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

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
                   failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"applyUserId":applyUserId?applyUserId:@"",
                               @"approveUserId":approveUserId?approveUserId:@"",
                               @"LeaveId":leaveId?leaveId:@"",
                               @"leaveTypeId":leaveTypeId?leaveTypeId:@"",
                               @"timeType":timeType?timeType:@"",
                               @"startTime":startTime?startTime:@"",
                               @"endTime":endTime?endTime:@"",
                               @"approveStatus":approveStatus?approveStatus:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_queryApplyOrApprove paramter:paramter success:^(id response) {
        
        NSArray *modelArray = [PublicThingsOneModel mj_objectArrayWithKeyValuesArray:response[@"propertyLeaveList"]];
        success(modelArray);
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

@end
