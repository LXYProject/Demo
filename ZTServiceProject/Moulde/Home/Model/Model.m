

//
//  Model.m
//  cell自动计算高度
//
//  Created by bailing on 16/3/31.
//  Copyright © 2016年 bailing. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Model.h"
CGFloat const YMTopicCellMargin = 10;
CGFloat const YMTopicCellTextY = 70;
@interface Model()

@end
@implementation Model


{
    CGFloat _cellHeight;
}


-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{

    self = [super init];
    if (self ) {
        
        self.title = title;
        self.content = content;
    }
    return self;
}

-(CGFloat)cellHeight{

    // 文字的最大尺寸
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*YMTopicCellMargin, MAXFLOAT);
    // 计算文字的高度
    CGFloat textH = [self.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    // c文字部分的高度
    _cellHeight = YMTopicCellTextY + textH + YMTopicCellMargin;
    
    return _cellHeight;
    
}

@end
