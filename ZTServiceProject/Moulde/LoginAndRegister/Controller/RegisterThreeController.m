//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterThreeController.h"
#import "LoginHttpManager.h"

@interface RegisterThreeController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RegisterThreeController
{
    NSInteger _inter;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = self.sureBtn.bounds.size.width * 0.01;
    self.sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
}

// 修改密码，设置密码
- (void)modifyPassword
{
    [LoginHttpManager requestPhoneNum:GetValueForKey(PhoneNumberKey) machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel) token:@"" newPassWord:self.phoneNumberField.text success:^(id response) {
        
        
    } failure:^(NSError *error, NSString *message) {
        
    }];

}
- (IBAction)sendBtnClick {
    [PushManager pushViewControllerWithName:@"RegisterFourController" animated:YES block:nil];
}

- (IBAction)rightBtn:(UIButton *)sender {
    sender.selected = !sender.selected;

    if(sender.selected) {// 按下去了就是明文
        NSString *tempPwdStr = self.phoneNumberField.text;
        self.phoneNumberField.text = @"";// 这句代码可以防止切换的时候光标偏移
        self.phoneNumberField.secureTextEntry = NO;
        self.phoneNumberField.text = tempPwdStr;
    }else{// 暗文
        NSString *tempPwdStr = self.phoneNumberField.text;
        self.phoneNumberField.text = @"";
        self.phoneNumberField.secureTextEntry = YES;
        self.phoneNumberField.text = tempPwdStr;
    }

}
@end
