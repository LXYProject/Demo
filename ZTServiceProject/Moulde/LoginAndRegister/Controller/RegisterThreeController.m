//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterThreeController.h"
#import "LoginHttpManager.h"
#import "RegisterFourController.h"

@interface RegisterThreeController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RegisterThreeController
{
    NSInteger _inter;
    NSString *_successStatus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = self.sureBtn.bounds.size.width * 0.01;
    self.sureBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.phoneNumberField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

}

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    
    if (self.phoneNumberField.text.length>0 && self.passwordField.text.length>0){
        self.sureBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        self.sureBtn.userInteractionEnabled = YES;
    }
    else{
        self.sureBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        self.sureBtn.userInteractionEnabled = NO;
    }
    
}

- (IBAction)sendBtnClick {

    if (self.phoneNumberField.text.length>0 && self.passwordField.text.length>0) {

        if ([self.phoneNumberField.text isEqualToString:self.passwordField.text]){
        
            // 修改密码
            [LoginHttpManager requestPhoneNum:GetValueForKey(PhoneNumberKey)
                                    machineId:GetValueForKey(DeviceUUIDKey)
                                  machineName:GetValueForKey(DeviceModelKey)
                                        token:GetValueForKey(TokenKey)
                                  newPassWord:self.phoneNumberField.text
                                      success:^(id response) {
                                          NSLog(@"修改密码%@", response);
                                          
                                          _successStatus = [response objectForKey:@"status"];
                                          
                                          // 成功
                                          if ([_successStatus integerValue] ==0) {
                                              
                                             // [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
                                              [PushManager pushViewControllerWithName:@"RegisterFourController" animated:YES block:^(RegisterFourController* viewController) {
                                                  
                                                  viewController.experience = 0;
                                              }];

                                          }else{
                                              [AlertViewController alertControllerWithTitle:@"提示" message:@"修改失败" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                          }
                                      } failure:^(NSError *error, NSString *message) {
                                      }];
        }else{
            [AlertViewController alertControllerWithTitle:@"提示" message:@"两次输入密码不一致" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }
    }else{
        [AlertViewController alertControllerWithTitle:@"提示" message:@"请输入密码和确认密码" preferredStyle:UIAlertControllerStyleAlert controller:self];

    }
    


}
- (void)delayMethod
{
    [PushManager pushViewControllerWithName:@"RegisterFourController" animated:YES block:^(RegisterFourController* viewController) {
        
        viewController.experience = 0;
        
    }];
}
- (IBAction)rightBtn:(UIButton *)sender {
    sender.selected = !sender.selected;

    if(sender.selected) {// 按下去了就是明文
        NSString *tempPwdStr = self.phoneNumberField.text;
        self.phoneNumberField.text = @"";// 这句代码可以防止切换的时候光标偏移
        self.phoneNumberField.secureTextEntry = NO;
        self.phoneNumberField.text = tempPwdStr;
        
        NSString *tempAgin = self.passwordField.text;
        self.passwordField.text = @"";// 这句代码可以防止切换的时候光标偏移
        self.passwordField.secureTextEntry = NO;
        self.passwordField.text = tempAgin;

        
    }else{// 暗文
        NSString *tempPwdStr = self.phoneNumberField.text;
        self.phoneNumberField.text = @"";
        self.phoneNumberField.secureTextEntry = YES;
        self.phoneNumberField.text = tempPwdStr;
        
        NSString *tempAgin = self.passwordField.text;
        self.passwordField.text = @"";
        self.passwordField.secureTextEntry = YES;
        self.passwordField.text = tempAgin;
        
        
    }

}
@end
