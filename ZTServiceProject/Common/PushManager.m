//
//  PushManager.m
//  EnNew
//
//  Created by 莫名 on 16/11/8.
//  Copyright © 2016年 hy. All rights reserved.
//

#import "PushManager.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "BaseTabbarController.h"

static PushManager *_pushManager = nil;

@interface PushManager()
@property (nonatomic, strong) NSArray *unLoginVCList;
@end

@implementation PushManager

+ (PushManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_pushManager)
        {
            _pushManager = [[PushManager alloc] init];
            [_pushManager initUnLoginVCList];
        }
    });
    return _pushManager;
}


+ (BaseNavigationController*)currentNavigationController{
    // 获取导航控制器
    BaseNavigationController *pushClassStance;
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[BaseNavigationController class]]) {
        pushClassStance =  (BaseNavigationController*)viewController.rt_navigationController;
    }else if([viewController isKindOfClass:[BaseTabbarController class]]){
        UITabBarController *tabVC = (BaseTabbarController*)viewController;
        pushClassStance = (BaseNavigationController *)tabVC.viewControllers[tabVC.selectedIndex].rt_navigationController;
    }
    return pushClassStance;
}

+ (UIViewController*)currentViewController{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[BaseNavigationController class]]) {
        BaseNavigationController *navController = (BaseNavigationController*)viewController;
        viewController = navController.visibleViewController;
    }else if([viewController isKindOfClass:[BaseTabbarController class]]) {
         BaseTabbarController*tabBarController = (BaseTabbarController*)viewController;
        if ([tabBarController.viewControllers[tabBarController.selectedIndex] isKindOfClass:[BaseNavigationController class]]) {
            viewController = ((BaseNavigationController*)tabBarController.viewControllers[tabBarController.selectedIndex]).rt_topViewController;
        }else{
            viewController = tabBarController.viewControllers[tabBarController.selectedIndex].rt_navigationController.rt_visibleViewController;
        }
    }
    if (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
        if ([viewController isKindOfClass:[BaseNavigationController class]]) {
            BaseNavigationController *navController = (BaseNavigationController*)viewController;
            viewController = navController.rt_visibleViewController;
        }
    }
    return viewController;
}

#pragma mark - 根据VC的类进行跳转
+ (void)pushViewControllerWithName:(NSString *)vCClass
                          animated:(BOOL)isAnimated
                             block:(PushBlock)block
{
    UIViewController *pushVC = [[NSClassFromString(vCClass) alloc] init];
    pushVC.hidesBottomBarWhenPushed=YES;
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (block) {
        block(pushVC);
    }
//    BOOL isLogin = [EJUserCenterManager sharedManager].isLogin;
    
    BOOL isLogin = YES;
    BOOL needLogin = ![[PushManager shareManager].unLoginVCList containsObject:vCClass];
    
    if (needLogin && !isLogin)
    {
        [[PushManager shareManager] presentLoginControllerWithSuccessBlock:^{
            [[PushManager currentNavigationController] pushViewController:pushVC animated:isAnimated];
        }];
    }
    else
    {
        [[PushManager currentNavigationController] pushViewController:pushVC animated:isAnimated];
    }
}



#pragma mark - 根据VC的类进行跳转
+ (void)popViewControllerWithName:(NSString *)vCClass
                         animated:(BOOL)isAnimated
                            block:(PushBlock)block
{
    UIViewController *pushVC = [[NSClassFromString(vCClass) alloc] init];
    NSArray *vcArray = [PushManager currentNavigationController].viewControllers;
    for(UIViewController *currentVc in vcArray)
    {
        if([currentVc isKindOfClass:NSClassFromString(vCClass)])
        {
            if (block) {
                block(pushVC);
            }
            [[PushManager currentNavigationController] popToViewController:currentVc animated:isAnimated];
            return;
        }
    }
    NSAssert(true == true, @"当前的VC不存在Push的数组里面");
}

+(void)popToRootViewControllerAnimated:(BOOL)isAnimated {
    [[PushManager currentNavigationController]popToRootViewControllerAnimated:isAnimated];
}

+(void)popCurrentViewControllerAnimated:(BOOL)isAnimated {
    [[PushManager currentNavigationController]popViewControllerAnimated:isAnimated];
}


+ (BOOL)viewControllerIsNeedLogin:(NSString*)controllerName{
    BOOL needLogin = ![[PushManager shareManager].unLoginVCList containsObject:controllerName];
    return needLogin;
}

#pragma mark - 初始化需要校验的vc
/**
 *  初始化需要检测登录权限的vc列表
 */
- (void)initUnLoginVCList{
    NSMutableArray *listArray = [NSMutableArray array];
    //读取适配数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"unLoginVCList" ofType:@"plist"];
    NSMutableArray *mappingArray = [NSMutableArray arrayWithContentsOfFile:path];
    for (NSString *vcName in mappingArray) {
        
        [listArray addObject:vcName];
    }
    self.unLoginVCList = [listArray copy];
}

#pragma mark - 跳转到登陆页面登陆完成后回调到成功回调里面
- (void)presentLoginControllerWithSuccessBlock:(LoginSuccess)success
{
    UIViewController *controller = [PushManager currentViewController];
    NSLog(@"%@",controller);
    if ([controller isKindOfClass:[LoginViewController class]]) {
        return;
    }
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.loginSuccess = success;
    BaseNavigationController *loginNavController = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
    [controller presentViewController:loginNavController animated:YES completion:nil];
}

#pragma mark - 跳到系统设置页面
- (void)pushSystemSettingViewController {
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=General"] options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }
}
@end
