//
//  DataPickerViewDemo.h
//  ChooseTimePickerView
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerSelectedThree)(NSString *dateStr,NSString *timeStr,NSString *threeStr);
@interface DataPickerViewTwoDemo : UIView
@property (nonatomic,copy)DatePickerSelectedThree pikerSelected;
+(DataPickerViewTwoDemo* )sharedPikerView;
- (void)show;
- (void)dismiss;
@end
