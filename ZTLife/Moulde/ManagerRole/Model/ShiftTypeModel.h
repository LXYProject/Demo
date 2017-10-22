//
//  ShiftTypeModel.h
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
//        "propertyWorkShiftList": [
//                                  {

//"code": "A001",
//"workHours": "06:00-14:00",
//"totalHours": "8.0",
//"name": "早班",
//"id": 1

@interface ShiftTypeModel : NSObject

@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *workHours;
@property (nonatomic,copy)NSString *totalHours;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *idCount;

@end
