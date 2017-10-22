//
//  PublicThingsOneModel.h
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
//        "propertyLeaveList": [
//                              {

//"headImageUrl": "",
//"userId": "20170907180148",
//"machineId": "862265031606615",
//"machineName": "HUAWEI EVA-AL00 7.0",
//"clientType": "1",
//"leaveTypeId": "0",
//"leaveTypeName": "病假",
//"leaveDetails": "若夫黄叶辞柯，对金节而送燠，丹桂浮香，比西风而迎凉，啼猿则声声啸冷，吟虫则双双鸣寒，所以烟障不落，零氛恒周，以至喉如吞炭，口若在汤，而身体肢干，五感七窍，非无辅，车之难，遂成城，池之殃，岂不悲乎",
//"applyTime": "2017-09-28 17:37:26",
//"approveTime": "",
//"approveId": "",
//"approveUserName": "",
//"applyUserName": "物业-曹操",
//"applyUserDeptName": "财务部",
//"approveStatus": "0",
//"approveMessage": "",
//"startTime": "2017-09-28 00:00:00",
//"endTime": "2017-09-28 00:00:00",
//"id": 64

@interface PublicThingsOneModel : NSObject

@property (nonatomic,copy)NSString *headImageUrl;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *machineId;
@property (nonatomic,copy)NSString *machineName;
@property (nonatomic,copy)NSString *clientType;
@property (nonatomic,copy)NSString *leaveTypeId;
@property (nonatomic,copy)NSString *leaveTypeName;
@property (nonatomic,copy)NSString *leaveDetails;
@property (nonatomic,copy)NSString *applyTime;
@property (nonatomic,copy)NSString *approveId;
@property (nonatomic,copy)NSString *approveUserName;
@property (nonatomic,copy)NSString *applyUserName;
@property (nonatomic,copy)NSString *applyUserDeptName;
@property (nonatomic,copy)NSString *approveStatus;
@property (nonatomic,copy)NSString *approveMessage;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,copy)NSString *idCount;

@end
