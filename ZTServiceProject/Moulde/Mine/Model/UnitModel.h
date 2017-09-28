//
//  UnitModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"buildingUnitList": [
//                     {

//"buildingName": "",
//"buildindId": "",
//"unitId": "f1ccef9a-c8fd-4b47-80c0-8cf68eed6420",
//"unitName": "1单元",
//"unitCount": 0

@interface UnitModel : NSObject

@property (nonatomic,copy)NSString *buildingName;
@property (nonatomic,copy)NSString *buildindId;
@property (nonatomic,copy)NSString *unitId;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSString *unitCount;

@end
