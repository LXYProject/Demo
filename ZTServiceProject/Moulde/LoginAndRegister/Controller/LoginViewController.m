//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHttpManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation LoginViewController
{
    UIButton *_selectedBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"登录" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"注册" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = self.loginBtn.bounds.size.width * 0.01;
    self.loginBtn.layer.borderColor = [UIColor clearColor].CGColor;
//    [self setSelectIndex:0];
    [self btnClick:self.btn1];
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    [PushManager pushViewControllerWithName:@"RegisterOneController" animated:YES block:nil];
}

//手机号密码登录
- (void)passwordLogin
{
    NSLog(@"sss%@sss%@", self.textField1.text, self.textField1.text);
    
    // GetValueForKey(@"phoneNumber")
   [LoginHttpManager requestPhoneNum:self.textField1.text passWord:self.textField2.text machineId:@"" machineName:GetValueForKey(DeviceModel) clientType:@"" success:^(id response) {
       
   } failure:^(NSError *error, NSString *message) {
       
   }];
}



- (IBAction)loginBtnClick {
    
    
    NSLog(@"%ld", _selectIndex);
    
    
    
    
//    if (self.textField1.text.length>0 && self.textField2.text.length>0) {
//        
//        if ([RegularTool isValidateMobile:self.textField1.text]){
//            
//        }else{
//            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式不正确" preferredStyle:UIAlertControllerStyleAlert controller:self];
//        }
//    }else{
//      [AlertViewController alertControllerWithTitle:@"提示" message:@"请输入手机号和密码" preferredStyle:UIAlertControllerStyleAlert controller:self];
//
//    }
//    [self passwordLogin];
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
        self.btn2.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn1.backgroundColor = UIColorFromRGB(0xffffff);

    }else{
        _selectIndex = 1;
        self.label1.text = @"手机号";
        self.label2.text = @"验证码";
        self.textField1.placeholder = @"请输入您的手机号";
        self.textField2.placeholder = @"请输入您的验证码";
        self.forgetBtn.hidden = YES;
        self.btn1.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn2.backgroundColor = UIColorFromRGB(0xffffff);
    }

}

@end
