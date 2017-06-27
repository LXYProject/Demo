//
//  BannerJumpController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/27.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BannerJumpController.h"

@interface BannerJumpController ()

@end

@implementation BannerJumpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"动态" titleColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
