//
//  BaseTabbarController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseTabbarController.h"
//#import "HomeViewController.h"
//#import "NearByHomeViewController.h"
//#import "MineViewController.h"
//#import "MessageCenterViewController.h"
//#import "TenementViewController.h"
#import "BaseNavigationController.h"
@interface BaseTabbarController ()

@end

@implementation BaseTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initControllers];
    // Do any additional setup after loading the view.
}

//#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
//- (void)initControllers {
//    //首页
//    HomeViewController *homeVc = [[HomeViewController alloc]init];
//    [self addViewControllers:homeVc
//                       title:@"首页"
//                  tabbarItem:@"首页"
//                       image:@"tabbar_sy_normal"
//                 selectImage:@"tabbar_sy_selected"];
//    //物业
//    TenementViewController *tenementVc = [[TenementViewController alloc] init];
//    [self addViewControllers:tenementVc
//                       title:@""
//                  tabbarItem:@"物业"
//                       image:@"tabbar_wy_normal"
//                    selectImage:@"tabbar_wy__selected"];
//    //周边
//    NearByHomeViewController *nearByVC = [[NearByHomeViewController alloc] init];
//    [self addViewControllers:nearByVC
//                       title:@""
//                  tabbarItem:@"周边"
//                       image:@"tabbar_zb_normal"
//                 selectImage:@"tabbar_zb_selected"];
//    //论坛
//    MessageCenterViewController *messageVc = [[MessageCenterViewController alloc]init];
//    [self addViewControllers:messageVc
//                       title:@"邻里圈"
//                  tabbarItem:@"论坛"
//                       image:@"tabbar_llq_normal"
//                 selectImage:@"tabbar_llq_selected"];
//    //个人
//    MineViewController *acountVc = [[MineViewController alloc]init];
//    [self addViewControllers:acountVc
//                       title:@"个人"
//                  tabbarItem:@"个人"
//                       image:@"tabbar_wd_normal"
//                 selectImage:@"tabbar_wd_selected"];
//}

#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController
                     title:(NSString *)title
                tabbarItem:(NSString *)tabbarItem
                     image:(NSString *)imageName
               selectImage:(NSString *)selectImageName {
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    
    childController.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    childController.navigationItem.title = title;
    
    //防止图片渲染显示原图片
    UIImage *nomImage = [UIImage imageNamed:imageName];
    nomImage = [nomImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.image = nomImage;
    
    //防止图片渲染显示原图片
    UIImage *selectImg = [UIImage imageNamed:selectImageName];
    selectImg = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selectImg;
    
    //正常的文字的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor darkGrayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    //选中后的文字的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor redColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    childController.tabBarItem.title = tabbarItem;
    NSDictionary *barDic = @{
                             NSForegroundColorAttributeName:[UIColor whiteColor],
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                             };
    nav.navigationBar.titleTextAttributes = barDic;
    
    //  添加导航栏的背景颜色
    [nav.navigationBar setBackgroundImage:[Tools createImageWithColor:UIColorFromRGB(0x9E6973)] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
    nav = nil;
}


@end
