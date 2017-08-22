//
//  PublishServiceController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@interface PublishServiceController : BaseViewController

@property (nonatomic, copy) NSString *unitStr;
@property (nonatomic, copy) NSString *serviceTypeStr;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *serviceScopeStr;
@property (nonatomic, copy) NSString *locationInfo;

@property (nonatomic, assign) int cateId;

@end
