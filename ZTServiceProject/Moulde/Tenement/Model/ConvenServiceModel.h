//
//  ConvenServiceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"serviceList": [
//                {

//"serviceCategory": "web",
//"serviceProvider": "pc",
//"servicePhoneNum": "00100100111",
//"serviceAddress": "倒萨"

//"convenienceList": [
//                    {

//"villageName": "",
//"villageId": "",
//"serviceContent": "",
//"createDate": "2017-05-08 09:15:30",
//"serviceCategory": "养生",
//"convenienceId": "",
//"serviceProvider": "坤师傅",
//"servicePhoneNum": "13886868438",
//"serviceAddress": "广东省广州市越秀区中山六路63 距离市中心约6383米 "

@interface ConvenServiceModel : NSObject

@property (nonatomic,copy)NSString *serviceCategory;
@property (nonatomic,copy)NSString *serviceProvider;
@property (nonatomic,copy)NSString *servicePhoneNum;
@property (nonatomic,copy)NSString *serviceAddress;

@property (nonatomic,copy)NSString *villageName;
@property (nonatomic,copy)NSString *villageId;
@property (nonatomic,copy)NSString *serviceContent;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *convenienceId;

@end
