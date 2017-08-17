//
//  HelpDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HelpDetailsController.h"

@interface HelpDetailsController ()

@end

@implementation HelpDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"求助详情" titleColor:[UIColor whiteColor]];
}

- (IBAction)dialogueBtnClick {
    NSLog(@"对话");
}

- (IBAction)toHelpBtnClick {
    NSLog(@"去帮忙");
}

@end
