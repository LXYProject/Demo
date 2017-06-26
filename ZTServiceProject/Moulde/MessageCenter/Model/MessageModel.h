//
//  MessageModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/23.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>


//{
//    "code": 200,
//    "message": "",
//    "result": {
//        "topicList": [
//                      {

//"topicNormalImageList": [
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170622163540_01.jpg"
//                         },
//                         {
//                             "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170622163540_02.jpg"
//                         }
//                         ],
//"topicSmallImageList": [
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170622163540_01_small.jpg"
//                        },
//                        {
//                            "url": "http://192.168.1.96:8080/ZtscApp/file/topic/t20170622163540_02_small.jpg"
//                        }
//                        ],
//"topicId": "t20170622163540",
//"topicTitle": "二手物品求购\n我想购买的物品为：特斯拉\n我想要的品牌为：夏普\n我要求的新旧程度为：九成新\n我能接受的价位为：500以上\n另外我还要说的是：好玉女您了扣女\n标签要求：同城, 同意承担运费, 七天退货, 有发票, 未拆封, 外观无损",
//"createTime": "2017-06-22 16:35:40",
//"topicStatus": 1,
//"likeList": [],
//"zoneId": "1",
//"ownerId": "005600",
//"commentList": [],
//"ownerName": "其实我很帅",
//"ownerImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
//"zoneName": "1",
//"commentCount": 0,
//"delTime": "",
//"y": 0,
//"x": 0,
//"address": ""

@interface MessageModel : NSObject


@property (nonatomic,strong)NSArray *topicNormalImageList;
@property (nonatomic,strong)NSArray *topicSmallImageList;

@property (nonatomic,copy)NSString *topicId;
@property (nonatomic,copy)NSString *topicTitle;
@property (nonatomic,copy)NSString *topicStatus;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,strong)NSArray *likeList;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,strong)NSArray *commentList;
@property (nonatomic,copy)NSString *ownerName;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *zoneName;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *delTime;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *address;
@property (nonatomic ,assign) BOOL  isSupper;


@end
