//
//  AppDelegate.m
//  ZTLife
//
//  Created by ZT on 2017/10/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AppDelegate.h"
#import "MainVC.h"
#import "LeftVc.h"
#import "CyhSliderVC.h"
#import "MainVC2.h"
#import "tabBarVc.h"
#import "LoginViewController.h"

@interface AppDelegate ()<pushdelegate>


@end

@implementation AppDelegate
{
    NSString *_token;
    BOOL login;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 高德key
    [AMapServices sharedServices].apiKey = @"c2120ff832ed742a16ce51083710061e";

    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    
    _token = [UserInfoManager sharedUserInfoManager].userInfoModel.token;
    _token = GetValueForKey(@"token");
    
    if (_token) {
        MainVC * mvc = [[MainVC alloc] initWithNibName:@"MainVC" bundle:nil];
        LeftVc * lvc = [[LeftVc alloc] init];
        //添加主页和左边控制器
        CyhSliderVC *cy = [[CyhSliderVC alloc]init];
        cy.Mainvc = mvc;
        cy.Leftvc = lvc;
        self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:cy];

    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        self.window.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    }
    
//    MainVC * mvc = [[MainVC alloc] init];
//    LeftVc * lvc = [[LeftVc alloc] init];
//    //添加主页和左边控制器
//    [[CyhSliderVC initCyhslider] addMainVC:mvc addLeftVC:lvc];
//    self.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[CyhSliderVC initCyhslider]];
    
    
    return YES;
}

- (void)pushsubVC:(id)trag{
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
