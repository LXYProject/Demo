//
//  MyNeighborModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//=================查看所有与我有关的小区==========
//=============我绑定的小区========
//"myZones": [
//            {

//"alias": "",
//"propertyId": "0001",
//"zoneId": "510028280863",
//"statusInt": "",
//"cityId": "",
//"districtId": "",
//"statusDesc": "",
//"zoneY": "30.630030",
//"zoneType": "",
//"zoneImageUrl": "",
//"zoneAddress": "四川省成都市锦江区工农院街107号东景雅苑",
//"parkspaceNum": 0,
//"parkMoney": 0,
//"propertyMoney": 0,
//"builder": "",
//"coords": "",
//"zoneX": "104.100329",
//"zoneName": "东景雅苑"

//=============我关注的小区========
//"attentionZones": [
//                   {

//"alias": "",
//"propertyId": "",
//"zoneId": "510021821415",
//"statusInt": "",
//"cityId": "",
//"districtId": "",
//"statusDesc": "",
//"zoneY": "30.614378",
//"zoneType": "",
//"zoneImageUrl": "",
//"zoneAddress": "四川省成都市武侯区桐梓林中路6号",
//"parkspaceNum": 0,
//"parkMoney": 0,
//"propertyMoney": 0,
//"builder": "",
//"coords": "",
//"zoneX": "104.059620",
//"zoneName": "金地贝福里花园"
@interface MyNeighborModel : NSObject

@property (nonatomic,copy)NSString *alias;
@property (nonatomic,copy)NSString *propertyId;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *statusInt;
@property (nonatomic,copy)NSString *cityId;
@property (nonatomic,copy)NSString *districtId;
@property (nonatomic,copy)NSString *statusDesc;
@property (nonatomic,copy)NSString *zoneY;
@property (nonatomic,copy)NSString *zoneType;
@property (nonatomic,copy)NSString *zoneImageUrl;
@property (nonatomic,copy)NSString *zoneAddress;
@property (nonatomic,copy)NSString *parkspaceNum;
@property (nonatomic,copy)NSString *parkMoney;
@property (nonatomic,copy)NSString *propertyMoney;
@property (nonatomic,copy)NSString *builder;
@property (nonatomic,copy)NSString *coords;
@property (nonatomic,copy)NSString *zoneX;
@property (nonatomic,copy)NSString *zoneName;


@end
