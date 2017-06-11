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

- (UIButton *)addLeftBtnWithImage:(UIImage*)image action:(SEL)action;
- (UIButton *)addRightBtnWithImage:(UIImage*)image action:(SEL)action;

//导航栏返回按钮回调
- (void)navBackAction;
@end
