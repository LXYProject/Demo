//
//  VillagePanoramaController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@interface VillagePanoramaController : BaseViewController

@property (nonatomic, copy)NSString* zoneId;

@property (nonatomic,copy)NSString *featureCategory;
@property (nonatomic,copy)NSString *featureId;

@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic, copy)NSString* navTitle;
@property (nonatomic, copy)NSString* zoneName;
@property (nonatomic, assign)NSInteger pushId;

@property (nonatomic, copy)NSString* x;
@property (nonatomic, copy)NSString* y;



@end
