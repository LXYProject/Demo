//
//  HouseListModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//houseList =         (
//                     {

//houseId = 510000370143;
//houseImageUrl = "暂时待定";
//houseName = "null-2单元 1层 1室";

@interface HouseListModel : NSObject

@property (nonatomic,copy)NSString *houseId;
@property (nonatomic,copy)NSString *houseImageUrl;
@property (nonatomic,copy)NSString *houseName;

@end
