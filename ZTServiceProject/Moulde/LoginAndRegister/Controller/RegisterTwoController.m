//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterTwoController.h"
#import "LoginHttpManager.h"

#define DeviceUUIDKey @"deviceUUID"
#define DeviceModel @"deviceModel"

@interface RegisterTwoController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterTwoController
{
    NSInteger _inter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.width * 0.01;
    self.sendBtn.layer.borderColor = [UIColor clearColor].CGColor;

    
}

// 注册验证码核对
- (void)checkCode
{
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    [LoginHttpManager requestPhoneNum:self.phoneNumberField.text machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel) code:self.phoneNumberField.text success:^(id response) {
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}

- (IBAction)sendBtnClick {
    
    
    [self checkCode];
    
    [PushManager pushViewControllerWithName:@"RegisterThreeController" animated:YES block:nil];
}


@end
