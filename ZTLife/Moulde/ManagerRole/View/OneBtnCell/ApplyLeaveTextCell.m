//
//  DoorServiceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ApplyLeaveTextCell.h"
#import "PlaceTextView.h"

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface ApplyLeaveTextCell ()<UITextViewDelegate>
@property (copy, nonatomic) NSString *myInPutText;


@end
@implementation ApplyLeaveTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textView.font = [UIFont systemFontOfSize:15.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.scrollEnabled = NO;
    _textView.layer.cornerRadius = 4.0f;
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @" 请输入请假的理由";
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        _textView.placeHolderLabel.font = [UIFont systemFontOfSize:13];
    }else{
        _textView.placeHolderLabel.font = [UIFont systemFontOfSize:14];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    if (self.textViewBlock) {
        self.textViewBlock(self.textView.text);
    }
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

@end
