//
//  FrameAutoBtnWithTitle.m
//  textTable
//
//  Created by zhngyy on 16/4/11.
//  Copyright © 2016年 zhangyy. All rights reserved.
//

#import "FrameAutoBtnWithTitle.h"




@implementation FrameAutoBtnWithTitle
{
    btnClickBlock _clickBlock;
    UIButton *_button;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectIndex = -1;
    }
    return self;
}


- (CGFloat)autoBtnWithTitleArray:(NSArray *)titleArray
                             top:(CGFloat)top
                            left:(CGFloat)left
                          buttom:(CGFloat)buttom
                          spaceH:(CGFloat)spaceH
                          spaceV:(CGFloat)spaceV
                       btnHeight:(CGFloat)btnHeight
                           width:(CGFloat)width
{
    CGFloat ScreenW = width;
    CGFloat y = top;
    UIView *lastView = nil;
    CGFloat topMargin = top;
    CGFloat spaceMarginH   = spaceH;
    CGFloat spaceMarginV   = spaceV;
    CGFloat leftMargin = left;
    int currentRow = 0;
    int beginRow = 1;
    CGFloat btnH = btnHeight;
    for(int i = 0;i<titleArray.count;i++)
    {
        CGFloat x = 0.0f;
        if(lastView)
        {
            x = lastView.frame.origin.x+lastView.frame.size.width+spaceMarginH;
        }
        else
        {
            x = leftMargin;
        }
        beginRow = currentRow;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[self drawImageWithImageName:@"btn_select_gary"]forState:UIControlStateDisabled];
        UIFont *font = [UIFont systemFontOfSize:12];
        CGFloat btnW = 0.0f;
        CGSize textSize = [self calculateTheLabelSizeWithText:titleArray[i] font:font];
            btnW  = textSize.width+15;
        
        if(ScreenW-x - 15 < btnW)
        {
            currentRow = currentRow + 1;
        }
        if(currentRow!=beginRow)
        {
            x = leftMargin;
        }
        if(currentRow!=0)
        {
            y  =topMargin + currentRow *(btnH+spaceMarginV);
        }
        btn.frame = CGRectMake(x, y, btnW, btnH);
        lastView = btn;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        if(self.normalImageName)
        {
            [btn setBackgroundImage:[self drawImageWithImageName:self.normalImageName] forState:UIControlStateNormal];
        }
        if(self.selectImageName)
        {
            [btn setBackgroundImage:[self drawImageWithImageName:self.selectImageName] forState:UIControlStateSelected];
        }
        if(self.selectColor)
        {
            [btn setTitleColor:self.selectColor forState:UIControlStateSelected];
        }
        if(self.normalColor)
        {
            [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        btn.layer.borderWidth = 0.7;
        btn.layer.cornerRadius = btnHeight/2;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.tag = i+1000;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        NSLog(@"%d",currentRow);
    }
    return  y + btnH+buttom;
}

- (UIImage *)drawImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    return image;
}

#pragma mark - btn点击方法
- (void)btnClick:(UIButton *)sender
{
//    if(sender.selected == YES)
//    {
//        return;
//    }
//    _button.selected = NO;
//    sender.selected = YES;
//    _button = sender;
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.backgroundColor = [UIColor redColor];
    }
    else {
        sender.backgroundColor= [UIColor whiteColor];
    }
    if(_clickBlock)
    {
        _clickBlock(sender,(int)sender.tag-1000);
    }
}

#pragma mark - btn的block回调方法
- (void)btnClickWithBlock:(btnClickBlock)block
{
    if(block)
    {
        _clickBlock = block;
    }
}

#pragma mark - 计算文本的长度
-(CGSize)calculateTheLabelSizeWithText:(NSString *)text
                                  font:(UIFont *)font
{
    CGSize size = CGSizeMake(20000, 20000.0f);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize contentLabelSize = [text boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:tdic
                                                 context:nil].size;
    //向上取整
    contentLabelSize = CGSizeMake(ceilf(contentLabelSize.width), ceilf(contentLabelSize.height));
    return contentLabelSize;
}

@end
