//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterTwoController.h"

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
        
}
- (IBAction)sendBtnClick {
    [PushManager pushViewControllerWithName:@"RegisterThreeController" animated:YES block:nil];
}


@end
