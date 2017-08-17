//
//  ServiceDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceDetailsController.h"

@interface ServiceDetailsController ()

@end

@implementation ServiceDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"服务详情" titleColor:[UIColor whiteColor]];
}

- (IBAction)collectionBtnClick {
    NSLog(@"收藏");
}
- (IBAction)dialogueBtnClick {
    NSLog(@"对话");
}
- (IBAction)appointmentBtnClick {
    NSLog(@"立即预约");
    [PushManager pushViewControllerWithName:@"MakeAppointmentController" animated:YES block:nil];
}


@end
