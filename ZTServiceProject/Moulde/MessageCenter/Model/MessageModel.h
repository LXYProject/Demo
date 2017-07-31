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

//"createTime": "2017-07-06 09:35:00",
//"ownerImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1833082163320170322110130-20170719175920.png",
//"ownerName": "许许阳阳",
//"zoneName": "1",
//"commentCount": 9,
//"delTime": "",
//"ownerId": "1833082163320170322110130",
//"commentList": [
//                {
//                    "commentType": 1,
//                    "targetUserId": "1833082163320170322110130",
//                    "userId": "1833082163320170322110130",
//                    "commentId": "tr20170707141538",
//                    "userImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1833082163320170322110130-20170719175920.png",
//                    "targetUserName": "许许阳阳",
//                    "targetUserImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1833082163320170322110130-20170719175920.png",
//                    "commentTime": "2017-07-07 14:15:38",
//                    "comment": "是啊",
//                    "userName": "许许阳阳"
//                },
//============================================================
//
//## 我的邻里圈-我发表的帖子 ##
//
//根据用户ID返回当前用户发布的帖子，也可以再加上小区的过滤条件
//#### 获取邻里圈小区帖子-filter（可以为空，不填默认返回全部） ####
//
//
//
//> 请求参数
//
//|Parameter	|Tpye	|Description|备注|
//|-----------|----------|------|-----|
//| userId 		| String| 用户Id ||
//| token 		| String| 令牌 ||
//| topicId 		| String| 帖子Id|若为空，则代表取最新的，翻页时取上次最后一个topicId|
//
//
//
//* 示例
//
//{
//    "userId": 200,
//    "token": "成功",
//    "topicId":"t0sssss"
//}
//
//
//##### 返回值 #####
//
//
//|Parameter	|Tpye	|Description|备注|
//|-----------|----------|------|-----|
//| code 		| int| 状态码 ||
//| message | String| 状态说明||
//| result  | String |结果集||
//| ownerId 		| String| 发帖人的ID||
//| ownerName 		| String| 发帖人的名称||
//| ownerImageUrl 		| String| 发帖人的图像||
//| topicId | String | 帖子Id||
//| topicTitle 		| String| 话题|支持长文本|
//| topicImageList 		| 对象| 话题相关的图片|支持多图|
//| type 		| String| 图片后缀||
//| base64 		| String| 图片内容的BASE64编码||
//| createTime 		| String| 创建时间||
//| x 		| double| 经度||
//| y 		| double| 纬度||
//| zoneId 		| String| 小区Id||
//| zoneName 		| String| 小区名称||
//| address 		| String| 地址|完整的地址描述|
//| likeList 		| 数组| 点赞|点赞信息|
//| commentCount 		| int| 评论数量||
//| commentList 		| 数组| 地址|最新的3条评论|
//| commentType 		| int| 地址|0-话题评论；1-回复评论|
//| comment 		| String| 评论内容||
//| commentTime 		| String| 评论时间||
//| userId 		| String| 评论发起人的ID||
//| userName 		| String| 评论发起人的名称||
//| userImageUrl 		| String| 评论发起人的图像||
//| targetUserId 		| String| 评论目标的ID|若commentType==0，这个段为空，否则代表回复对象的ID|
//| targetUserName 		| String| 评论目标的名称|若commentType==0，这个段为空，否则代表回复对象的ID|
//| targetUserImageUrl 		| String| 评论目标的图像|若commentType==0，这个段为空，否则代表回复对象的ID|
//
//
//
//
//* 测试：url：
//* 生产：url：
//* 示例
//
//{
//    "code": 200,
//    "message": "成功",
//    "result": {"topicList":[
//                            {	"ownerId":"",
//                                "ownerName":"",
//                                "ownerImageUrl":"" ,
//                                "topicId": "我要发表一个感想",
//                                "topicTitle": "我要发表一个感想",
//                                "topicSmallImageList":  [
//                                                         {	"url": ""},
//                                                         {	"url": ""}],
//                                "topicNormalImageList":  [
//                                                          {	"url": ""},
//                                                          {	"url": ""}],
//                                "createTime": "2002-03-23 20:32:22",
//                                "x": 123.44,
//                                "y": 123.44,
//                                "zoneId": "123.44",
//                                "zoneName": "123.44",
//                                "address": "123.44"	,
//                                "likeList":[
//                                            {	"userId:"",
//                                                "userName":"",
//                                                "userImageUrl":""},
//                                            {	"userId":"",
//                                                "userName":"",
//                                                "userImageUrl":""}],
//                                "commentCount:4
//                                "commentList":[
//                                               {	"commentType":""
//                                                   "userId":"",
//                                                   "userName":"",
//                                                   "userImageUrl":""
//                                                   "targetUserId":"",
//                                                   "targetUserName":"",
//                                                   "targetUserImageUrl":""
//                                                   "comment":"",
//                                                   "commentTime":"2010-04-09 20:23:21"}],
//                                
//                                
//                                
//                                ]}
//                            }
//                            

                            //====================点赞===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "upId": "tup20170623143722",
                            //        "information": "点赞成功",
                            //        "type": "0",
                            //        "status": "0"
                            //    }
                            //}
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "information": "取消点赞成功",
                            //        "type": "1",
                            //        "status": "0"
                            //    }
                            //}
                            //====================回复===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "replyId": "tr20170623151114",
                            //        "information": "回复成功",
                            //        "status": "0"
                            //    }
                            //}
                            //====================发布===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "information": "内容和照片同时为空",
                            //        "status": "1"
                            //    }
                            //}
//        {
//            "code": 200,
//            "message": "",
//            "result": {
//                "topicId": "t20170623180213",
//                "information": "发布成功",
//                "status": "0"
//            }
//        }
                            //====================发帖纪录===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "topicList": []
                            //    }
                            //}
                            //====================删除回复===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {}
                            //}
                            //====================删除帖子===========================================
                            //{
                            //    "code": 200,
                            //    "message": "",
                            //    "result": {
                            //        "information": "获取该用户发帖记录列表失败",
                            //        "status": "1"
                            //    }
                            //}

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
@property (nonatomic,copy)NSString *ownerId;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *zoneName;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *delTime;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *address;
@property (nonatomic ,assign) BOOL  isSupper;


@end
