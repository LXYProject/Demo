//
//  LoginHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户注册登录获取验证码
typedef enum : NSUInteger {
    RegisterCode,
    LoginCode
} LoginRegisterCode;

//退出登录, 物业用户手机令牌登陆
typedef enum : NSUInteger {
    Exit,
    TokenLogin
} ExitTokenLogin;

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

//登录验证码核对
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;

//手机号密码登录
+ (void)requestPhoneNum:(NSString *)phoneNum
               passWord:(NSString *)passWord
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;

//修改密码
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                  token:(NSString *)token
            newPassWord:(NSString *)newPassWord
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure;



//退出登录, 物业用户手机令牌登陆
+ (void)requestExitTokenLogin:(ExitTokenLogin)exitTokenLogin
                     phoneNum:(NSString *)phoneNum
                    machineId:(NSString *)machineId
                  machineName:(NSString *)machineName
                   clientType:(NSString *)clientType
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;


//token登陆
+ (void)requestMachineId:(NSString *)machineId
             machineName:(NSString *)machineName
              clientType:(NSString *)clientType
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure;

//修改个人信息
+ (void)requestProps:(NSString *)props
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;

//修改头像
//+ (void)requestImage:(UIImage *)image
//             success:(HttpRequestSuccess)success
//             failure:(HttpRequestFailure)failure;


+ (void)requestImage:(NSString *)image
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;

//上传个人图片
+ (void)requestImages:(NSString *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;



//通过id查询用户信息
+ (void)requestTargetUserId:(NSString *)targetUserId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure;


//通过手机号查询用户信息
+ (void)requestPhone:(NSString *)phone
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure;


@end
