//
//  BabyDescriptionCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BabyDescriptionCell.h"

@interface BabyDescriptionCell ()


@property (copy, nonatomic) NSString *myInPutText;

@end
@implementation BabyDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
 
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"输入为:%@", textView.text);
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
