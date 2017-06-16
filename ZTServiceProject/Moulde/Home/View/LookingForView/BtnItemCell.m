//
//  BtnItemCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BtnItemCell.h"
#import "FrameAutoBtnWithTitle.h"

@interface BtnItemCell ()

@end
@implementation BtnItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[FrameAutoBtnWithTitle class]]) {
            [obj removeFromSuperview];
        }
    }];
    FrameAutoBtnWithTitle *title = [[FrameAutoBtnWithTitle alloc]init];
    title.selectColor = [UIColor whiteColor];
    title.normalColor = [UIColor redColor];
    self.cellHeight = [title autoBtnWithTitleArray:@[@"同城",@"同意承担运费",@"七天退货",@"未拆封",@"奥外观无损",@"有发票",@"有外包装"] top:15 left:15 buttom:15 spaceH:10 spaceV:10 btnHeight:20 width:[UIScreen mainScreen].bounds.size.width];
    title.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight);
    [title btnClickWithBlock:^(UIButton *btn, int index) {
        
    }];
    [self.contentView addSubview:title];
    
}

#pragma mark - 颜色返回图片
- (UIImage*) createImageWithColor: (UIColor*) color
{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return theImage;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
    }
    else {
        sender.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
