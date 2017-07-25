//
//  CommentUserModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"commentType": 1,
//"targetUserId": "1833082163320170322110130",
//"userId": "1833082163320170322110130",
//"commentId": "tr20170707141538",
//"userImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1833082163320170322110130-20170719175920.png",
//"targetUserName": "许许阳阳",
//"targetUserImageUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/1833082163320170322110130-20170719175920.png",
//"commentTime": "2017-07-07 14:15:38",
//"comment": "是啊",
//"userName": "许许阳阳"


@interface CommentUserModel : NSObject
@property (nonatomic,copy)NSString *commentType;
@property (nonatomic,copy)NSString *targetUserId;
@property (nonatomic,copy)NSString *commentId;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userImageUrl;
@property (nonatomic,copy)NSString *targetUserName;
@property (nonatomic,copy)NSString *targetUserImageUrl;
@property (nonatomic,copy)NSString *comment;
@property (nonatomic,copy)NSString *commentTime;
@end
