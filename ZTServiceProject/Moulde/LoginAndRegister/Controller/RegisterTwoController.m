//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterTwoController.h"
#import "LoginHttpManager.h"

#define PhoneNumberKey @"phoneNumber"
#define DeviceUUIDKey  @"deviceUUID"
#define DeviceModel    @"deviceModel"
@interface RegisterTwoController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation RegisterTwoController
{
    NSInteger _inter;
    NSString *_deviceUUID;
    NSString *_deviceModel;
    NSInteger countdownInt;
    NSTimer *newTimer;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.codeLabel.layer.masksToBounds = YES;
    self.codeLabel.layer.cornerRadius = self.codeLabel.bounds.size.width * 0.01;
    self.codeLabel.layer.borderColor = [UIColor clearColor].CGColor;
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

//    self.codeLabel.text = codeLabel;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBtnPressed)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    self.codeLabel.userInteractionEnabled = YES;
    self.codeLabel.multipleTouchEnabled = YES;
    [self.codeLabel addGestureRecognizer:tapGestureRecognizer];
}

// 注册发送验证码
- (void)sendCode{
    
    [LoginHttpManager requestLoginRegisterCode:RegisterCode phoneNum:GetValueForKey(@"phoneNumber") machineId:_deviceUUID machineName:_deviceModel success:^(id response) {
        NSLog(@"response==%@", response);
        
        NSString *phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        [[NSUserDefaults standardUserDefaults] setObject:phoneNumStatus forKey:@"phoneNumStatus"];
    } failure:^(NSError *error, NSString *message) {
    }];
    
}

// 注册验证码核对
- (void)checkCode
{
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    [LoginHttpManager requestPhoneNum:GetValueForKey(PhoneNumberKey) machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel) code:self.phoneNumberField.text success:^(id response) {
        NSLog(@"注册验证码核对==%@", response);
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}

#pragma mark - event response
- (void)codeBtnPressed{
    //每秒钟刷新一次倒计时显示
    countdownInt = 59;
    newTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountdown) userInfo:nil repeats:YES];
    //下面是初始化60s的设置 显示倒计时的最好用UILabel，如果用UIButton的时候文字切换的时候会有闪烁和相应时间长的问题；如果在下面不写初始化60s，而是再refreshCountdown里面写的话，单击完后也会有1s的相应才能切换到60s
    self.codeLabel.userInteractionEnabled = NO;
    self.codeLabel.text = @"59秒";
    self.codeLabel.font = [UIFont systemFontOfSize:12];
//    self.codeLabel.textColor = [UIColor blueColor];
    self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
    
    //调用
    [self sendCode];

}
#pragma mark- private methods
//验证码倒计时
- (void)refreshCountdown{
    countdownInt--;
    NSString *resendStr = @"重获验证码";
    NSString *tempStr;
    tempStr = [NSString stringWithFormat:@"%ld秒",(long)countdownInt];
    
    if (countdownInt <= 0) {
        [newTimer invalidate];//必须写，否则多个计时器
        self.codeLabel.userInteractionEnabled = YES;
        self.codeLabel.text = resendStr;
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        self.codeLabel.textColor = [UIColor blueColor];
        //        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
        self.codeLabel.backgroundColor = [UIColor clearColor];
        
    }else{
        self.codeLabel.userInteractionEnabled = NO;
        self.codeLabel.text = tempStr;
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
    }
}


- (IBAction)sendBtnClick {
    
    if ([GetValueForKey(@"phoneNumStatus") integerValue] ==1) {
        
        [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];

    }else{
        [PushManager pushViewControllerWithName:@"RegisterThreeController" animated:YES block:nil];
 
    }
    
}


@end
