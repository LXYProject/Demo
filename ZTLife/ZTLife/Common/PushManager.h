//
//  PushManager.h
//  EnNew
//
//  Created by 莫名 on 16/11/8.
//  Copyright © 2016年 hy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PushManager : NSObject

+ (PushManager *)shareManager;

+ (UINavigationController*)currentNavigationController;

+ (UIViewController*)currentViewController;


/**
 pop当前的控制器

 @param isAnimated 是否需要动画
 */
+ (void)popCurrentViewControllerAnimated:(BOOL)isAnimated;


/**
 pop到跟控制器

 @param isAnimated 是否有动画
 */
+ (void)popToRootViewControllerAnimated:(BOOL)isAnimated;

/**
 *  控制器push的调用方法
 *
 *  @param vCClass     VC的类名
 *  @param isAnimated 是否有动画
 *  @param block      回调的block，这个block里面可以把需要的值传过去
 */
+ (void)pushViewControllerWithName:(NSString *)vCClass
                          animated:(BOOL)isAnimated
                             block:(PushBlock)block;

/**
 *  跳回到指定的页面
 *
 *  @param vCClass     VC的类
 *  @param isAnimated 是否有动画
 *  @param block      回调的block，这里可以回传一些数据
 */
+ (void)popViewControllerWithName:(NSString *)vCClass
                         animated:(BOOL)isAnimated
                            block:(PushBlock)block;

/**
 *  判断一个View是否需要登录
 *
 *  @param controllerName VC的类
 *
 *  @return 返回是否需要登录
 */
+ (BOOL)viewControllerIsNeedLogin:(NSString*)controllerName;


/**
 跳转到登录页面

 @param success 登录成功回调
 */
- (void)presentLoginControllerWithSuccessBlock:(LoginSuccess)success;


/**
 跳转到系统设置里面
 */
- (void)pushSystemSettingViewController;

@end
