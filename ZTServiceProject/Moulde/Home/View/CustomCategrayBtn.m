//
//  CustomCategrayBtn.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CustomCategrayBtn.h"

@implementation CustomCategrayBtn

- (void)setType:(ButtonBackGroudType)type {
    switch (type) {
        case Type_Red: {
            self.backgroundColor = [UIColor redColor];
            break;
        }
        case Type_Pink: {
            self.backgroundColor = [UIColor redColor];
            break;
        }
        case Type_Yellow: {
            self.backgroundColor = [UIColor redColor];
            break;
        }
        default:
            break;
    }
}

@end
