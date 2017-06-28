//
//  SecondDetailsController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"
#import "SecondUserCell.h"  

@interface SecondDetailsController : BaseViewController

@property (nonatomic,copy)NSString *titleStr;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *name;
@property (nonatomic, copy)UIImageView *headIcon;




@property (nonatomic,strong)NSArray *model;
@property (nonatomic,strong)NSArray *imageURLArray;


@end
