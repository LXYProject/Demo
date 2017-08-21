//
//  SolicitOneRowCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitOneRowCell.h"

@interface SolicitOneRowCell ()<UITextFieldDelegate>

@end
@implementation SolicitOneRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField1.keyboardType = UIKeyboardTypeNumberPad;
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.textFieldBlock) {
        self.textFieldBlock(textField,textField==_textField1?1:2);
    }

}

@end
