//
//  NearByViewController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "GLViewPagerViewController.h"

@interface NearByViewController : BaseViewController
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *district;
@property (nonatomic,copy)NSString *categoryId;
//这个到时候用的时候判断_isFindService它的值为YES就是"找服务"，为NO就是"去帮忙" 直接在控制器里面随便哪里都可以用
@property (nonatomic,assign)BOOL isFindService;

@end
