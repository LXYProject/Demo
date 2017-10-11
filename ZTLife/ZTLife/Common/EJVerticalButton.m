//
//  EJVerticalButton.m
//  EJZG
//
//  Created by Haisheng Liang on 16/9/7.
//  Copyright © 2016年 zhangyy. All rights reserved.
//

#import "EJVerticalButton.h"
#import "UIImage+Size.h"

@implementation EJVerticalButton
{
    BOOL _isFirst;
}

-(void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(_isHorizontal){
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.bounds.size.width, 0, self.imageView.bounds.size.width)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width, 0, -self.titleLabel.bounds.size.width-5)];
    }
    else{
        CGPoint center =    self.imageView.center;
        center.x = self.width/2;
        self.imageView.center = center;
        
        if(!_isFirst){

//            [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.bounds.size.height,-self.imageView.bounds.size.width , 0, 0)];
//            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, self.titleLabel.bounds.size.height+5,-self.titleLabel.bounds.size.width)];
            
            CGSize imageSize = self.imageView.bounds.size;
            CGSize titleSize = self.titleLabel.bounds.size;
//            CGFloat space = 3.0f;
            
            UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height, 0);
            UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, 0, titleSize.height, -titleSize.width);
            
            [self setImageEdgeInsets:imageEdgeInsets];
            [self setTitleEdgeInsets:labelEdgeInsets];
        }
        _isFirst = YES;
    }
    
}

- (void)setIsHorizontal:(BOOL)isHorizontal{
    _isHorizontal = isHorizontal;
}


- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    if(self.height>0){
        if (image.size.height > self.height) {
            image = [image scaleToSize:self.bounds.size];
        }
    }
    [super setImage:image forState:state];
    _isFirst = NO;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    _isFirst = NO;
    [self setNeedsLayout];
}

@end
