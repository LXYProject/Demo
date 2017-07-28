//
//  HttpAPIManager.h
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpRequestSuccess)(id response);
typedef void(^HttpRequestFailure)(NSError *error,NSString *message);
typedef void(^HttpRequestProgress)(CGFloat progress);
typedef void(^HttpRequestCompletionBlock)(NSURLResponse *respose,NSURL *filePath);

@interface HttpAPIManager : NSObject
ZX_DECLARE_SINGLETON(HttpAPIManager);


/**
 post请求

 @param url 请求路径
 @param paramter 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)postWithUrl:(NSString *)url
           paramter:(id)paramter
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure;


/**
 get请求

 @param url 请求路径
 @param paramter 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)getWithUrl:(NSString *)url
          paramter:(id)paramter
           success:(HttpRequestSuccess)success
           failure:(HttpRequestFailure)failure;

- (void)getWithOneUrl:(NSString *)url
             paramter:(id)paramter
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;

- (void)getWithTwoUrl:(NSString *)url
             paramter:(id)paramter
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure;

/**
 单文件上传

 @param url 上传URL
 @param data 二进制
 @param type 文件类型
 @param name 名称
 @param mimeType 文件type
 @param paramter 参数
 @param progressBlock 进度的block
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)uploadDataWithUrl:(NSString *)url
                 fileData:(NSData *)data
                     type:(NSString *)type
                     name:(NSString *)name
                 mimeType:(NSString *)mimeType
                 paramter:(id)paramter
            progressBlock:(HttpRequestProgress)progressBlock
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure;


//多文件上传
- (void)uploadDataArrayWithUrl:(NSString *)url
                      fileData:(NSArray *)data
                          type:(NSString *)type
                          name:(NSString *)name
                      mimeType:(NSString *)mimeType
                      paramter:(id)paramter
                 progressBlock:(HttpRequestProgress)progressBlock
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure;


//下载
- (void)downloadDataWithUrl:(NSString *)url
                   savePath:(NSString *)savePath
                  paramater:(id)paramter
              progressBlock:(HttpRequestProgress)progressBlock
                    success:(HttpRequestCompletionBlock)success
                    failure:(HttpRequestFailure)failure;


/**
 取消所有网络请求
 */
- (void)cancelAllRequest;

@end
