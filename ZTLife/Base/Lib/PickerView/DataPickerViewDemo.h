//
//  DataPickerViewDemo.h
//  ChooseTimePickerView
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerSelected)(NSString *dateStr,NSString *timeStr);

@interface DataPickerViewDemo : UIView
@property (nonatomic,copy)DatePickerSelected pikerSelected;
+(DataPickerViewDemo* )sharedPikerView;
- (void)show;
- (void)dismiss;
@end
