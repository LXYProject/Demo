//
//  SecondHandModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    code = 200;
//    message = "";
//    result =     {
//        secondHandList =         (

//address = "";
//classId = SCB014;
//commentCount = 1;
//commentList =                 (
//                               {
//                                   comment = "好手机";
//                                   commentCount = 0;
//                                   commentId = sr20170510151414;
//                                   commentTime = "2017-05-10 15:14:14";
//                                   isLiked = 0;
//                                   likeCount = 0;
//                                   subCommentList =                         (
//                                   );
//                                   userId = 1890918872220170322150921;
//                                   userImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png";
//                                   userName = "王磊";
//                               }
//                               );
//createTime = "2017-05-10 15:13:55";
//delTime = "";
//delivery = 1;
//keepList =                 (
//);
//newOrOld = 0;
//onwerName = "王磊";
//oriPrice = 0;
//ownerHuanxinId = 201705231745429;
//ownerId = 1890918872220170322150921;
//ownerImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png";
//postStatus = 1;
//secPrice = 1288;
//secondHandContent = "99新红米手机，只要998，需要的亲快快联系我哦";
//secondHandId = s20170510151355;
//secondHandNormalImageList =                 (
//                                             {
//                                                 url = "http://192.168.1.96:8080/ZtscApp/file/secondHand/s20170510151355_01.JPEG";
//                                             },
//                                             {
//                                                 url = "http://192.168.1.96:8080/ZtscApp/file/secondHand/s20170510151355_02.JPEG";
//                                             }
//                                             );
//secondHandSmallImageList =                 (
//                                            {
//                                                url = "http://192.168.1.96:8080/ZtscApp/file/secondHand/s20170510151355_01_small.JPEG";
//                                            },
//                                            {
//                                                url = "http://192.168.1.96:8080/ZtscApp/file/secondHand/s20170510151355_02_small.JPEG";
//                                            }
//                                            );
//secondHandTitle = "红米手机出手啦";
//x = 1;
//y = 1;
//zoneId = "";
//zoneName = "";


//"secondHandList": [
//                   {

//"ownerId": "1833082163320170322110130",
//"commentList": [],
//"keepList": [],
//"secPrice": 1,
//"delivery": 1,
//"classId": "SCB010",
//"newOrOld": 1,
//"imageGroupId": "20170912123434",
//"imageUrlList": "http://192.168.1.96:8080/ZtscApp/file/jpg/20170912123438.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121234381.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121234382.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121234383.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121234384.jpg,http://192.168.1.96:8080/ZtscApp/file/jpg/201709121234385.jpg,",
//"commentCount": 0,
//"postStatus": 1,
//"delTime": "",
//"secondHandContent": "哦",
//"zoneName": "",
//"oriPrice": 1,
//"ownerHuanxinId": "201708080957208",
//"onwerName": "许许阳阳",
//"ownerImageUrl": "1833082163320170322110130-20170719175920.png",
//"secondHandId": "s201709121234386",
//"secondHandTitle": "去",
//"zoneId": "0",
//"createTime": "2017-09-12 12:34:38",
//"y": 0,
//"x": 0,
//"address": "没有位置数据"
@interface SecondHandModel : NSObject


@property (nonatomic,copy)NSString *ownerId;
@property (nonatomic,strong)NSArray *commentList;
@property (nonatomic,strong)NSArray *keepList;
@property (nonatomic,copy)NSString *secPrice;
@property (nonatomic,copy)NSString *delivery;
@property (nonatomic,copy)NSString *classId;
@property (nonatomic,copy)NSString *old;
@property (nonatomic,copy)NSString *imageGroupId;
@property (nonatomic,copy)NSString *imageUrlList;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *postStatus;
@property (nonatomic,copy)NSString *delTime;
@property (nonatomic,copy)NSString *secondHandContent;
@property (nonatomic,copy)NSString *zoneName;
@property (nonatomic,copy)NSString *oriPrice;
@property (nonatomic,copy)NSString *ownerHuanxinId;
@property (nonatomic,copy)NSString *onwerName;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *secondHandId;
@property (nonatomic,copy)NSString *secondHandTitle;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *address;


//@property (nonatomic,copy)NSString *address;
//@property (nonatomic,copy)NSString *classId;
//@property (nonatomic,copy)NSString *commentCount;
//
//@property (nonatomic,strong)NSArray *commentList;
//
//@property (nonatomic,copy)NSString *createTime;
//@property (nonatomic,copy)NSString *delTime;
//
//@property (nonatomic,strong)NSArray *keepList;
//@property (nonatomic,copy)NSString *TnewOrOld;
//@property (nonatomic,copy)NSString *onwerName;
//@property (nonatomic,copy)NSString *oriPrice;
//@property (nonatomic,copy)NSString *ownerHuanxinId;
//@property (nonatomic,copy)NSString *ownerImageUrl;
//@property (nonatomic,copy)NSString *postStatus;
//@property (nonatomic,copy)NSString *secPrice;
//@property (nonatomic,copy)NSString *secondHandContent;
//@property (nonatomic,copy)NSString *secondHandId;
//
//
//@property (nonatomic,strong)NSArray *secondHandNormalImageList;
//@property (nonatomic,strong)NSArray *secondHandSmallImageList;
//
//@property (nonatomic,copy)NSString *secondHandTitle;
//@property (nonatomic,copy)NSString *y;
//@property (nonatomic,copy)NSString *x;
//@property (nonatomic,copy)NSString *zoneId;
//@property (nonatomic,copy)NSString *zoneName;

@end
