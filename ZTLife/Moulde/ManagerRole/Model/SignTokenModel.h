//
//  SignTokenModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "code": 200,
//    "message": "",
//    "result": {
//        "r": 500.01,
//        "x": 116.333999833333,
//        "y": 39.9884446111111,
//        "action": "0",
//        "information": "后一班次不存在，好好休息吧",
//        "workplan": {
//            "orgId": "",
//            "orgType": "",
//            "workshiftType": "",
//            "workshiftName": "",
//            "signInTime": "",
//            "signInLocX": 0,
//            "signInLocY": 0,
//            "signInLocName": "",
//            "signInLate": 0,
//            "signInLocAbnormal": 0,
//            "signOutTime": "",
//            "signOutLocX": 0,
//            "signOutLocY": 0,
//            "signOutLocName": "",
//            "signOutEarly": 0,
//            "signOutLocAbnormal": 0,
//            "deptId": "",
//            "workDate": "",
//            "userId": "",
//            "isSignOut": 0,
//            "isSignIn": 0,
//            "startTime": "",
//            "endTime": "",
//            "userName": "",
//            "id": ""
//        },
//        "signLocation": "财智国际大厦",
//        "actionDesc": "不可签到，不可签退",
//        "status": "0",
//        "token": "PlwdFymfuyjqBQlF7RJ9Gg=="
//    }
//}
@interface SignTokenModel : NSObject


@property (nonatomic,copy)NSString *orgId;
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
@property (nonatomic,copy)NSString *workDate;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *isSignOut;
@property (nonatomic,copy)NSString *isSignIn;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *idCount;

@end
