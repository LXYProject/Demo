//
//  AlertViewController.h
//  SmallGuards_3.0
//
//  Created by tf on 16/7/20.
//  Copyright © 2016年 GanYue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle controller:(UIViewController *)controller;

@end
