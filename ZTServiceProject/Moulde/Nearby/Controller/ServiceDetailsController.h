//
//  ServiceDetailsController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@class ServiceModel;
@interface ServiceDetailsController : BaseViewController

@property (nonatomic, assign) NSInteger currentVC;

@property (nonatomic,strong)ServiceModel *model;

@end
