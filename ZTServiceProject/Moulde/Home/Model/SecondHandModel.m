//
//  SecondHandModel.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHandModel.h"

@implementation SecondHandModel
+(NSDictionary *)mj_objectClassInArray {
    return @{@"secondHandNormalImageList":@"MessagePhotoModel",
             @"commentList":@"SecondCommentModel",
             @"secondHandSmallImageList":@"MessagePhotoModel"};
}
@end
