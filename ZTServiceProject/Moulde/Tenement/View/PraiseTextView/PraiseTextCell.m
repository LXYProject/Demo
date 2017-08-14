//
//  DoorServiceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PraiseTextCell.h"
#import "PlaceTextView.h"

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface PraiseTextCell ()<UITextViewDelegate>

@property (nonatomic, strong) PlaceTextView * textView;

@property (copy, nonatomic) NSString *myInPutText;


@end
@implementation PraiseTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[PlaceTextView class]]) {
            [obj removeFromSuperview];
            
        }
    }];
    
    [self.contentView addSubview:self.textView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
//
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textViewBlock) {
        self.textViewBlock(self.textView.text);
    }
}


//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if (self.textViewBlock) {
//        self.textViewBlock(self.textView.text);
//    }
//}

-(PlaceTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceTextView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"请描述您要表扬的现象";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            _textView.placeHolderLabel.font = [UIFont systemFontOfSize:13];
        }else{
            _textView.placeHolderLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    
    return _textView;
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



@end
