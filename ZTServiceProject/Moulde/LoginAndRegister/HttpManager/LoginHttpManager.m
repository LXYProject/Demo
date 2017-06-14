//
//  LoginHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginHttpManager.h"
#import "LoginDataModel.h"

@implementation LoginHttpManager

+ (void)requestLoginRegisterCode:(LoginRegisterCode)LoginRegisterCode
               phoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               };
    
    NSString *url = nil;
    if (LoginRegisterCode == LoginCode) {
        url = A_registerUrl;
    }
    else {
        url = A_loginUrl;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"code":code?code:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_registerCheck paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"code":code?code:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_loginCheck paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

+ (void)requestPhoneNum:(NSString *)phoneNum
               passWord:(NSString *)passWord
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"passWord":passWord?passWord:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_phoneNumLogin paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

+ (void)requestToken:(NSString *)token
           machineId:(NSString *)machineId
         machineName:(NSString *)machineName
          clientType:(NSString *)clientType
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"token":token?token:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_tokenLogin paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                  token:(NSString *)token
             clientType:(NSString *)clientType
            newPassWord:(NSString *)newPassWord
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"token":token?token:@"",
                               @"clientType":clientType?clientType:@"",
                               @"newPassWord":newPassWord?newPassWord:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updatePassWord paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
