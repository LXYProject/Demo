//
//  ChangeNickNameController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChangeNickNameController.h"

@interface ChangeNickNameController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ChangeNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self titleViewWithTitle:@"更改昵称" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"保存" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];


}

- (void)rightBarClick
{
    NSLog(@"保存");
}

@end
