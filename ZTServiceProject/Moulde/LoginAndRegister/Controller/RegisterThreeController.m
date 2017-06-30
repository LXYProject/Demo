//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterThreeController.h"

@interface RegisterThreeController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
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
- (IBAction)sendBtnClick {
    [PushManager pushViewControllerWithName:@"RegisterFourController" animated:YES block:nil];
}


@end
