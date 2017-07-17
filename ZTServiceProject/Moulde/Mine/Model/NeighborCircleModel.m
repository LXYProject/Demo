//
//  NeighborCircleModel.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborCircleModel.h"

@implementation NeighborCircleModel
+(NSDictionary *)mj_objectClassInArray {
    return @{@"topicNormalImageList":@"MessagePhotoModel",
             @"topicSmallImageList":@"MessagePhotoModel",
             @"commentList":@"CommentUserModel",
             @"likeList":@"CommentUserModel"};
}
@end
