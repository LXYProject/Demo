//
//  MySchedulingModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/19.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>


//{
//    "code": 200,
//    "message": "",
//    "result": {
//        "propertyWorkPlanList": [
//                                 {

//"deptId": "1",
//"workDate": "2017-09-01 00:00:00",
//"userId": "001",
//"isSignOut": 0,
//"isSignIn": 0,
//"orgType": "1",
//"workshiftType": "1",
//"workshiftName": "早班",
//"signInTime": "",
//"signInLocX": 0,
//"signInLocY": 0,
//"signInLocName": "",
//"signInLate": 0,
//"signInLocAbnormal": 0,
//"signOutTime": "",
//"signOutLocX": 0,
//"signOutLocY": 0,
//"signOutLocName": "",
//"signOutEarly": 0,
//"signOutLocAbnormal": 0,
//"orgId": "2",
//"userName": "sa",
//"startTime": "",
//"endTime": "",
//"id": "1"

@interface MySchedulingModel : NSObject

@property (nonatomic,copy)NSString *deptId;
@property (nonatomic,copy)NSDate *workDate;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *isSignOut;
@property (nonatomic,copy)NSString *isSignIn;
@property (nonatomic,copy)NSString *orgType;
@property (nonatomic,copy)NSString *workshiftType;
@property (nonatomic,copy)NSString *workshiftName;
@property (nonatomic,copy)NSString *signInTime;
@property (nonatomic,copy)NSString *signInLocX;
@property (nonatomic,copy)NSString *signInLocY;
@property (nonatomic,copy)NSString *signInLocName;
@property (nonatomic,copy)NSString *signInLate;
@property (nonatomic,copy)NSString *signInLocAbnormal;
@property (nonatomic,copy)NSString *signOutTime;
@property (nonatomic,copy)NSString *signOutLocX;
@property (nonatomic,copy)NSString *signOutLocY;
@property (nonatomic,copy)NSString *signOutLocName;
@property (nonatomic,copy)NSString *signOutEarly;
@property (nonatomic,copy)NSString *signOutLocAbnormal;
@property (nonatomic,copy)NSString *orgId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,copy)NSString *idCount;


@end
