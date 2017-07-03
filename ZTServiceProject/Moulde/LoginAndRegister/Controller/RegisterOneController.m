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
    UIButton *_button;
    BOOL disableloginBtn;
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
    _deviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    NSLog(@"deviceID==%@", _deviceUUID);
    [[NSUserDefaults standardUserDefaults] setObject:deviceModel forKey:@"deviceModel"];
    _deviceModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceModel"];
    NSLog(@"deviceM==%@", _deviceModel);

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:self.phoneNumberField.text];
    if (self.phoneNumberField.text.length>11) {
        self.sendBtn.userInteractionEnabled=YES;
       // self.rightBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_xiayibu"]];
        self.sendBtn.backgroundColor = [UIColor redColor];

    }else{
        self.sendBtn.userInteractionEnabled=NO;
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    }

}

// 注册发送验证码
- (void)sendCode{
   
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"phoneNumber"];

    [LoginHttpManager requestLoginRegisterCode:RegisterCode phoneNum:self.phoneNumberField.text machineId:_deviceUUID machineName:_deviceModel success:^(id response) {
        
        NSLog(@"response==%@", response);
        NSString *phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        [[NSUserDefaults standardUserDefaults] setObject:phoneNumStatus forKey:@"phoneNumStatus"];
    } failure:^(NSError *error, NSString *message) {
    }];

}


- (IBAction)sendBtnClick {
    
    
    
    
    if (_button.selected) {
        
        if ([RegularTool isValidateMobile:self.phoneNumberField.text] && self.phoneNumberField.text.length == 11) {
            
            if (disableloginBtn) {
                
            }
            self.sendBtn.userInteractionEnabled = YES;
            [self.sendBtn setBackgroundColor:[UIColor redColor]];
            
            [self sendCode];
            
            if ([GetValueForKey(@"phoneNumStatus") integerValue] ==0) {
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
            }else{
                [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];
            }
        }else{
            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }

    }else{
        [AlertViewController alertControllerWithTitle:@"提示" message:@"请先阅读并同意用户协议" preferredStyle:UIAlertControllerStyleAlert controller:self];
    }
    
    
//    if (_button.selected && [RegularTool isValidateMobile:self.phoneNumberField.text]) {
//        if ([GetValueForKey(@"phoneNumStatus") integerValue] ==0) {
//            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
//        }else{
//            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];
//        }
//
//    }else{
//        self.sendBtn.userInteractionEnabled = NO;
//    }
    
}

-(void)textChange
{
    if (self.phoneNumberField.text.length>11) {
        self.sendBtn.userInteractionEnabled=YES;
//        [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"btn_xiayibu"] forState:UIControlStateNormal];
        self.sendBtn.backgroundColor = [UIColor redColor];
    }else{
        self.sendBtn.userInteractionEnabled=NO;
        self.sendBtn.backgroundColor = [UIColor lightGrayColor];
    }

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
