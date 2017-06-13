//
//  LoginHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RegisterCode,
    LoginCode
} LoginRegisterCode;

@interface LoginHttpManager : NSObject

//用户注册登录获取验证码
+ (void)requestLoginRegisterCode:(LoginRegisterCode)LoginRegisterCode
               phoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;
//注册验证码核对
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;

@end
