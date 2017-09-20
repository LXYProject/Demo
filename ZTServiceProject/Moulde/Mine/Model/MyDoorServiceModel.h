//
//  MyDoorServiceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"houseName": "西华大学教师公寓5栋-5单元 4层 9室",
//"imageList": "http://192.168.1.96:8080/ZtscApp/file/visitService/1362111422120170322120834-0-20170711121619.jpg,http://192.168.1.96:8080/ZtscApp/file/visitService/1362111422120170322120834-1-20170711121619.jpg,http://192.168.1.96:8080/ZtscApp/file/visitService/1362111422120170322120834-2-20170711121619.jpg,http://192.168.1.96:8080/ZtscApp/file/visitService/1362111422120170322120834-3-20170711121619.jpg",
//"userAddress": "四川省成都市郫县西华大学社区西华大学教师公寓",
//"userRealName": "sa周本成2",
//"propertyUserName": "",
//"serviceCategory": "用电维修",
//"visitServiceId": "20170711121619",
//"propertyUserId": "",
//"villageId": "510018177815",
//"serviceTime": "2017-07-12 00:00:00",
//"remark": "",
//"userPhoneNum": "13621114221",
//"serviceTitle": "1",
//"createDate": "2017-07-11 12:16:19",
//"price": 0,
//"propertyUserTel": "",
//"report": "",
//"serviceDiscribe": "维修",
//"villageName": "岷阳小区",
//"houseId": "510001993226",
//"userId": "1362111422120170322120834",
//"y": 30.73751,
//"x": 103.9295,
//"status": "刚发起"

//"visitServiceList": [
//                     {
//"serviceTime": "2017-09-13 00:00:00",
//"userPhoneNum": "13621114221",
//"serviceTitle": "1",
//"visitServiceId": "201709121043224",
//"serviceCategory": "树改造",
//"houseId": "510001961333",
//"propertyUserId": "",
//"villageName": "岷阳小区",
//"villageId": "510018177815",
//"houseName": "和平小区 5栋 2单元 1层 ( 2单元 1层 1室 )",
//"imageList": "http://192.168.1.96:8080/ZtscApp/file/jpg/201709121043221.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121043222.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121043223.jpg,",
//"userAddress": "四川省成都市郫县望丛中路563号",
//"userRealName": "周本成2",
//"report": "",
//"propertyUserTel": "",
//"serviceDiscribe": "描述一下头嘟嘟嘟木木木女女多头女嘟嘟嘟忒TF",
//"propertyUserName": "",
//"createDate": "2017-09-12 10:43:22",
//"price": 0,
//"userId": "1362111422120170322120834",
//"remark": "",
//"y": 30.800581,
//"x": 103.886369,
//"status": "刚发起"
@interface MyDoorServiceModel : NSObject

@property (nonatomic,copy)NSString *serviceTime;
@property (nonatomic,copy)NSString *userPhoneNum;
@property (nonatomic,copy)NSString *serviceTitle;
@property (nonatomic,copy)NSString *visitServiceId;
@property (nonatomic,copy)NSString *serviceCategory;
@property (nonatomic,copy)NSString *houseId;
@property (nonatomic,copy)NSString *propertyUserId;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *houseName;
@property (nonatomic,copy)NSString *imageList;
@property (nonatomic,copy)NSString *userAddress;
@property (nonatomic,copy)NSString *userRealName;
@property (nonatomic,copy)NSString *report;
@property (nonatomic,copy)NSString *propertyUserTel;
@property (nonatomic,copy)NSString *serviceDiscribe;
@property (nonatomic,copy)NSString *propertyUserName;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *status;


//@property (nonatomic,copy)NSString *houseName;
//@property (nonatomic,strong)NSArray *imageList;
//@property (nonatomic,copy)NSString *userAddress;
//@property (nonatomic,copy)NSString *userRealName;
//@property (nonatomic,copy)NSString *propertyUserName;
//@property (nonatomic,copy)NSString *serviceCategory;
//@property (nonatomic,copy)NSString *visitServiceId;
//@property (nonatomic,copy)NSString *propertyUserId;
//@property (nonatomic,copy)NSString *villageId;
//@property (nonatomic,copy)NSString *serviceTime;
//@property (nonatomic,copy)NSString *remark;
//@property (nonatomic,copy)NSString *userPhoneNum;
//@property (nonatomic,copy)NSString *serviceTitle;
//@property (nonatomic,copy)NSString *createDate;
//@property (nonatomic,copy)NSString *price;
//@property (nonatomic,copy)NSString *propertyUserTel;
//@property (nonatomic,copy)NSString *report;
//@property (nonatomic,copy)NSString *serviceDiscribe;
//@property (nonatomic,copy)NSString *villageName;
//@property (nonatomic,copy)NSString *houseId;
//@property (nonatomic,copy)NSString *userId;
//@property (nonatomic,copy)NSString *y;
//@property (nonatomic,copy)NSString *x;
//@property (nonatomic,copy)NSString *status;

@end
