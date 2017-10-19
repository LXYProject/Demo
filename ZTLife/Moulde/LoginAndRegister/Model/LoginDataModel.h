//
//  LoginDataModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>


//用户注册验证码核对
//gender = 0;
//headImage = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//huanxinUserName = 20170704115427;
//huanxinUserpassword = 20170704115427;
//isIdentification = 0;
//nickName = sa18516835791;
//phoneNum = 18516835791;
//status = 0;
//token = "SUM1MI8pEzsGAjpzVZfMQ==";
//userId = 20170704115427;

//==========================================================
//{
//    code = 200;
//    message = "";
//    result =     {

//information = "";
//status = 0;
//token = "oM7AXWV9GZpuoR4S0tJDA==";
//userInfo =     {
//    affairList = "";
//    age = 22;
//    birthday = "";
//    companyId = 2;
//    companyName = "";
//    dealAffairNum = 0;
//    deptId = "a03d181b-d179-4e8d-857a-a1049a560124";
//    deptName = "";
//    email = "";
//    entryDate = "";
//    gender = 0;
//    genderStr = "女";
//    headImageUrl = "";
//    huanxinId = 2017091616511936;
//    huanxinPassword = "";
//    information = "";
//    isActived = 1;
//    propertyUserId = 20170909150123;
//    propertyUserName = "李小艳";
//    propertyUserPassword = 123456;
//    qq = "";
//    roleCode = "";
//    roleLevel = 0;
//    roleName = "";
//    serviceList = "";
//    serviceNum = 0;
//    serviceScore = 0;
//    status = "正常";
//    tel = 18516835791;
//    topCompanyId = 2;
//    topCompanyName = "";
//    villageId = "";
//    villageName = "";
//    villagePropertyTel = "";
//    visitServicingNum = 0;
//    weChat = "";
//    x = 0;
//    y = 0;

@interface LoginDataModel : NSObject


//@property (nonatomic,copy)NSString *information;
//@property (nonatomic,copy)NSString *status;
//@property (nonatomic,copy)NSString *token;
//@property (nonatomic, strong) NSDictionary *userInfo;
//
//@property (nonatomic,copy)NSString *affairList;
//@property (nonatomic,copy)NSString *age;
//@property (nonatomic,copy)NSString *birthday;
//@property (nonatomic,copy)NSString *companyId;
//@property (nonatomic,copy)NSString *companyName;
//@property (nonatomic,copy)NSString *dealAffairNum;
//@property (nonatomic,copy)NSString *deptId;
//@property (nonatomic,copy)NSString *deptName;
//@property (nonatomic,copy)NSString *email;
//@property (nonatomic,copy)NSString *entryDate;
//@property (nonatomic,copy)NSString *gender;
//@property (nonatomic,copy)NSString *genderStr;
//@property (nonatomic,copy)NSString *headImageUrl;
//@property (nonatomic,copy)NSString *huanxinId;
//@property (nonatomic,copy)NSString *huanxinPassword;
//@property (nonatomic,copy)NSString *qq;
//@property (nonatomic,copy)NSString *roleCode;
//@property (nonatomic,copy)NSString *roleLevel;
//@property (nonatomic,copy)NSString *roleName;
//@property (nonatomic,copy)NSString *serviceList;
//@property (nonatomic,copy)NSString *serviceNum;
//@property (nonatomic,copy)NSString *serviceScore;
////@property (nonatomic,copy)NSString *status;
//@property (nonatomic,copy)NSString *tel;
//@property (nonatomic,copy)NSString *topCompanyId;
//@property (nonatomic,copy)NSString *topCompanyName;
//@property (nonatomic,copy)NSString *villageId;
//@property (nonatomic,copy)NSString *villageName;
//@property (nonatomic,copy)NSString *villagePropertyTel;
//@property (nonatomic,copy)NSString *visitServicingNum;
//@property (nonatomic,copy)NSString *weChat;
//@property (nonatomic,copy)NSString *x;
//@property (nonatomic,copy)NSString *y;



@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *headImage;
@property (nonatomic,copy)NSString *huanxinUserName;
@property (nonatomic,copy)NSString *huanxinUserpassword;
@property (nonatomic,copy)NSString *isIdentification;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *phoneNum;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *userId;


@end
