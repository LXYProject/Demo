//
//  MesssgeHttpManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/23.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Thumb_Up,      //点赞
    Posting_Record,//发帖纪录
    Delete_Posts   //删除帖子
} InterfaceType;

@interface MesssgeHttpManager : NSObject

// 加载
+ (void)requestFilter:(NSString *)filter
              topicId:(NSString *)topicId
                  pos:(NSString *)pos
                 page:(NSInteger)pageNum
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;

//点赞, 发帖记录, 删除帖子
+ (void)requestTypeInterface:(InterfaceType)interface
                     TopicId:(NSString *)topicId
                     success:(HttpRequestSuccess)success
                     failure:(HttpRequestFailure)failure;

//回复
+ (void)requestTopicId:(NSString *)topicId
               comment:(NSString *)comment
           commentType:(NSString *)commentType
          targetUserId:(NSString *)targetUserId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;


//删除回复
+ (void)requestDeleteTopicIdr:(NSString *)topicId
                    commentId:(NSString *)commentId
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure;

//发布
+ (void)requestContent:(NSString *)content
                photos:(NSString *)photos
                cityId:(NSString *)cityId
            districtId:(NSString *)districtId
               address:(NSString *)address
                 resId:(NSString *)resId
               resName:(NSString *)resName
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure;



@end

