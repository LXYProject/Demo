//
//  MessageModel.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/23.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
+(NSDictionary *)mj_objectClassInArray {
    return @{@"topicNormalImageList":@"MessagePhotoModel",
             @"topicSmallImageList":@"MessagePhotoModel",
             @"commentList":@"CommentUserModel",
             @"likeList":@"CommentUserModel"};
}
@end
