//
//  HousingModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"houseList": [
//              {

//"villageId": "",
//"houseId": "443b54b1-2b1b-4ee5-8e00-6b6bf88e920b",
//"buildingId": "",
//"buildingName": "",
//"unitId": "",
//"unitName": "",
//"floorId": "",
//"floorName": "",
//"houseName": "301",
//"houseImageUrl": ""

@interface HousingModel : NSObject

@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *houseId;
@property (nonatomic,copy)NSString *buildingId;
@property (nonatomic,copy)NSString *buildingName;
@property (nonatomic,copy)NSString *unitId;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSString *floorId;
@property (nonatomic,copy)NSString *floorName;
@property (nonatomic,copy)NSString *houseName;
@property (nonatomic,copy)NSString *houseImageUrl;

@end
