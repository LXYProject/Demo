//
//  ChangeNickNameController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChangeSignatureController.h"
#import "RegisterFourController.h"


@interface ChangeSignatureController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, copy) NSString *signatureStr;

@end

@implementation ChangeSignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self titleViewWithTitle:@"修改个性签名" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"确定" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeyDone;


}

- (void)rightBarClick
{
    NSLog(@"确定");
    @weakify(self);
    [PushManager popViewControllerWithName:@"RegisterFourController" animated:YES block:^(RegisterFourController* viewController) {
        @strongify(self);
        viewController.signatureStr = self.signatureStr;
    }];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@", textField.text);
    self.signatureStr = textField.text;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    return NO;
}
@end
