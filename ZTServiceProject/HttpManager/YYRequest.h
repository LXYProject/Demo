//
//  YYRequest.h
//  YYNetWork
//
//  Created by zhngyy on 17/4/5.
//  Copyright © 2017年 zhangyy. All rights reserved.
//



/**********这个文件整体是单独存在的不需要依赖任何其他文件,只需要发起最基本的网络请求*************/

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//成功的网络请求集合
@interface YYNetWorkSuccess : NSObject
//状态码
@property (nonatomic,assign)NSInteger stateCode;
//返回值
@property (nonatomic,strong)id responseObject;
//全路径（下载的时候才用到）
@property (nonatomic,strong)NSURL *filePath;
//请求任务
@property (nonatomic,strong)NSURLSessionDataTask *task;

@end
//失败的网络请求集合
@interface YYNetWorkFailure : NSObject
//失败的error
@property (nonatomic,strong)NSError *error;
//请求任务
@property (nonatomic,strong)NSURLSessionDataTask *task;
@end

//成功回调
typedef void(^YYSuccess)(YYNetWorkSuccess *success);
//失败回调
typedef void(^YYFailure)(YYNetWorkFailure *failure);
//进度回调
typedef void(^YYProgress)(int64_t bytesRead,int64_t totalBytes);
//下载文件完成的回调
typedef void(^YYDownloadCompletionBlock)(NSURLResponse *respose,NSURL *filePath,NSError *error);
/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, YYNetworkStatus) {
    /**< 未知网络 */
    YYNetworkStatusUnknown             = 1 << 0,
    /**< 无法连接 */
    YYNetworkStatusNotReachable        = 1 << 1,
    /**< WWAN网络 */
    YYNetworkStatusReachableViaWWAN    = 1 << 2,
    /**< WiFi网络 */
    YYNetworkStatusReachableViaWiFi    = 1 << 3
};



@interface YYRequest : NSObject

/**
 网络监听
 */
+ (void)checkNetworkStatus;


/**
 当前网络的状态

 @return 返回当前网络的状态标示
 */
+ (YYNetworkStatus)currentNetworkStatus;

/**
 *  配置请求头
 *
 *  @param httpHeader 请求头
 */
+ (void)configHttpHeader:(NSDictionary *)httpHeader;

/**
 *  获取请求头
 *
 *  @return httpHeader 请求头
 */
+ (NSDictionary *)requestHeader;

/**
 *  取消所有请求
 */
+ (void)cancleAllRequest;

/**
 *  取消指定url的所有
 */
+ (void)cancelAllRequestWithURL:(NSString *)url;

/**
 *  取消单个请求
 */
+ (void)cancelOneRequestWithURL:(NSString *)url;

/**
 *  正在运行的网络任务
 *
 *  @return 运行的任务数组
 */
+ (NSArray *)currentRunningTasks;

/**
 *	设置超时时间
 *
 *  @param timeout 超时时间
 */
+ (void)setupTimeout:(NSTimeInterval)timeout;

/**
 Post请求

 @param urlString 请求路径
 @param paramter 参数
 @param success 成功回调
 @param failure 失败回调
 @param progress 进度回调
 @return 返回的任务请求
 */
+ (NSURLSessionDataTask *)requestPostWithURLString:(NSString *)urlString
                                         paramater:(id)paramter
                                           success:(YYSuccess)success
                                           failure:(YYFailure)failure
                                          progress:(YYProgress)progress;


/**
 GET请求

 @param urlString 请求路径
 @param paramter 请求参数
 @param success 成功回调
 @param failure 失败回调
 @param progress 请求进度
 @return 返回的请求任务
 */
+ (NSURLSessionDataTask *)requestGETtWithURLString:(NSString *)urlString
                                         paramater:(id)paramter
                                           success:(YYSuccess)success
                                           failure:(YYFailure)failure
                                          progress:(YYProgress)progress;


/**
 单个文件上传的请求

 @param url 请求路径
 @param data 上传的数据
 @param type 类型
 @param name 名字
 @param mimeType 文件的类型
 @param paramter 参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 返回请求任务
 */
+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url
                                   fileData:(NSData *)data
                                       type:(NSString *)type
                                       name:(NSString *)name
                                   mimeType:(NSString *)mimeType
                                   paramter:(id)paramter
                                   progress:(YYProgress)progress
                                    success:(YYSuccess)success
                                    failure:(YYFailure)failure;


/**
 多个文件上传，这里是控制了上传顺序是什么，返回的顺序就是什么

 @param url 请求路径
 @param datas 上传的数据数组
 @param type 类型
 @param name 名称
 @param mimeType 文件类型
 @param paramter 参数
 @param progress 进度
 @param success 成功回调
 @param failure 失败回调
 @return 返回请求任务
 */
+ (NSArray<NSURLSessionDataTask *> *)uploadFilesWithUrl:(NSString *)url
                                              fileDatas:(NSArray *)datas
                                                   type:(NSString *)type
                                                   name:(NSString *)name
                                               mimeType:(NSString *)mimeType
                                               paramter:(id)paramter
                                               progress:(YYProgress)progress
                                                success:(YYSuccess)success
                                                failure:(YYFailure)failure;

/**
 文件下载

 @param urlString 下载路径
 @param paramter 参数
 @param success 成功回调
 @param savePath 保存路径
 @param progress 下载进度
 @return 返回任务请求
 */
+ (NSURLSessionDataTask *)requestDownloadFileWithURLString:(NSString *)urlString
                                                  savePath:(NSString *)savePath
                                                 paramater:(id)paramter
                                                   success:(YYDownloadCompletionBlock)success
                                                  progress:(YYProgress)progress;




@end
