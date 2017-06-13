//
//  BaseViewController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
//导航栏的背景颜色
@property (nonatomic,strong)UIColor *navigationBarBackGroudColor;

@property (nonatomic,strong)UIColor *navigationBarTitleColor;

//导航栏返回按钮回调
- (void)navBackAction;


//添加导航条左边按钮
- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target;

//添加导航条右边按钮
- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target;

// 添加导航栏左边标题
- (void)leftBarButtomItemWithTitle:(NSString*)title
                          selector:(SEL)selector
                            target:(id)target;

// 添加导航栏右边标题
- (void)rightBarButtomItemWithTitle:(NSString*)title
                           selector:(SEL)selector
                             target:(id)target;

- (void)rightItemWithNormalName:(NSString*)normalName
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       selector:(SEL)selector
                         target:(id)target;

- (void)leftItemWithNormalName:(NSString*)normalName
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       selector:(SEL)selector
                         target:(id)target;

@end
