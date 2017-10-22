//
//  CALayer+UIColor.m
//  CXBaseProject
//
//  Created by apple on 17/3/24.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
