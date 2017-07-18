//
//  AnnounceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"bulletinList": [
//                 {

//"createTime": "2017-05-26 11:49:02",
//"bulletinId": "201705261149021",
//"bulletinTitle": "测试公告文件",
//"bulletinSubtitle": "测试公告文件",
//"bulletinCategory": "小区公告",
//"bulletinUrl": "20170526114902.html",
//"zoneId": "510018177815"
@interface AnnounceModel : NSObject

@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *bulletinId;
@property (nonatomic,copy)NSString *bulletinTitle;
@property (nonatomic,copy)NSString *bulletinSubtitle;
@property (nonatomic,copy)NSString *bulletinCategory;
@property (nonatomic,copy)NSString *bulletinUrl;
@property (nonatomic,copy)NSString *zoneId;

@end
