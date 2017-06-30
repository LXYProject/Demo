//
//  TwoLabelBtn.m
//  DingDing
//
//  Created by xinzhen on 16/9/12.
//  Copyright © 2016年 GanYue. All rights reserved.
//

#import "TwoLabelBtn.h"

@implementation TwoLabelBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width, 13)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12];
        [self addSubview:_label];
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label.frame) + 10, self.frame.size.width , 12)];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:11];
        [self addSubview:_label1];
    }
    return self;
}
@end
