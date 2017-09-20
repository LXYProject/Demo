//
//  MyPraiseModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"praiseId": "20170712161940",
//"villageName": "东景雅苑",
//"affairCategory": "表扬",
//"userId": "1362111422120170322120834",
//"imageList": "http://192.168.1.96:8080/ZtscApp/file/praiseImage/1362111422120170322120834-0-20170712161940.jpg,http://192.168.1.96:8080/ZtscApp/file/praiseImage/1362111422120170322120834-1-20170712161941.jpg",
//"affairTitle": "物业妹子很漂亮",
//"affairDiscribe": "表扬一下物业妹纸",
//"userAddress": "0",
//"userRealName": "sa周本成2",
//"villageId": "510028280863",
//"userPhoneNum": "13621114221",
//"createDate": "2017-07-12 16:19:40"


//"praiseList": [
//               {
//"userPhoneNum": "13621114221",
//"staffId": "",
//"staffName": "",
//"villageName": "岷阳小区",
//"villageId": "510018177815",
//"imageList": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170912140427.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121404271.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121404272.jpg,",
//"userAddress": "0",
//"userRealName": "周本成2",
//"staffDeptId": "",
//"staffDeptName": "",
//"replayContent": "",
//"replayDate": "",
//"praiseId": "201709121404273",
//"createDate": "2017-09-12 14:04:27",
//"title": "表扬下快递小哥",
//"categoryId": "表扬",
//"categoryName": "",
//"userId": "1362111422120170322120834",
//"content": "无畏送快递，表扬一下下",
//"status": ""
@interface MyPraiseModel : NSObject

@property (nonatomic,copy)NSString *userPhoneNum;
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
@property (nonatomic,copy)NSString *praiseId;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *categoryId;
@property (nonatomic,copy)NSString *categoryName;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *status;


//@property (nonatomic,copy)NSString *praiseId;
//@property (nonatomic,copy)NSString *villageName;
//@property (nonatomic,copy)NSString *affairCategory;
//@property (nonatomic,copy)NSString *userId;
//@property (nonatomic,strong)NSArray *imageList;
//@property (nonatomic,copy)NSString *affairTitle;
//@property (nonatomic,copy)NSString *affairDiscribe;
//@property (nonatomic,copy)NSString *userAddress;
//@property (nonatomic,copy)NSString *userRealName;
//@property (nonatomic,copy)NSString *villageId;
//@property (nonatomic,copy)NSString *userPhoneNum;
//@property (nonatomic,copy)NSString *createDate;
@end
