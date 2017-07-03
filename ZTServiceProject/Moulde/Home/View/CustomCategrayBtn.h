//
//  CustomCategrayBtn.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonBackGroudType) {
    Type_Red,
    Type_Pink,
    Type_Yellow
};

@interface CustomCategrayBtn : UIButton
@property (nonatomic,assign)ButtonBackGroudType type;
@end
