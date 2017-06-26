//
//  Tools.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "Tools.h"

@implementation Tools
#pragma mark - 颜色返回图片
+ (UIImage*) createImageWithColor: (UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//#warning 第三步
// 在AppTool.m实现方法，并执行block
- (void)sendBlock:(AppToolBlock)block
{
    NSString *string;
    block(string);
}
@end
