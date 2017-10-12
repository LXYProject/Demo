//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterOneController.h"
#import "LoginHttpManager.h"
#import "RegisterTwoController.h"

@interface RegisterOneController ()<UITextFieldDelegate>//MBProgressHUDDelegate

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterOneController
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
    NSInteger _inter;
    NSString *_phoneNumStatus;
    UIButton *_button;
//    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"账号激活" titleColor:[UIColor whiteColor]];
    
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.width * 0.01;
    self.sendBtn.layer.borderColor = [UIColor clearColor].CGColor;

    self.sendBtn.enabled = NO;
    [self.phoneNumberField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

}
-(void)reformatAsPhoneNumber:(UITextField *)textField {
    
    if (textField.text.length>0){
        self.sendBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        self.sendBtn.enabled = YES;
    }
    else{
        self.sendBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        self.sendBtn.enabled = NO;
    }
    
}

- (IBAction)sendBtnClick {
//    [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];
//    return;
    if (_button.selected) {
        
        if ([RegularTool isValidateMobile:self.phoneNumberField.text]) {
            
            
            NSLog(@"注册手机号%@", self.phoneNumberField.text);
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"phoneNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
//            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            _hud.labelText = @"正在加载";
            
            // 用户注册获取验证码
            [LoginHttpManager requestLoginRegisterCode:RegisterCode
                                              phoneNum:self.phoneNumberField.text
                                             machineId:[getUUID getUUID]
                                           machineName:[Tools deviceVersion]
                                               success:^(id response) {
                                                   
//                                                   [_hud hide:YES];
                                                   NSLog(@"response==%@", response);_phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
                                                   
                                                   // 成功
                                                   if ([_phoneNumStatus integerValue] ==0) {
                                                       //[self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
//                                                       [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];
                                                       RegisterTwoController *registerTwoVC = [[RegisterTwoController alloc] init];
                                                       [self.navigationController pushViewController:registerTwoVC animated:YES];

                                                   }else if([_phoneNumStatus integerValue] ==1){
                                                       
                                                       [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                                   }else{
                                                       [AlertViewController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                                   }
                                               } failure:^(NSError *error, NSString *message) {
//                                                   [_hud hide:YES];
                                               }];
        }else{
            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }
    }else{
        [AlertViewController alertControllerWithTitle:@"提示" message:@"请先阅读并同意用户协议" preferredStyle:UIAlertControllerStyleAlert controller:self];
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
