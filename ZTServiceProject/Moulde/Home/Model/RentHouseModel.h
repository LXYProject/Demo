//
//  RentHouseModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    code = 200;
//    message = "";
//    result =     {
//        houseRentList =         (
//                                 {

//address = "null null null";
//basicFacilities =                 (
//                                   "宽带"
//                                   );
//buildingId = 20170428165431;
//buildingName = "12#";
//cityId = null;
//cityName = null;
//delTime = "";
//delUserId = "";
//description = "";
//direction = "东";
//districtId = null;
//districtName = null;
//elevatorRatio = "0梯0户";
//extendedFacilities =                 (
//                                      "随时看房"
//                                      );
//floorAll = 0;
//hasElevator = 1;
//heatingMode = "集中供暖";
//houseFitment = "普通装修";
//houseFloor = "低楼层";
//houseId = 20170508100155;
//houseNumber = "5单元302";
//housePicList =                 (
//                                {
//                                    url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_01.jpg";
//                                },
//                                {
//                                    url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_02.jpg";
//                                },
//                                {
//                                    url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_03.jpg";
//                                }
//                                );
//housePicSmallList =                 (
//                                     {
//                                         url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_01_small.jpg";
//                                     },
//                                     {
//                                         url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_02_small.jpg";
//                                     },
//                                     {
//                                         url = "http://192.168.1.96:8080/ZtscApp/file/houseRent/hr20170512114329_03_small.jpg";
//                                     }
//                                     );
//houseType = "0室0厅0卫";
//houseUseful = "普通住宅";
//isBasement = 0;
//isMaisonette = "平层";
//keepList =                 (
//);
//ownerId = 1890918872220170322150921;
//ownerImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png";
//ownerName = "王磊";
//partOrTotal = 1;
//provinceId = null;
//provinceName = null;
//publishStatus = 1;
//publishTime = "2017-05-12 11:43:29";
//rentArea = 85;
//rentId = hr20170512114329;
//rentLimit =                 (
//                             "只限女生",
//                             " 中介勿扰"
//                             );
//rentPrice = 1000;
//roadName = "";
//villageId = V001;
//villageName = "测试";
//x = 0;
//y = 0;
@interface RentHouseModel : NSObject


@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSArray *basicFacilities;
@property (nonatomic,copy)NSString *buildingId;
@property (nonatomic,strong)NSArray *buildingName;
@property (nonatomic,copy)NSString *cityId;
@property (nonatomic,copy)NSString *cityName;
@property (nonatomic,copy)NSString *delTime;
@property (nonatomic,copy)NSString *delUserId;
@property (nonatomic,copy)NSString *descriptiont;
@property (nonatomic,strong)NSArray *districtId;
@property (nonatomic,copy)NSString *districtName;
@property (nonatomic,copy)NSString *elevatorRatio;
@property (nonatomic,strong)NSArray *extendedFacilities;


@property (nonatomic,copy)NSString *floorAll;
@property (nonatomic,copy)NSString *hasElevator;
@property (nonatomic,copy)NSString *heatingMode;
@property (nonatomic,copy)NSString *houseFitment;
@property (nonatomic,copy)NSString *houseFloor;
@property (nonatomic,copy)NSString *houseId;
@property (nonatomic,copy)NSString *houseNumber;
@property (nonatomic,strong)NSArray *housePicList;
@property (nonatomic,strong)NSArray *housePicSmallList;


@property (nonatomic,copy)NSString *houseType;
@property (nonatomic,copy)NSString *houseUseful;
@property (nonatomic,copy)NSString *isBasement;
@property (nonatomic,copy)NSString *isMaisonette;
@property (nonatomic,strong)NSArray *keepList;



@property (nonatomic,copy)NSString *ownerId;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *ownerName;
@property (nonatomic,copy)NSString *partOrTotal;
@property (nonatomic,copy)NSString *provinceId;
@property (nonatomic,copy)NSString *provinceName;
@property (nonatomic,copy)NSString *publishStatus;
@property (nonatomic,copy)NSString *publishTime;
@property (nonatomic,copy)NSString *rentArea;
@property (nonatomic,copy)NSString *rentId;
@property (nonatomic,strong)NSArray *rentLimit;
@property (nonatomic,copy)NSString *rentPrice;
@property (nonatomic,copy)NSString *roadName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *y;



@end
