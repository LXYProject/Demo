//
//  FloorModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"buildingFloorList": [
//                      {

//"buildingName": "",
//"buildindId": "",
//"unitId": "",
//"unitName": "",
//"floorId": "8df97c13-b472-4529-860f-679bf260ef79",
//"floorName": "3",
//"floorCount": 0

@interface FloorModel : NSObject

@property (nonatomic,copy)NSString *buildingName;
@property (nonatomic,copy)NSString *buildindId;
@property (nonatomic,copy)NSString *unitId;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSString *floorId;
@property (nonatomic,copy)NSString *floorName;
@property (nonatomic,copy)NSString *floorCount;

@end
