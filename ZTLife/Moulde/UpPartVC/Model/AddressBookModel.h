//
//  AddressBookModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>


//{
//    "code": 200,
//    "message": "",
//    "result": {
//        "userList": [
//                     {

//"serviceList": "",
//"affairList": "",
//"headImageUrl": "",
//"serviceNum": 0,
//"serviceScore": 0,
//"villagePropertyTel": "",
//"tel": "13509188722",
//"companyId": "2",
//"birthday": "",
//"genderStr": "女",
//"age": 22,
//"gender": 0,
//"qq": "",
//"email": "",
//"deptId": "a03d181b-d179-4e8d-857a-a1049a560124",
//"propertyUserName": "蓝猫",
//"propertyUserId": "1",
//"propertyUserPassword": "666666",
//"huanxinId": "2017091516511936",
//"huanxinPassword": "123456",
//"isActived": 1,
//"deptName": "",
//"companyName": "",
//"topCompanyId": "2",
//"topCompanyName": "",
//"villageId": "",
//"villageName": "",
//"information": "",
//"roleLevel": 0,
//"roleCode": "",
//"roleName": "",
//"weChat": "",
//"entryDate": "",
//"visitServicingNum": 0,
//"dealAffairNum": 0,
//"y": 0,
//"x": 0,
//"status": "正常"
@interface AddressBookModel : NSObject

@property (nonatomic,copy)NSString *serviceList;
@property (nonatomic,copy)NSString *affairList;
@property (nonatomic,copy)NSString *headImageUrl;
@property (nonatomic,copy)NSString *serviceNum;
@property (nonatomic,copy)NSString *serviceScore;
@property (nonatomic,copy)NSString *villagePropertyTel;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *companyId;
@property (nonatomic,copy)NSString *birthday;
@property (nonatomic,copy)NSString *genderStr;
@property (nonatomic,copy)NSString *age;
@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *deptId;
@property (nonatomic,copy)NSString *propertyUserName;
@property (nonatomic,copy)NSString *propertyUserId;
@property (nonatomic,copy)NSString *propertyUserPassword;
@property (nonatomic,copy)NSString *huanxinId;
@property (nonatomic,copy)NSString *huanxinPassword;
@property (nonatomic,copy)NSString *isActived;
@property (nonatomic,copy)NSString *deptName;
@property (nonatomic,copy)NSString *companyName;
@property (nonatomic,copy)NSString *topCompanyId;
@property (nonatomic,copy)NSString *topCompanyName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *information;
@property (nonatomic,copy)NSString *roleLevel;
@property (nonatomic,copy)NSString *roleCode;
@property (nonatomic,copy)NSString *roleName;
@property (nonatomic,copy)NSString *weChat;
@property (nonatomic,copy)NSString *entryDate;
@property (nonatomic,copy)NSString *visitServicingNum;
@property (nonatomic,copy)NSString *dealAffairNum;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *status;

@end
