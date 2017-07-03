//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterOneController.h"
#import "LoginHttpManager.h"

@interface RegisterOneController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterOneController
{
    NSInteger _inter;
    NSString *_deviceUUID;
    NSString *_deviceModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.width * 0.01;
    self.sendBtn.layer.borderColor = [UIColor clearColor].CGColor;

    
    // 获取设备唯一标识符
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"deviceUUID==%@", deviceUUID);
    NSString *deviceModel = [[UIDevice currentDevice] model];
    NSLog(@"deviceModel==%@", deviceModel);

    [[NSUserDefaults standardUserDefaults] setObject:deviceUUID forKey:@"deviceUUID"];
    _deviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    NSLog(@"deviceID==%@", _deviceUUID);
    [[NSUserDefaults standardUserDefaults] setObject:deviceModel forKey:@"deviceModel"];
    _deviceModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceModel"];
    NSLog(@"deviceM==%@", _deviceModel);

}

// 注册发送验证码
- (void)sendCode{
   
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    
    [LoginHttpManager requestLoginRegisterCode:RegisterCode phoneNum:self.phoneNumberField.text machineId:_deviceUUID machineName:_deviceModel success:^(id response) {
        
        NSLog(@"response==%@", response);
        
        
    } failure:^(NSError *error, NSString *message) {
    }];



}


- (IBAction)sendBtnClick {
    
    if ([RegularTool isValidateMobile:self.phoneNumberField.text]) {
        
        [self sendCode];

        
        // 加跳转
        
        [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];
        
        // 不跳转
        //    phoneNumberField==18516835791
        //    2017-07-03 15:14:33.113183+0800 ZTServiceProject[5075:2090521] response1111=={
        //        phoneNumStatus = 1;
        //    }
        //    2017-07-03 15:14:33.113350+0800 ZTServiceProject[5075:2090521] response=={
        //        phoneNumStatus = 1;
        //    }

        
        
//        请求路径：http://192.168.1.96:8080/ZtscApp/Service?service=user&function=getCodeForRegister
//        ************* 请求参数：{
//        machineId = "7E62D14B-13E0-49FE-9C3F-11CB366FD6F7";
//        machineName = iPhone;
//        phoneNum = 18516835791;
//    }  ******** 请求错误信息：Error Domain=NSURLErrorDomain Code=-999 "cancelled" UserInfo={NSErrorFailingURLKey=http://192.168.1.96:8080/ZtscApp/Service?service=user&function=getCodeForRegister&machineId=7E62D14B-13E0-49FE-9C3F-11CB366FD6F7&machineName=iPhone&phoneNum=18516835791, NSLocalizedDescription=cancelled, NSErrorFailingURLStringKey=http://192.168.1.96:8080/ZtscApp/Service?service=user&function=getCodeForRegister&machineId=7E62D14B-13E0-49FE-9C3F-11CB366FD6F7&machineName=iPhone&phoneNum=18516835791}


        
    }else{
       [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
    }
    
    
}


@end
