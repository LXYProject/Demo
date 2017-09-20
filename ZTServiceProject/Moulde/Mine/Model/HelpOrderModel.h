//
//  HelpOrderModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>
//===================我帮助的======================
//appealId = 20170512181410;
//appealUserHuanXinId = 201705231745429;
//appealUserIcon = "http://192.168.1.96:8080/ZtscApp/file/headImage/http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png";
//appealUserId = 1890918872220170322150921;
//appealUserName = "王磊";
//appealUserPhone = 18909188722;
//indentCreateTime = "2017-05-12 18:15:14";
//indentNum = 201705121815141;
//indentStatus = 159000;
//indentStatusStr = "已下单，并到达服务预约时间";
//leaveWords = "";
//serviceDescribe = "测试菜市场上厕所测试厕所";
//serviceImg = "";
//servicePrice = "188.00";
//serviceQuantity = "";
//serviceTime = "2017-05-12 18:24:31";
//serviceTitle = "测试1";

//===================我求助的======================
//appealId = 20170613155513;
//appealUserId = 1362111422120170322120834;
//indentCreateTime = "2017-07-06 16:46:44";
//indentNum = 20170706164644;
//indentStatus = 100000;
//indentStatusStr = "等待确认接单";
//leaveWords = "";
//serviceDescribe = "燃烧的味道和奇怪的响声，飞机引擎整流罩破裂，飞行和降落只靠一台发动机完成……6月11日晚，从澳大利亚悉尼机场起飞的东方航空MU736航班，185名乘客和十几名机务人员，就经历了44分钟的惊魂时刻。";
//serviceImg = "http://192.168.1.96:8080/ZtscApp/file/appeal/1362111422120170322120834-0-20170613155513.jpg";
//servicePrice = "2000.00";
//serviceTime = "2017-07-06 16:45:32";
//serviceTitle = "求助求助";
//serviceUserHuanXinId = 201705231745421;
//serviceUserIcon = "http://192.168.1.96:8080/ZtscApp/file/headImage/http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png";
//serviceUserId = 005600;
//serviceUserName = "其实我很帅";
//serviceUserPhone = 13212345678;
//==========================================================================


//"appealOrderList": [
//                    {

//"helperPhoneNum": "13687654321",
//"orderCreateDate": "2017-09-18 00:00:00",
//"orderStatus": "100000",
//"orderStatusStr": "",
//"orderUpdateDate": "",
//"appealTitle": "去旅行",
//"appealContent": "去旅行了，没有导游唉，不要哭，你愿意做我导游么！带上你去旅行",
//"appealImageUrl": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170911165355.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709111653551.jpg,",
//"appealPrice": 500,
//"appealerHeaderImageUrl": "",
//"appealerName": "",
//"appealerHuanxinId": "",
//"helperHeaderImageUrl": "",
//"helperName": "",
//"helperHuanxinId": "",
//"remark": "我来帮你",
//"appealerId": "",
//"helperId": "",
//"appealId": "201709111653552",
//"orderId": "20170918134658",
//"appointmentTime": "2017-09-18 13:45:53"


@interface HelpOrderModel : NSObject

//@property (nonatomic,copy)NSString *appealId;
//@property (nonatomic,copy)NSString *appealUserHuanXinId;
//@property (nonatomic,copy)NSString *appealUserIcon;
//@property (nonatomic,copy)NSString *appealUserId;
//@property (nonatomic,copy)NSString *appealUserName;
//@property (nonatomic,copy)NSString *appealUserPhone;
//@property (nonatomic,copy)NSString *indentCreateTime;
//@property (nonatomic,copy)NSString *indentNum;
//@property (nonatomic,copy)NSString *indentStatusStr;
//@property (nonatomic,copy)NSString *leaveWords;
//@property (nonatomic,copy)NSString *serviceDescribe;
//@property (nonatomic,copy)NSString *serviceImg;
//@property (nonatomic,copy)NSString *servicePrice;
//@property (nonatomic,copy)NSString *serviceQuantity;
//@property (nonatomic,copy)NSString *serviceTime;
//@property (nonatomic,copy)NSString *serviceTitle;


//@property (nonatomic,copy)NSString *serviceUserHuanXinId;
//@property (nonatomic,copy)NSString *serviceUserIcon;
//@property (nonatomic,copy)NSString *serviceUserId;
//@property (nonatomic,copy)NSString *serviceUserName;
//@property (nonatomic,copy)NSString *serviceUserPhone;

@property (nonatomic,copy)NSString *helperPhoneNum;
@property (nonatomic,copy)NSString *orderCreateDate;
@property (nonatomic,copy)NSString *orderStatus;
@property (nonatomic,copy)NSString *orderStatusStr;
@property (nonatomic,copy)NSString *orderUpdateDate;
@property (nonatomic,copy)NSString *appealTitle;
@property (nonatomic,copy)NSString *appealContent;
@property (nonatomic,copy)NSString *appealImageUrl;
@property (nonatomic,copy)NSString *appealPrice;
@property (nonatomic,copy)NSString *appealerHeaderImageUrl;
@property (nonatomic,copy)NSString *appealerName;
@property (nonatomic,copy)NSString *appealerHuanxinId;
@property (nonatomic,copy)NSString *helperHeaderImageUrl;
@property (nonatomic,copy)NSString *helperName;
@property (nonatomic,copy)NSString *helperHuanxinId;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *appealerId;
@property (nonatomic,copy)NSString *helperId;
@property (nonatomic,copy)NSString *appealId;
@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,copy)NSString *appointmentTime;
@end
