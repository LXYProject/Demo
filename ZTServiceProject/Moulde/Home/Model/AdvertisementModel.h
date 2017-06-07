//
//  AdvertisementModel.h
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementModel : NSObject
//id
@property (nonatomic,copy)NSString *adId;
//点击的链接地址
@property (nonatomic,copy)NSString *targetUrl;
//标题
@property (nonatomic,copy)NSString *title;
//图片地址
@property (nonatomic,copy)NSString *imageUrl;
//文字
@property (nonatomic,copy)NSString *content;
@end
