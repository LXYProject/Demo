//
//  MesssgeHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/23.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MesssgeHttpManager.h"
#import "MessageModel.h"    

@implementation MesssgeHttpManager

//加载
+ (void)requestFilter:(NSString *)filter
              topicId:(NSString *)topicId
                  pos:(NSString *)pos
                 page:(NSInteger)pageNum
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"filter":filter?filter:@"",
                               @"topicId":topicId?topicId:@"",
                               @"pos":pos?pos:@"",
                               @"page":@(pageNum),
                               @"pageCount":@(10),

                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_loadTopic paramter:paramter success:^(id response) {
        NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:response[@"topicList"]];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//点赞, 发帖记录, 删除帖子
+ (void)requestTypeInterface:(InterfaceType)interface
                     TopicId:(NSString *)topicId
                     success:(HttpRequestSuccess)success
                     failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"topicId":topicId?topicId:@"",
                               };
    NSString *url = nil;
    if (interface==Thumb_Up) {
        url = A_thumbsUp;
    }else if (interface==Posting_Record){
        url = A_topicHis;
    }else{
        url = A_deleteTopic;
    }
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:url paramter:paramter success:^(id response) {
        NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
    
}

//回复
+ (void)requestTopicId:(NSString *)topicId
               comment:(NSString *)comment
           commentType:(NSInteger )commentType
          targetUserId:(NSString *)targetUserId
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    NSDictionary *paramter = @{@"topicId":topicId?topicId:@"",
                               @"comment":comment?comment:@"",
                               @"commentType":@(commentType),
                               @"targetUserId":targetUserId?targetUserId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_reply paramter:paramter success:^(id response) {
        NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//删除回复
+ (void)requestDeleteTopicIdr:(NSString *)topicId
                    commentId:(NSString *)commentId
                      success:(HttpRequestSuccess)success
                      failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"topicId":topicId?topicId:@"",
                               @"commentId":commentId?commentId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_deleteReply paramter:paramter success:^(id response) {
        NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}
//发布
+ (void)requestContent:(NSString *)content
                photos:(NSString *)photos
                cityId:(NSString *)cityId
            districtId:(NSString *)districtId
               address:(NSString *)address
                 resId:(NSString *)resId
               resName:(NSString *)resName
               success:(HttpRequestSuccess)success
               failure:(HttpRequestFailure)failure{
    
    CGFloat x = 0.0;
    CGFloat y = 0.0;
    NSDictionary *paramter = @{@"content":content?content:@"",
                               @"photos":photos?photos:@"",
                               @"cityId":cityId?cityId:@"",
                               @"districtId":districtId?districtId:@"",
                               @"address":address?address:@"",
                               @"resId":resId?resId:@"",
                               @"resName":resName?resName:@"",
                               @"x":@(x),
                               @"y":@(y),
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_newTopic paramter:paramter success:^(id response) {
        NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}
@end
