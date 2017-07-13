//
//  VillagesModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"zoneList": [
//             {

//"zoneId": "510029841228",
//"propertyId": "0001",
//"coords": "",
//"zoneX": "103.929500",
//"zoneY": "30.737510",
//"zoneType": "",
//"zoneImageUrl": "",
//"zoneAddress": "四川省成都市郫县西华大学社区西华大学教师公寓",
//"zoneName": "西华大学教师公寓"
@interface VillagesModel : NSObject

@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *propertyId;
@property (nonatomic,copy)NSString *coords;
@property (nonatomic,copy)NSString *zoneX;
@property (nonatomic,copy)NSString *zoneY;
@property (nonatomic,copy)NSString *zoneType;
@property (nonatomic,copy)NSString *zoneImageUrl;
@property (nonatomic,copy)NSString *zoneAddress;
@property (nonatomic,copy)NSString *zoneName;

@end
