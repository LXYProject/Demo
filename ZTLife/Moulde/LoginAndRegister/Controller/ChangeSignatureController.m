//
//  ChangeNickNameController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChangeSignatureController.h"
#import "RegisterFourController.h"
#import "LoginHttpManager.h"

@interface ChangeSignatureController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

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
    
    NSDictionary  *dict = @{@"selfIntroduction":self.textField.text};
    
    NSString *jsonStr = [Tools convertToJsonData:dict];
    
    NSLog(@"=================%@", [Tools convertToJsonData:dict]);
    
    @weakify(self);
    [LoginHttpManager requestProps:jsonStr
                           success:^(id response) {
                               //操作失败的原因
                               @strongify(self);
                               NSString *information = [response objectForKey:@"information"];
                               //状态码
                               NSString *status = [response objectForKey:@"status"];
                               
                               if ([status integerValue]==0) {
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }else{
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }
                           } failure:^(NSError *error, NSString *message) {
                               
                           }];
    [PushManager popViewControllerWithName:@"RegisterFourController" animated:YES block:^(RegisterFourController* viewController) {
        viewController.signatureStr = self.textField.text;
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    return NO;
}
@end