//
//  DataPickerViewDemo.h
//  ChooseTimePickerView
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DatePickerSelected)(NSString *dateStr);

@interface DataPickerViewOneDemo : UIView
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)DatePickerSelected pikerSelected;
@property (nonatomic,strong)NSArray *dataSource;

+(DataPickerViewOneDemo* )sharedPikerView;
- (void)show;
- (void)dismiss;

@end
