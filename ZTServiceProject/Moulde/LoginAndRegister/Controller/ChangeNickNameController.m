//
//  ChangeNickNameController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChangeNickNameController.h"
#import "RegisterFourController.h"
#import "LoginHttpManager.h"

@interface ChangeNickNameController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ChangeNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self titleViewWithTitle:@"更改昵称" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"保存" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeyDone;

}

- (void)rightBarClick
{
    NSLog(@"保存");
    NSLog(@"textField==%@", self.textField.text);
    
    NSDictionary  *dict = @{@"nickName":self.textField.text,
                            //                            @"gender":@(_age),
                            //                            @"selfIntroduction":self.signatureStr,
                            //                            @"birth":self.birthdayStr,
                            //                            @"hometown":@"成都市",
                            //                            @"hometownCode":@"510100",
                            };
    
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
        viewController.nickNameStr = self.textField.text;
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    return NO;
}

@end
