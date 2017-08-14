//
//  SolicitingHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitingHeadCell.h"

@interface SolicitingHeadCell ()<UITextFieldDelegate>
@end
@implementation SolicitingHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.content.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"text==%@", textField.text);
    
    if (self.textFieldBlock) {
        self.textFieldBlock(textField.text);
    }
}

@end
