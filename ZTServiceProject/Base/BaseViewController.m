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
    self.rt_disableInteractivePop = NO;
    [self initNavigation];
}


//初始化所有导航栏基本设置
- (void)initNavigation {
    //设置导航栏字体颜色和字体大小
    self.navigationBarTitleColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[Tools createImageWithColor:UIColorFromRGB(0xe64e51)] forBarMetrics:UIBarMetricsDefault];
    if(self.rt_navigationController.rt_viewControllers.count>1){
        [self leftBarButtomItemWithNormalName:@"nav_back" highName:@"nav_back" selector:@selector(navBackAction) target:self];
    }
}

-(void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    if (navigationBarTitleColor) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:navigationBarTitleColor}];
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


- (void)leftBarButtomItemWithNormalName:(NSString*)normalName
                               highName:(NSString *)highName
                               selector:(SEL)selector
                                 target:(id)target {
    UIButton *leftBtn = [self creatNavBtnWithTitle:nil
                                            norImg:normalName
                                          hightImg:highName
                                        titleColor:nil
                                            target:target
                                            action:selector
                                            isLeft:YES];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)rightBarButtomItemWithNormalName:(NSString*)normalName
                                highName:(NSString *)highName
                                selector:(SEL)selector
                                  target:(id)target {
    UIButton *rightBtn = [self creatNavBtnWithTitle:nil
                                             norImg:normalName
                                           hightImg:highName
                                         titleColor:nil
                                             target:target
                                             action:selector
                                             isLeft:NO];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)rightItemWithNormalName:(NSString*)normalName
                          title:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       selector:(SEL)selector
                         target:(id)target {
    
    UIButton *rightBtn = [self creatNavBtnWithTitle:title
                                             norImg:normalName
                                           hightImg:normalName
                                         titleColor:titleColor
                                             target:target
                                             action:selector
                                             isLeft:NO];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

- (void)leftItemWithNormalName:(NSString*)normalName
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                      selector:(SEL)selector
                        target:(id)target
{
    UIButton *lefttBtn = [self creatNavBtnWithTitle:title
                                             norImg:normalName
                                           hightImg:normalName
                                         titleColor:titleColor
                                             target:target
                                             action:selector
                                             isLeft:NO];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:lefttBtn];

}

- (void)leftBarButtomItemWithTitle:(NSString*)title
                          selector:(SEL)selector
                            target:(id)target {
    UIButton *leftBtn = [self creatNavBtnWithTitle:title
                                            norImg:nil
                                          hightImg:nil
                                        titleColor:nil
                                            target:target
                                            action:selector
                                            isLeft:YES];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)rightBarButtomItemWithTitle:(NSString*)title
                           selector:(SEL)selector
                             target:(id)target {
    UIButton *rightBtn = [self creatNavBtnWithTitle:title
                                             norImg:nil
                                           hightImg:nil
                                         titleColor:nil
                                             target:target
                                             action:selector
                                             isLeft:NO];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}

//导航栏的按钮
- (UIButton *)creatNavBtnWithTitle:(NSString *)title
                            norImg:(NSString *)norImgStr
                          hightImg:(NSString *)hightImgStr
                        titleColor:(UIColor *)titleColor
                            target:(id)target
                            action:(SEL)action
                            isLeft:(BOOL)isLeft{
    UIImage *norImg = [UIImage imageNamed:norImgStr];
    UIImage *hightImg = [UIImage imageNamed:hightImgStr];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    CGSize size = [title boundingRectWithSize:CGSizeMake(ScreenWidth, 44)
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:@{ NSFontAttributeName:btn.titleLabel.font }
                                      context:nil].size;
    if (title&&titleColor) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (norImg) {
        [btn setImage:norImg forState:UIControlStateNormal];
    }
    if (hightImg) {
        [btn setImage:hightImg forState:UIControlStateHighlighted];
    }
    if (isLeft) {
        if(norImg||hightImg) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    else {
        if(norImg||hightImg) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        }
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    }
    
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0, 0, size.width+(norImg?norImg.size.width:0), 40);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)titleViewWithTitle:(NSString *)title
                titleColor:(UIColor *)titleColor
{
    UILabel *label = [self creatNavWithTitle:title
                                  titleColor:titleColor];
    self.navigationItem.titleView = label;
}

- (UILabel *)creatNavWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 50, 40);
    label.text = title;
    label.textColor = titleColor;
    
    return label;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


@end
