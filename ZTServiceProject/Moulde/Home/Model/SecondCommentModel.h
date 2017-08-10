//
//  SecondCommentModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>



//commentList =             (
//                           {
//                               comment = "\U53d6\U5149\U5f88\U597d";
//                               commentCount = 0;
//                               commentId = sr20170707174507;
//                               commentTime = "2017-07-07 17:45:07";
//                               isLiked = 0;
//                               likeCount = 0;
//                               subCommentList =                     (
//                               );
//                               userId = 20170705105157;
//                               userImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//                               userName = sa13836243832;
//                           },
//                           {
//                               comment = "\U54c8\U54c8\U54c8\U54c8";
//                               commentCount = 0;
//                               commentId = sr20170707174102;
//                               commentTime = "2017-07-07 17:41:02";
//                               isLiked = 0;
//                               likeCount = 0;
//                               subCommentList =                     (
//                               );
//                               userId = 20170705105157;
//                               userImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//                               userName = sa13836243832;
//                           },
//                           {
//                               comment = "\U5f88\U597d\Uff01";
//                               commentCount = 2;
//                               commentId = sr20170705172045;
//                               commentTime = "2017-07-05 17:20:45";
//                               isLiked = 0;
//                               likeCount = 1;
//                               subCommentList =                     (
//                                                                     {
//                                                                         comment = "\U5927\U5bb6\U597d\Uff0c\U624d\U662f\U771f\U7684\U597d\Uff01";
//                                                                         commentId = scr20170705172115;
//                                                                         commentTime = "2017-07-05 17:21:15";
//                                                                         commentType = 0;
//                                                                         targetComment = "";
//                                                                         targetCommentId = "";
//                                                                         targetUserId = "";
//                                                                         targetUserImageUrl = "";
//                                                                         targetUserName = "";
//                                                                         userId = 20170705105157;
//                                                                         userImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//                                                                         userName = sa13836243832;
//                                                                     },
//                                                                     {
//                                                                         comment = "\U82f9\U679c";
//                                                                         commentId = scr20170707172704;
//                                                                         commentTime = "2017-07-07 17:27:04";
//                                                                         commentType = 0;
//                                                                         targetComment = "";
//                                                                         targetCommentId = "";
//                                                                         targetUserId = "";
//                                                                         targetUserImageUrl = "";
//                                                                         targetUserName = "";
//                                                                         userId = 20170705105157;
//                                                                         userImageUrl = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//                                                                         userName = sa13836243832;
//                                                                     }
//                                                                     );


@interface SecondCommentModel : NSObject

@property (nonatomic,copy)NSString *comment;
@property (nonatomic,copy)NSString *commentCount;
@property (nonatomic,copy)NSString *commentId;
@property (nonatomic,copy)NSString *commentTime;
@property (nonatomic,copy)NSString *isLiked;
@property (nonatomic,copy)NSString *likeCount;
@property (nonatomic,strong)NSArray *subCommentList;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userImageUrl;
@property (nonatomic,copy)NSString *userName;

@end
