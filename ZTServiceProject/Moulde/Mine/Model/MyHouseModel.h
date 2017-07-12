//
//  MyHouseModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>
//===========================查看所有与我有关的房屋=============
//===========================绑定的房屋=============
//"bindHouses": [
//               {

//"proprietorId": "",
//"moveDate": "",
//"tel": "",
//"cardID": "",
//"proprietor_name": "",
//"title": "西华大学教师公寓5栋-5单元 4层 9室",
//"statusOfHouse": "0",
//"statusOfHouseStr": "正常",
//"housepaperAge": "",
//"housepaperPic": "",
//"landAge": 0,
//"hasParkspace": 0,
//"propertyRightsType": "",
//"zoneName": "西华大学教师公寓",
//"housePicList": [],
//"housePicSmallList": [],
//"floorAll": 0,
//"direction": "",
//"isBasement": 0,
//"houseFitment": "",
//"houseUseful": "",
//"buildingId": "510001957697",
//"buildingName": "5栋",
//"isMaisonette": "",
//"houseType": "",
//"heatingMode": "",
//"elevatorRatio": "",
//"hasElevator": 0,
//"zoneId": "510029841228",
//"houseId": "510001993226",
//"buildingArea": "",
//"usingArea": "",
//"houseFloor": "",
//"gender": "",
//"ownerType": "",
//"y": 30.73751,
//"x": 103.9295,
//"location": "四川省成都市郫县西华大学社区西华大学教师公寓"

//===========================关注的房屋=============
//"attentionHouses": [],

@interface MyHouseModel : NSObject

@property (nonatomic,copy)NSString *proprietorId;
@property (nonatomic,copy)NSString *moveDate;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *cardID;
@property (nonatomic,copy)NSString *proprietor_name;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *statusOfHouse;
@property (nonatomic,copy)NSString *statusOfHouseStr;
@property (nonatomic,copy)NSString *housepaperAge;
@property (nonatomic,copy)NSString *housepaperPic;
@property (nonatomic,copy)NSString *landAge;
@property (nonatomic,copy)NSString *hasParkspace;
@property (nonatomic,copy)NSString *propertyRightsType;
@property (nonatomic,copy)NSString *propertyMoney;
@property (nonatomic,copy)NSString *zoneName;
@property (nonatomic,strong)NSArray *housePicList;
@property (nonatomic,strong)NSArray *housePicSmallList;
@property (nonatomic,copy)NSString *floorAll;
@property (nonatomic,copy)NSString *direction;
@property (nonatomic,copy)NSString *isBasement;
@property (nonatomic,copy)NSString *houseFitment;
@property (nonatomic,copy)NSString *houseUseful;
@property (nonatomic,copy)NSString *buildingId;
@property (nonatomic,copy)NSString *buildingName;
@property (nonatomic,copy)NSString *isMaisonette;
@property (nonatomic,copy)NSString *houseType;
@property (nonatomic,copy)NSString *heatingMode;
@property (nonatomic,copy)NSString *elevatorRatio;
@property (nonatomic,copy)NSString *hasElevator;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *houseId;
@property (nonatomic,copy)NSString *buildingArea;
@property (nonatomic,copy)NSString *usingArea;
@property (nonatomic,copy)NSString *houseFloor;
@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *ownerType;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *location;


@property (nonatomic,copy)NSString *url;

@end
