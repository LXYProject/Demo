//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterTwoController.h"
#import "LoginHttpManager.h"
#import "LoginDataModel.h"  

@interface RegisterTwoController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation RegisterTwoController
{
    NSInteger _inter;
    NSString *_deviceUUID;
    NSString *_deviceModel;
    NSInteger countdownInt;
    NSTimer *newTimer;
    BOOL request;
    NSString *_status;
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

    if (request==NO) {
        [self codeBtnPressed];
    }


    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBtnPressed)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    self.codeLabel.userInteractionEnabled = YES;
    self.codeLabel.multipleTouchEnabled = YES;
    [self.codeLabel addGestureRecognizer:tapGestureRecognizer];
    
    self.sendBtn.enabled = NO;
    [self.phoneNumberField addTarget:self action:@selector(reformatPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
}
-(void)reformatPhoneNumber:(UITextField *)textField {
    
    if (textField.text.length>0){
        self.sendBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        self.sendBtn.enabled = YES;
    }
    else{
        self.sendBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        self.sendBtn.enabled = NO;
    }
    
}

// 注册发送验证码
- (void)sendCode{
    
    [LoginHttpManager requestLoginRegisterCode:RegisterCode
                                      phoneNum:GetValueForKey(@"phoneNumber")
                                     machineId:GetValueForKey(DeviceUUIDKey)
                                   machineName:GetValueForKey(DeviceModelKey)
                                       success:^(id response) {
                                           NSLog(@"注册发送验证码==%@", response);
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           //[_hud hide:YES];
                                       }];
}

#pragma mark - event response
- (void)codeBtnPressed{
    //每秒钟刷新一次倒计时显示
    countdownInt = 60;
    newTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountdown) userInfo:nil repeats:YES];
    //下面是初始化60s的设置 显示倒计时的最好用UILabel，如果用UIButton的时候文字切换的时候会有闪烁和相应时间长的问题；如果在下面不写初始化60s，而是再refreshCountdown里面写的话，单击完后也会有1s的相应才能切换到60s
    self.codeLabel.userInteractionEnabled = NO;
    self.codeLabel.text = @"重新获取(60)";
    self.codeLabel.font = [UIFont systemFontOfSize:12];
//    self.codeLabel.textColor = [UIColor blueColor];
    self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
    
    //发送验证码
    [self sendCode];
}
#pragma mark- private methods
//验证码倒计时
- (void)refreshCountdown{
    countdownInt--;
    NSString *resendStr = @"重获验证码";
    NSString *tempStr;
    tempStr = [NSString stringWithFormat:@"重新获取(%ld)",(long)countdownInt];
    
    if (countdownInt <= 0) {
        [newTimer invalidate];//必须写，否则多个计时器
        self.codeLabel.userInteractionEnabled = YES;
        self.codeLabel.text = resendStr;
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        //self.codeLabel.textColor = [UIColor blueColor];
        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
        //self.codeLabel.backgroundColor = [UIColor clearColor];
        
    }else{
        self.codeLabel.userInteractionEnabled = NO;
        self.codeLabel.text = tempStr;
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
    }
}


- (IBAction)sendBtnClick {
//    [PushManager pushViewControllerWithName:@"RegisterThreeController" animated:YES block:nil];
//    return;
    
    // 注册验证码核对
    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
    [LoginHttpManager requestPhoneNum:GetValueForKey(PhoneNumberKey)
                            machineId:GetValueForKey(DeviceUUIDKey)
                          machineName:GetValueForKey(DeviceModelKey)
                                 code:self.phoneNumberField.text
                              success:^(id response) {
                                  NSLog(@"注册验证码核对==%@", response);
                                  _status = [response objectForKey:@"status"];
                                  
                                  NSString *token = [response objectForKey:TokenKey];
                                  NSString *gender = [response objectForKey:GenderKey];
                                  NSString *headImageUrl = [response objectForKey:HeadImageKey];
                                  NSString *huanxinUserName = [response objectForKey:HuanxinUserNameKey];
                                  NSString *huanxinUserpassword = [response objectForKey:HuanxinUserpasswordKey];
                                  NSString *isIdentification = [response objectForKey:IsIdentificationKey];
                                  NSString *nickName = [response objectForKey:NickNameKey];
                                  NSString *userId = [response objectForKey:UserIdKey];

                                  [[NSUserDefaults standardUserDefaults] setObject:token forKey:TokenKey];
                                  DefaultSaveKeyValue(gender, GenderKey);
                                  DefaultSaveKeyValue(headImageUrl, HeadImageKey);
                                  DefaultSaveKeyValue(huanxinUserName, HuanxinUserNameKey);
                                  DefaultSaveKeyValue(huanxinUserpassword, HuanxinUserpasswordKey);
                                  DefaultSaveKeyValue(isIdentification, IsIdentificationKey);
                                  DefaultSaveKeyValue(nickName, NickNameKey);
                                  DefaultSaveKeyValue(userId, UserIdKey);
                                  [[NSUserDefaults standardUserDefaults]synchronize];
                                  
                                  //LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
                                  
                                  // 成功
                                  if ([_status integerValue]==0) {
                                      
                                      [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];

                                  }else if ([_status integerValue]==1){
                                      [AlertViewController alertControllerWithTitle:@"提示" message:@"验证码输入错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                  }else{
                                      [AlertViewController alertControllerWithTitle:@"提示" message:@"注册失败" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                  }
                              } failure:^(NSError *error, NSString *message) {
    }];


}

- (void)delayMethod
{
    [PushManager pushViewControllerWithName:@"RegisterThreeController" animated:YES block:nil];
    
}
@end
