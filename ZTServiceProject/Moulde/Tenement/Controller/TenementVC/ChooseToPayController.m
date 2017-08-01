//
//  ChooseToPayController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChooseToPayController.h"

@interface ChooseToPayController ()
@property (weak, nonatomic) IBOutlet UITextField *PayAmountField;
@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *payTreasureBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatPayBtn;

@end

@implementation ChooseToPayController
{
    UIButton *_selectedBtn;
    NSInteger _selectIndexNum;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"支付" titleColor:[UIColor whiteColor]];
    self.paymentBtn.layer.masksToBounds = YES;
    self.paymentBtn.layer.cornerRadius = self.paymentBtn.bounds.size.width * 0.01;
    self.paymentBtn.layer.borderColor = [UIColor clearColor].CGColor;

    [self methodOfPayment:self.payTreasureBtn];

}

- (IBAction)methodOfPayment:(UIButton *)sender {
    _selectedBtn.selected  = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    _selectIndexNum = sender == self.payTreasureBtn?0:1;

}

- (IBAction)ConfirmPaymentBtn {
    
}

@end
