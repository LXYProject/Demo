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

//用户注册登录获取验证码
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
        url = A_loginUrl;
    }
    else {
        url = A_registerUrl;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:url paramter:paramter success:^(id response) {
        success(response);
        
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
//        success(modelArray);
        
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//注册验证码核对
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
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_registerCheck paramter:paramter success:^(id response) {
        
        success(response);
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
//        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//登录验证码核对
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

//手机号密码登录
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
        NSLog(@"response%@", response);
        
        success(response);
//        LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
//        success(model);
        
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//token登陆
+ (void)requestMachineId:(NSString *)machineId
         machineName:(NSString *)machineName
          clientType:(NSString *)clientType
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
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

//修改密码
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                  token:(NSString *)token
            newPassWord:(NSString *)newPassWord
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"token":token?token:@"",
                               @"newPassWord":newPassWord?newPassWord:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_updatePassWord paramter:paramter success:^(id response) {
        
        success(response);
        
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
//        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//修改个人信息
+ (void)requestProps:(NSString *)props
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"props":props?props:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateUser paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//修改头像
+ (void)requestImage:(NSString *)image
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"image":image?image:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateHeadImage paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//上传个人图片
+ (void)requestImages:(NSString *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
}


//通过id查询用户信息
+ (void)requestTargetUserId:(NSString *)targetUserId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"targetUserId":targetUserId?targetUserId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_findUserInfoById paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//通过手机号查询用户信息
+ (void)requestPhone:(NSString *)phone
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phone":phone?phone:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_findUserInfoById paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
