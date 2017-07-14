//
//  BuildingListModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//buildingList =     (
//                    {

//buildingage = "";
//buildingid = 510000181483;
//buildingname = "3栋";
//buildingtype = "";
//buildingx = "104.062502";
//buildingy = "30.660784";
//coords = "";
//statusdesc = "";
//statusint = "";

@interface BuildingListModel : NSObject

@property (nonatomic,copy)NSString *buildingAge;
@property (nonatomic,copy)NSString *buildingId;
@property (nonatomic,copy)NSString *buildingName;
@property (nonatomic,copy)NSString *buildingType;
@property (nonatomic,copy)NSString *buildingX;
@property (nonatomic,copy)NSString *buildingY;
@property (nonatomic,copy)NSString *coords;
@property (nonatomic,copy)NSString *statusDesc;
@property (nonatomic,copy)NSString *statusInt;

@end
