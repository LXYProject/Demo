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

@interface SecondHandModel : NSObject


@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *classId;
@property (nonatomic,copy)NSString *commentCount;

@property (nonatomic,strong)NSArray *commentList;
@property (nonatomic,strong)NSArray *subCommentList;


@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *delTime;
//
@property (nonatomic,strong)NSArray *keepList;
@property (nonatomic,copy)NSString *TnewOrOld;
@property (nonatomic,copy)NSString *onwerName;
@property (nonatomic,copy)NSString *oriPrice;
@property (nonatomic,copy)NSString *ownerHuanxinId;
@property (nonatomic,copy)NSString *ownerImageUrl;
@property (nonatomic,copy)NSString *postStatus;
@property (nonatomic,copy)NSString *secPrice;
@property (nonatomic,copy)NSString *secondHandContent;
@property (nonatomic,copy)NSString *secondHandId;


@property (nonatomic,strong)NSArray *secondHandNormalImageList;
@property (nonatomic,strong)NSArray *secondHandSmallImageList;

@property (nonatomic,copy)NSString *secondHandTitle;
@property (nonatomic,copy)NSString *y;
@property (nonatomic,copy)NSString *x;
@property (nonatomic,copy)NSString *zoneId;
@property (nonatomic,copy)NSString *zoneName;


@end
