//
//  BuyOrderModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    orders =     (
//                  {

//appointmentTime = "2017-04-21 12:45:17";
//count = 1;
//createTime = "2017-04-21 12:35:17";
//orderId = 20170421123517;
//phoneNum = 13621114221;
//remark = "留言测试";
//serviceContent = hehwhajahajjahahh;
//serviceId = 20170421110716;
//serviceImg = "";
//servicePrice = "800.00";
//serviceTitle = "上午发福利呢";
//serviceUnit = "次";
//status = 120000;
//statusStr = "订单被拒绝";
//total = "800.00";
//userHuanXinId = 201705231745426;
//userIcon = "http://192.168.1.96:8080/ZtscApp/file/headImage/1521018772020170322180211-20170609103443.png";
//userId = 1521018772020170322180211;
//userName = "朱元璋";
//userPhoneNum = 15210187720
@interface BuyOrderModel : NSObject

@property (nonatomic,copy)NSString *appointmentTime;
@property (nonatomic,copy)NSString *count;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *phoneNum;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *serviceContent;
@property (nonatomic,copy)NSString *serviceId;
@property (nonatomic,copy)NSString *serviceImg;
@property (nonatomic,copy)NSString *servicePrice;
@property (nonatomic,copy)NSString *serviceTitle;
@property (nonatomic,copy)NSString *serviceUnit;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *statusStr;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *userHuanXinId;
@property (nonatomic,copy)NSString *userIcon;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userPhoneNum;

@end
