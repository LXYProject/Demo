//
//  PraiseTextCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PraiseTextCell.h"
#import "HClTextView.h"

@interface PraiseTextCell ()
@property (strong, nonatomic) HClTextView *textView;
@property (copy, nonatomic) NSString *myInPutText;

@end
@implementation PraiseTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[HClTextView class]]) {
            [obj removeFromSuperview];
            
        }
    }];
    self.textView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.textView setLeftTitleText:@"描述:"];
    [self.textView setPlaceholder:@"描述一下（少于300字）" contentText:_myInPutText maxTextCount:300];
    [self.contentView addSubview:self.textView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (HClTextView *)textView {
    if (!_textView) {
        _textView = [[NSBundle mainBundle] loadNibNamed:@"HClTextView" owner:self options:nil].lastObject;
    }
    return _textView;
}

@end
