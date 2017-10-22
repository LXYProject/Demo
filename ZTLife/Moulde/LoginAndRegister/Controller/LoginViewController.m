//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHttpManager.h"
#import "LoginDataModel.h"  
#import "RegisterOneController.h"

#import "MainVC.h"
#import "LeftVc.h"
#import "CyhSliderVC.h"


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

@property (nonatomic, strong) NSArray *loginDataSource;
@end

@implementation LoginViewController
{
    NSInteger countdownInt;
    NSTimer *newTimer;
    UIButton *_selectedBtn;
    NSString *_phoneNumStatus;
    
    NSString *_passwordLoginStatus;
}

// 禁止侧滑手势
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rt_disableInteractivePop = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.rt_disableInteractivePop = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.enabled = NO;
    [self titleViewWithTitle:@"登录" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"账号激活" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    //圆角
    [self roundedCorners];
    
//    [self setSelectIndex:0];
    [self btnClick:self.btn1];
    
    self.textField1.keyboardType = UIKeyboardTypeNumberPad;
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.textField1 addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    [self.textField2 addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    [self.loginBtn addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(codeBtnPressed)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    self.codeLabel.userInteractionEnabled = YES;
    self.codeLabel.multipleTouchEnabled = YES;
    [self.codeLabel addGestureRecognizer:tapGestureRecognizer];
    
}
- (void)rightBarClick
{
    //[PushManager pushViewControllerWithName:@"RegisterOneController" animated:YES block:nil];
    NSLog(@"账号激活");
    //[PushManager pushViewControllerWithName:@"RegisterOneController" animated:YES block:nil];
    RegisterOneController *registerOneVC = [[RegisterOneController alloc] init];
    [self.navigationController pushViewController:registerOneVC animated:YES];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"enabled"]) {
        if ([[change valueForKey:@"new"] boolValue]==YES) {
            self.loginBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        }
        else {
            self.loginBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        }
    }
}

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    
    if (self.textField1.text.length>0 && self.textField2.text.length>0){
        
        self.loginBtn.enabled = YES;
    }
    else{
        
        self.loginBtn.enabled = NO;
    }
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

// 发送验证码
- (void)sendCode
{
    [LoginHttpManager requestLoginRegisterCode:LoginCode phoneNum:self.textField1.text machineId:[getUUID getUUID] machineName:[Tools deviceVersion]  success:^(id response) {
        NSLog(@"发送验证码==%@",response);
        _phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}

- (IBAction)loginBtnClick {
    [[PushManager shareManager]pushToHomePage];
    return;
    
    if (_selectIndex==0) {
        if ([RegularTool isValidateMobile:self.textField1.text]){
            
            NSLog(@"手机号%@密码%@", self.textField1.text, self.textField2.text);
            //密码登录
            [LoginHttpManager requestPhoneNum:self.textField1.text
                                     passWord:self.textField2.text
                                    machineId:[getUUID getUUID]
                                  machineName:[Tools deviceVersion]
                                   clientType:@"0"
                                      success:^(LoginDataModel* response) {
                                          if ([response.status integerValue]==0) {
                                              
                                              [[UserInfoManager sharedUserInfoManager]saveUserModel:response];
                                              
                                              [[PushManager shareManager]pushToHomePage];

//                                              MainVC * mvc = [[MainVC alloc] init];
//                                              LeftVc * lvc = [[LeftVc alloc] init];
                                              
                                              //添加主页和左边控制器
//                                              [[CyhSliderVC initCyhslider] addMainVC:mvc addLeftVC:lvc];
                                              
//                                              [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[CyhSliderVC initCyhslider]];
                                              

                                              UIViewController *vc = [[CyhSliderVC alloc]init];
                                              [self.navigationController pushViewController:vc animated:YES];
                                              
                                              }else{
                                                  [AlertViewController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                            }
                                      } failure:^(NSError *error, NSString *message) {
                                      }];
        }else{
            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
        }
    }else{
        //验证码核对
        NSLog(@"验证码核对");
        [LoginHttpManager requestPhoneNum:self.textField1.text
                                machineId:[getUUID getUUID]
                              machineName:[Tools deviceVersion]
                                     code:self.textField2.text
                               clientType:@"0"
                                  success:^(LoginDataModel* response) {
                                      NSLog(@"登陆验证码核对==%@",response);
                                      if ([response.status integerValue]==0) {
                                          
                                          [[UserInfoManager sharedUserInfoManager]saveUserModel:response];
                                          //[self performSelector:@selector(delayMethod) withObject:nil afterDelay:2.0f];
                                          [PushManager popToRootViewControllerAnimated:YES];


                                      }else{
                                          [AlertViewController alertControllerWithTitle:@"提示" message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                      }
                                  } failure:^(NSError *error, NSString *message) {
                                  }];
    }

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
        self.textField2.secureTextEntry = YES;
        
        self.textField1.text = @"";
        self.textField2.text = @"";

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
        self.textField1.text = @"";
        self.textField2.text = @"";
        self.textField2.secureTextEntry = NO;
    }
    if (self.textField1.text.length>0&&self.textField2.text.length>0) {
        self.loginBtn.enabled = YES;
    }
    else {
        self.loginBtn.enabled = NO;
    }

}
#pragma mark - event response
- (void)codeBtnPressed{
    
    if ([RegularTool isValidateMobile:self.textField1.text]) {
        //每秒钟刷新一次倒计时显示
        countdownInt = 60;
        newTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountdown) userInfo:nil repeats:YES];
        //下面是初始化60s的设置 显示倒计时的最好用UILabel，如果用UIButton的时候文字切换的时候会有闪烁和相应时间长的问题；如果在下面不写初始化60s，而是再refreshCountdown里面写的话，单击完后也会有1s的相应才能切换到60s
        self.codeLabel.userInteractionEnabled = NO;
        self.codeLabel.text = @"重新获取(60)";
        self.codeLabel.font = [UIFont systemFontOfSize:12];
        //    self.codeLabel.textColor = [UIColor blueColor];
        self.codeLabel.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1] ;
        
        // 发送验证码
        [self sendCode];

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

- (void)dealloc {
    [self.loginBtn removeObserver:self forKeyPath:@"enabled"];
}

@end
