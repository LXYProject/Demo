//
//  SecondCommentModel.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondCommentModel.h"

@implementation SecondCommentModel

+(NSDictionary *)mj_objectClassInArray {
    return @{
             @"subCommentList":@"CommentUserModel"
             };
}
@end
