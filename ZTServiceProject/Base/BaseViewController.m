//
//  BaseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
}


//初始化所有导航栏基本设置
- (void)initNavigation {
    //设置导航栏字体颜色和字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[Tools createImageWithColor:UIColorFromRGB(0xe64e51)] forBarMetrics:UIBarMetricsDefault];
    if(self.rt_navigationController.rt_viewControllers.count>1){
        [self addLeftBtnWithImage:[UIImage imageNamed:@"nav_back_btn"] action:@selector(navBackAction)];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
    
}

- (void)navBackAction {
    [PushManager popCurrentViewControllerAnimated:YES];
}

- (void)setNavigationBarBackGroudColor:(UIColor *)navigationBarBackGroudColor {
    [self.navigationController.navigationBar setBackgroundImage:[Tools createImageWithColor:navigationBarBackGroudColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)addLeftBtnWithTitle:(NSString*)title  color:(UIColor*)color action:(SEL)action{
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    if (color) {
        [settingBarButton setTintColor:color];
    }
    self.navigationItem.leftBarButtonItem = settingBarButton;
}

- (UIButton *)addLeftBtnWithImage:(UIImage*)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 19, 20);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget: self action:action forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    return button;
}

- (void)addRightBtnWithTitle:(NSString*)title  color:(UIColor*)color action:(SEL)action{
    UIBarButtonItem *settingBarButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    if (color) {
        [settingBarButton setTintColor:color];
    }
    [settingBarButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[settingBarButton];
    
}

- (UIButton *)addRightBtnWithImage:(UIImage*)image action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 19, 20);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    return button;
}

- (UIButton *)addRightBtnWithImage:(UIImage*)image selectedImage:(UIImage *)selectedImage action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(0, 0, 19, 20);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:self action:action forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    return button;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
