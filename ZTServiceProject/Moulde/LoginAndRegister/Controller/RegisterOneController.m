//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterOneController.h"
#import "LoginHttpManager.h"

@interface RegisterOneController ()<UITextFieldDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterOneController
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
    NSInteger _inter;
    NSString *_deviceUUID;
    NSString *_deviceModel;
    NSString *_phoneNumStatus;
    UIButton *_button;
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.width * 0.01;
    self.sendBtn.layer.borderColor = [UIColor clearColor].CGColor;

    
    // 获取设备唯一标识符
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"deviceUUID==%@", deviceUUID);
    NSString *deviceModel = [[UIDevice currentDevice] model];
    NSLog(@"deviceModel==%@", deviceModel);

    [[NSUserDefaults standardUserDefaults] setObject:deviceUUID forKey:@"deviceUUID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _deviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    NSLog(@"deviceID==%@", _deviceUUID);
    [[NSUserDefaults standardUserDefaults] setObject:deviceModel forKey:@"deviceModel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    _deviceModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceModel"];
    NSLog(@"deviceM==%@", _deviceModel);

    
    [self.phoneNumberField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

}
-(void)reformatAsPhoneNumber:(UITextField *)textField {
    
    if (textField.text.length>0){
        self.sendBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        self.sendBtn.userInteractionEnabled = YES;
    }
    else{
        self.sendBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        self.sendBtn.userInteractionEnabled = NO;
    }
    
}

// 注册发送验证码
- (void)sendCode{
   
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    NSLog(@"注册手机号%@", self.phoneNumberField.text);
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"phoneNumber"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //_hud.mode = MBProgressHUDModeAnnularDeterminate;
    _hud.label.text = @"正在加载";
    
    [LoginHttpManager requestLoginRegisterCode:RegisterCode phoneNum:GetValueForKey(@"phoneNumber") machineId:_deviceUUID machineName:_deviceModel success:^(id response) {
        NSLog(@"response==%@", response);

        [_hud hideAnimated:YES];
        _phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        
    } failure:^(NSError *error, NSString *message) {
        [_hud hideAnimated:YES];

    }];

}


- (IBAction)sendBtnClick {
    
    
//    if (_button.selected) {
//        
//        if ([RegularTool isValidateMobile:GetValueForKey(@"phoneNumber")]) {
//            
//            //发送验证码
//            [self sendCode];
//            
//            if ([_phoneNumStatus integerValue] ==0) {
//                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
//
//            }else{
//                [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];
//            }
//        }else{
//            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
//        }
//
//    }else{
//        [AlertViewController alertControllerWithTitle:@"提示" message:@"请先阅读并同意用户协议" preferredStyle:UIAlertControllerStyleAlert controller:self];
//    }

    [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];

}

- (void)delayMethod
{
    [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];

}
- (IBAction)btnselect:(UIButton *)sender {
    sender.selected = !sender.selected;
    _button = sender;

}


@end
