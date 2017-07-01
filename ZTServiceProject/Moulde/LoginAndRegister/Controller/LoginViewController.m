//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginViewController.h"

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
    [self setSelectIndex:0];
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    [PushManager pushViewControllerWithName:@"RegisterOneController" animated:YES block:nil];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;

    if (selectIndex == 0) {
        [self btnClick:self.btn1];
        
    }
    else {
        [self btnClick:self.btn2];

    }
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
        self.label1.text = @"账号";
        self.label2.text = @"密码";
        self.textField1.placeholder = @"请输入您的账号";
        self.textField2.placeholder = @"请输入您的密码";
        self.forgetBtn.hidden = NO;
        self.btn2.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn1.backgroundColor = UIColorFromRGB(0xffffff);

    }else{
        self.label1.text = @"手机号";
        self.label2.text = @"验证码";
        self.textField1.placeholder = @"请输入您的手机号";
        self.textField2.placeholder = @"请输入您的验证码";
        self.forgetBtn.hidden = YES;
        self.btn1.backgroundColor = UIColorFromRGB(0xE8E8E8);
        self.btn2.backgroundColor = UIColorFromRGB(0xffffff);
    }

}
- (IBAction)forgetBtnClick {
}

- (IBAction)loginBtnClick {
}
@end
