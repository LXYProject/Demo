//
//  ChatViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChatViewController.h"
#import "CommunityPeopleModel.h"

@interface ChatViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *publishedBtn;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:self.titleStr titleColor:[UIColor whiteColor]];
    
    self.publishedBtn.layer.masksToBounds = YES;
    self.publishedBtn.layer.cornerRadius = self.publishedBtn.bounds.size.width * 0.1;
    self.publishedBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.textField.delegate = self;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@", textField.text);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    return NO;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)publishedBtnClick {
    
    //发送消息
    EMMessage *aMessage;
    
    [[EMClient sharedClient].chatManager sendMessage:aMessage progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
    
    }];
}


@end
