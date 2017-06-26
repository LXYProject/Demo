//
//  CommentUserModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentUserModel : NSObject
@property (nonatomic,copy)NSString *commentType;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userImageUrl;
@property (nonatomic,copy)NSString *targetUserId;
@property (nonatomic,copy)NSString *targetUserName;
@property (nonatomic,copy)NSString *targetUserImageUrl;
@property (nonatomic,copy)NSString *comment;
@property (nonatomic,copy)NSString *commentTime;
@end
