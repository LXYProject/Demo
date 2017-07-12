//
//  NeighborCircleModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//====================================发帖纪录========================
//"topicList": [
//              {

//"topicSmallImageList": [],
//"ownerId": "20170607093552",
//"commentList": [],
//"ownerName": "李小艳",
//"ownerImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg",
//"zoneName": "",
//"commentCount": 0,
//"delTime": "",
//"topicId": "t20170623180213",
//"topicTitle": "1",
//"createTime": "2017-06-23 18:02:13",
//"topicStatus": 1,
//"likeList": [
//             {
//                 "likeId": "tup20170628180735",
//                 "userImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
//                 "userId": "1890918872220170322150921",
//                 "userName": "王磊"
//             }
//             ],
//"topicNormalImageList": [],
//"zoneId": "",
//"y": 0,
//"x": 0,
//"address": ""

//"topicSmallImageList": [
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_01_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_02_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_03_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_04_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_05_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_06_small.jpg"
//                        }
//                        ],
//"ownerId": "1362111422120170322120834",
//"commentList": [],
//"ownerName": "周本成2",
//"ownerImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1362111422120170322120834-20170417132509.png",
//"zoneName": "海淀区",
//"commentCount": 0,
//"delTime": "",
//"topicId": "t20170614151140",
//"topicTitle": "二手物品发布啦\n有图么\n索尼爱立信\n牛说几句5艘姑姑up马上\n原价5000,现价只要2000\n需要的人联系我！",
//"createTime": "2017-06-14 15:11:40",
//"topicStatus": 1,
//"likeList": [],
//"topicNormalImageList": [
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_01.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_02.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_03.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_04.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_05.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170614151140_06.jpg"
//                         }
//                         ],
//"zoneId": "110108",
//"y": 39.98807167,
//"x": 116.3334406,
//"address": "北京市;;海淀区;中关村东路;"
@interface NeighborCircleModel : NSObject

@property (nonatomic,strong)NSArray *topicSmallImageList;
@property (nonatomic,copy)NSString *ownerId;
@property (nonatomic,strong)NSArray *commentList;
@property (nonatomic,copy)NSString *ownerName;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *zoneName;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *delTime;
@property (nonatomic,copy)NSString *topicId;
@property (nonatomic,copy)NSString *topicTitle;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *topicStatus;
@property (nonatomic,copy)NSString *serviceTitle;

@property (nonatomic,strong)NSArray *likeList;
@property (nonatomic,copy)NSString *likeId;
@property (nonatomic,copy)NSString *userImageUrl;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;

@property (nonatomic,strong)NSArray *topicNormalImageList;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *address;

@end
