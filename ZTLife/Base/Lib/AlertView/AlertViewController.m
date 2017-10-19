//
//  AlertViewController.m
//  SmallGuards_3.0
//
//  Created by tf on 16/7/20.
//  Copyright © 2016年 GanYue. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle controller:(UIViewController *)controller
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(preferredStyle)];
    
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:cancelAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

@end
