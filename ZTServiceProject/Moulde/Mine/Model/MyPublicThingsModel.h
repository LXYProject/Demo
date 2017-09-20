//
//  MyPublicThingsModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"publicAffairList": [
//                     {

//"userPhoneNum": "13621114221",
//"affairCategory": "服务接口查看",
//"staffId": "",
//"staffName": "",
//"villageName": "岷阳小区",
//"villageId": "510018177815",
//"imageList": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170912115921.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121159211.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121159212.jpg,",
//"userAddress": "北京市;;海淀区;中关村东路;18号",
//"userRealName": "周本成2",
//"staffDeptId": "",
//"staffDeptName": "",
//"replayContent": "",
//"replayDate": "",
//"publicAffairId": "201709121159213",
//"affairTitle": "1",
//"affairDiscribe": "考虑一下",
//"staffTel": "",
//"createDate": "2017-09-12 11:59:21",
//"userId": "1362111422120170322120834",
//"y": 39.9880875,
//"x": 116.3339667,
//"status": "刚发起"
@interface MyPublicThingsModel : NSObject

@property (nonatomic,copy)NSString *userPhoneNum;
@property (nonatomic,copy)NSString *affairCategory;
@property (nonatomic,copy)NSString *staffId;
@property (nonatomic,copy)NSString *staffName;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *imageList;
@property (nonatomic,copy)NSString *userAddress;
@property (nonatomic,copy)NSString *userRealName;
@property (nonatomic,copy)NSString *staffDeptId;
@property (nonatomic,copy)NSString *staffDeptName;
@property (nonatomic,copy)NSString *replayContent;
@property (nonatomic,copy)NSString *replayDate;
@property (nonatomic,copy)NSString *publicAffairId;
@property (nonatomic,copy)NSString *affairTitle;
@property (nonatomic,copy)NSString *affairDiscribe;
@property (nonatomic,copy)NSString *staffTel;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *status;

@end
