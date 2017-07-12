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
@interface MyPraiseModel : NSObject

@property (nonatomic,copy)NSString *praiseId;
@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *affairCategory;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,strong)NSArray *imageList;
@property (nonatomic,copy)NSString *affairTitle;
@property (nonatomic,copy)NSString *affairDiscribe;
@property (nonatomic,copy)NSString *userAddress;
@property (nonatomic,copy)NSString *userRealName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *userPhoneNum;
@property (nonatomic,copy)NSString *createDate;


@end
