//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHttpManager.h"

#define TokenKey @"token"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *inputBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation LoginViewController
{
    NSInteger countdownInt;
    NSTimer *newTimer;
    UIButton *_selectedBtn;
    NSString *_phoneNumStatus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"登录" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"注册" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    //圆角
    [self roundedCorners];
    
//    [self setSelectIndex:0];
    [self btnClick:self.btn1];
    
    self.textField1.keyboardType = UIKeyboardTypeNumberPad;
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBtnPressed)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    self.codeLabel.userInteractionEnabled = YES;
    self.codeLabel.multipleTouchEnabled = YES;
    [self.codeLabel addGestureRecognizer:tapGestureRecognizer];
    
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    [PushManager pushViewControllerWithName:@"RegisterOneController" animated:YES block:nil];
}
//圆角
- (void)roundedCorners
{
    self.codeLabel.layer.masksToBounds = YES;
    self.codeLabel.layer.cornerRadius = self.codeLabel.bounds.size.width * 0.01;
    self.codeLabel.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = self.loginBtn.bounds.size.width * 0.01;
    self.loginBtn.layer.borderColor = [UIColor clearColor].CGColor;
    

}
//手机号密码登录
- (void)passwordLogin
{
    NSLog(@"textField1%@textField2%@", self.textField1.text, self.textField1.text);
    
    // GetValueForKey(@"phoneNumber")
   [LoginHttpManager requestPhoneNum:self.textField1.text passWord:self.textField2.text machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel) clientType:@"" success:^(id response) {
       NSLog(@"手机号密码登录==%@", response);
       
       NSString *loginToken = [response objectForKey:@"token"];
       [[NSUserDefaults standardUserDefaults] setObject:loginToken forKey:@"loginToken"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       
       
   } failure:^(NSError *error, NSString *message) {
       
   }];
}

// 发送验证码
- (void)sendCode
{
    [LoginHttpManager requestLoginRegisterCode:LoginCode phoneNum:self.textField1.text machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel)  success:^(id response) {
        NSLog(@"验证码登录==%@",response);
        _phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}

// 登陆验证码核对
- (void)loginCodeCheck
{
    [LoginHttpManager requestPhoneNum:self.textField1.text machineId:GetValueForKey(DeviceUUIDKey) machineName:GetValueForKey(DeviceModel) code:self.textField2.text clientType:@"" success:^(id response) {
        NSLog(@"登陆验证码核对==%@",response);
        
    } failure:^(NSError *error, NSString *message) {
        
    }];

}
- (IBAction)loginBtnClick {
    
    if (_selectIndex==0) {
       //密码登录
        if (self.textField1.text.length>0 && self.textField2.text.length>0) {
    
            if ([RegularTool isValidateMobile:self.textField1.text]){
                
                //密码登录
//                [self passwordLogin];
                
//                if ([GetValueForKey(@"loginToken") length] > 0) {
                
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
//                }
                }else{
                [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
            }
        }else{
          [AlertViewController alertControllerWithTitle:@"提示" message:@"请输入手机号和密码" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }

    }else{
        //验证码登录
        if (self.textField1.text.length>0 && self.textField2.text.length>0) {
            if ([RegularTool isValidateMobile:self.textField1.text]){
                
                //验证码核对
//                [self loginCodeCheck];
                
//                if ([_phoneNumStatus integerValue] ==0) {
                
                    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
//                }
            }else{
                [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
            }
        }else{
            [AlertViewController alertControllerWithTitle:@"提示" message:@"请输入手机号和验证码" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }
    }
//    [self passwordLogin];
}
- (void)delayMethod
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)forgetBtnClick {
}

- (IBAction)btnClick:(UIButton *)sender {
    
    _selectedBtn.selected  = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation(sender==self.btn1?0:ScreenWidth/2, 0);
    }];
    
    //根据点击不同的btn赋值不同的数据
    if (sender == self.btn1) {
        _selectIndex = 0;
        self.label1.text = @"账号";
        self.label2.text = @"密码";
        self.textField1.placeholder = @"请输入您的账号";
        self.textField2.placeholder = @"请输入您的密码";
        self.forgetBtn.hidden = NO;
        self.codeLabel.hidden = YES;
        self.inputBtn.hidden = NO;
        self.btn2.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn1.backgroundColor = UIColorFromRGB(0xffffff);

    }else{
        _selectIndex = 1;
        self.label1.text = @"手机号";
        self.label2.text = @"验证码";
        self.textField1.placeholder = @"请输入您的手机号";
        self.textField2.placeholder = @"请输入您的验证码";
        self.forgetBtn.hidden = YES;
        self.codeLabel.hidden = NO;
        self.inputBtn.hidden = YES;
        self.btn1.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn2.backgroundColor = UIColorFromRGB(0xffffff);
    }

}
#pragma mark - event response
- (void)codeBtnPressed{
    
    if (self.textField1.text.length>0) {
        //每秒钟刷新一次倒计时显示
        countdownInt = 60;
        newTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountdown) userInfo:nil repeats:YES];
        //下面是初始化60s的设置 显示倒计时的最好用UILabel，如果用UIButton的时候文字切换的时候会有闪烁和相应时间长的问题；如果在下面不写初始化60s，而是再refreshCountdown里面写的话，单击完后也会有1s的相应才能切换到60s
        self.codeLabel.userInteractionEnabled = NO;
        self.codeLabel.text = @"";
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        //    self.codeLabel.textColor = [UIColor blueColor];
        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
        
        // 发送验证码
        //        [self sendCode];

    }else{
        [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert controller:self];
    }
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

- (IBAction)rightBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if(sender.selected) {// 按下去了就是明文
        NSString *tempPwdStr = self.textField2.text;
        self.textField2.text = @"";// 这句代码可以防止切换的时候光标偏移
        self.textField2.secureTextEntry = NO;
        self.textField2.text = tempPwdStr;
    }else{// 暗文
        NSString *tempPwdStr = self.textField2.text;
        self.textField2.text = @"";
        self.textField2.secureTextEntry = YES;
        self.textField2.text = tempPwdStr;
    }
    
}

@end
