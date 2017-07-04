//
//  LoginViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterOneController.h"
#import "LoginHttpManager.h"

@interface RegisterOneController ()<UITextFieldDelegate, MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterOneController
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
    NSInteger _inter;
    NSString *_deviceUUID;
    NSString *_deviceModel;
    UIButton *_button;
    BOOL disableloginBtn;
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleViewWithTitle:@"注册" titleColor:[UIColor whiteColor]];
    
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.width * 0.01;
    self.sendBtn.layer.borderColor = [UIColor clearColor].CGColor;

    
    // 获取设备唯一标识符
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"deviceUUID==%@", deviceUUID);
    NSString *deviceModel = [[UIDevice currentDevice] model];
    NSLog(@"deviceModel==%@", deviceModel);

    [[NSUserDefaults standardUserDefaults] setObject:deviceUUID forKey:@"deviceUUID"];
    _deviceUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    NSLog(@"deviceID==%@", _deviceUUID);
    [[NSUserDefaults standardUserDefaults] setObject:deviceModel forKey:@"deviceModel"];
    _deviceModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceModel"];
    NSLog(@"deviceM==%@", _deviceModel);

    
    [self.phoneNumberField addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

}

// 注册发送验证码
- (void)sendCode{
   
//    NSLog(@"phoneNumberField==%@", self.phoneNumberField.text);
//    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"phoneNumber"];

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //_hud.mode = MBProgressHUDModeAnnularDeterminate;
    _hud.label.text = @"正在加载";
    
    [LoginHttpManager requestLoginRegisterCode:RegisterCode phoneNum:GetValueForKey(@"phoneNumber") machineId:_deviceUUID machineName:_deviceModel success:^(id response) {
        NSLog(@"response==%@", response);

        [_hud hideAnimated:YES];

        NSString *phoneNumStatus = [response objectForKey:@"phoneNumStatus"];
        [[NSUserDefaults standardUserDefaults] setObject:phoneNumStatus forKey:@"phoneNumStatus"];
    } failure:^(NSError *error, NSString *message) {
        [_hud hideAnimated:YES];

    }];

}


- (IBAction)sendBtnClick {
    
    
//    if (_button.selected) {
//        
//        if ([RegularTool isValidateMobile:GetValueForKey(@"phoneNumber")]) {
//            
//            if (disableloginBtn) {
//                
//            }
//            self.sendBtn.userInteractionEnabled = YES;
//            [self.sendBtn setBackgroundColor:[UIColor redColor]];
    
//            [self sendCode];
//            
//            if ([GetValueForKey(@"phoneNumStatus") integerValue] ==0) {
//                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
//
//            }else{
//                [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号已注册" preferredStyle:UIAlertControllerStyleAlert controller:self];
//            }
//        }else{
//            [AlertViewController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert controller:self];
//        }
//
//    }else{
//        [AlertViewController alertControllerWithTitle:@"提示" message:@"请先阅读并同意用户协议" preferredStyle:UIAlertControllerStyleAlert controller:self];
//    }

    [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];

}

- (void)delayMethod
{
    [PushManager pushViewControllerWithName:@"RegisterTwoController" animated:YES block:nil];

}
- (IBAction)btnselect:(UIButton *)sender {
    sender.selected = !sender.selected;
    _button = sender;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.phoneNumberField == textField) {
        NSString *strText = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"strText==%@", strText);
        [[NSUserDefaults standardUserDefaults]setObject:strText forKey:@"phoneNumber"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSLog(@"hssjsjjs==%@", GetValueForKey(@"phoneNumber")) ;
        //self.rightBtn.userInteractionEnabled=YES;
    }
    
}

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    /**
     *  判断正确的光标位置
     */
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    
    if([phoneNumberWithoutSpaces length]>11) {
        /**
         *  避免超过11位的输入
         */
        [textField setText:_previousTextFieldContent];
        textField.selectedTextRange = _previousSelection;
        
        return;
    }else if ([phoneNumberWithoutSpaces length]==11){
        self.sendBtn.backgroundColor = UIColorFromRGB(0xe64e51);
        self.sendBtn.userInteractionEnabled = YES;
    }
    else{
        self.sendBtn.backgroundColor = UIColorFromRGB(0xb2b2b2);
        self.sendBtn.userInteractionEnabled = NO;
    }
    
    
    NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
    
    textField.text = phoneNumberWithSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
    
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            if(i==3 || i==7) {
                [stringWithAddedSpaces appendString:@" "];
                
                if(i<cursorPositionInSpacelessString) {
                    (*cursorPosition)++;
                }
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    _previousSelection = textField.selectedTextRange;
    _previousTextFieldContent = textField.text;
    
    if(range.location==0) {
        if(string.integerValue >1)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
