//
//  YYRequest.m
//  YYNetWork
//
//  Created by zhngyy on 17/4/5.
//  Copyright © 2017年 zhangyy. All rights reserved.
//

#import "YYRequest.h"
static NSTimeInterval requestTimeout = 30.0f;
//网络请求管理
static AFHTTPSessionManager *manager = nil;
//网络状态
static YYNetworkStatus networkStatus;
//请求头字典
static NSDictionary     *headers;
//创建一个缓存池
static NSMutableArray* requestTasksPool = nil;
//超时时间

@implementation YYNetWorkFailure



@end

@implementation YYNetWorkSuccess



@end

@implementation YYRequest
#pragma mark - 实例化AFHTTPSessionManager管理类
+ (AFHTTPSessionManager *)manager{
    if(!manager){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [AFHTTPSessionManager manager];
            // 导入证书
            NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
            NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
            NSSet *certSet = [NSSet setWithObject:certData];
            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:certSet];
            // 是否允许无效的证书 默认为NO
            securityPolicy.allowInvalidCertificates = YES;
            // 是否验证证书所属域名 默认为YES
            securityPolicy.validatesDomainName = NO;
            
            manager.securityPolicy = securityPolicy;
            
            //默认解析模式
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            manager.requestSerializer.timeoutInterval = requestTimeout;
            //配置请求序列化
            AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
            [serializer setRemovesKeysWithNullValues:YES];
            manager.responseSerializer = serializer;
            
            //配置响应序列化
            NSSet *contentTypes = [NSSet setWithArray:@[@"application/json",
                                                        @"text/html",
                                                        @"text/json",
                                                        @"text/plain",
                                                        @"text/javascript",
                                                        @"text/xml",
                                                        @"image/*",
                                                        @"application/octet-stream",
                                                        @"application/zip"]];
            
            manager.responseSerializer.acceptableContentTypes = contentTypes;
        });
    }
    
    return manager;
}

#pragma mark - 监听网络状态
+ (void)checkNetworkStatus {
    //创建网络监听管理者对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
   __block AFNetworkReachabilityStatus currentStatus;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        currentStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                networkStatus = YYNetworkStatusUnknown;
                NSLog(@"未识别的网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{
                networkStatus = YYNetworkStatusNotReachable;
                NSLog(@"不可达的网络(未连接)");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                networkStatus = YYNetworkStatusReachableViaWWAN;
                NSLog(@"2G,3G,4G...的网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                networkStatus = YYNetworkStatusReachableViaWiFi;
                NSLog(@"wifi的网络");
                break;
            }
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}

#pragma mark - 返回当前的网络状态
+ (YYNetworkStatus)currentNetworkStatus {
    return networkStatus;
}


#pragma mark - Post请求
+ (NSURLSessionDataTask *)requestPostWithURLString:(NSString *)urlString
                                         paramater:(id)paramter
                                           success:(YYSuccess)success
                                           failure:(YYFailure)failure
                                          progress:(YYProgress)progress{
    __block NSURLSessionDataTask *session = nil;
    session = [manager POST:urlString parameters:paramter progress:^(NSProgress * _Nonnull uploadProgress) {
        if(uploadProgress) {
            progress (uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YYNetWorkSuccess *sucessful = [[YYNetWorkSuccess alloc]init];
        sucessful.task = task;
        sucessful.responseObject = responseObject;
        success(sucessful);
        if ([[self allTasks] containsObject:session]) {
            [[self allTasks] removeObject:session];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YYNetWorkFailure *failureful = [[YYNetWorkFailure alloc]init];
        failureful.task = task;
        failureful.error = error;
        [[self allTasks] removeObject:session];
    }];
    if(session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - GET请求
+ (NSURLSessionDataTask *)requestGETtWithURLString:(NSString *)urlString
                                         paramater:(id)paramter
                                           success:(YYSuccess)success
                                           failure:(YYFailure)failure
                                          progress:(YYProgress)progress {
    __block NSURLSessionDataTask *session = nil;
    session = [manager GET:urlString parameters:paramter progress:^(NSProgress * _Nonnull downloadProgress) {
        if(downloadProgress) {
            progress (downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YYNetWorkSuccess *sucessful = [[YYNetWorkSuccess alloc]init];
        sucessful.task = task;
        sucessful.responseObject = responseObject;
        success(sucessful);
        if ([[self allTasks] containsObject:session]) {
            [[self allTasks] removeObject:session];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YYNetWorkFailure *failureful = [[YYNetWorkFailure alloc]init];
        failureful.task = task;
        failureful.error = error;
        [[self allTasks] removeObject:session];
    }];
    if(session) {
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - 单文件上传
+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url
                                   fileData:(NSData *)data
                                       type:(NSString *)type
                                       name:(NSString *)name
                                   mimeType:(NSString *)mimeType
                                   paramter:(id)paramter
                                   progress:(YYProgress)progress
                                    success:(YYSuccess)success
                                    failure:(YYFailure)failure {
    __block NSURLSessionDataTask *session = nil;
    session = [manager POST:url parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = nil;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *day = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@.%@",day,type];
        [formData appendPartWithFileData:data
                                    name:name
                                fileName:fileName
                                mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        YYNetWorkSuccess *sucessful = [[YYNetWorkSuccess alloc]init];
        sucessful.task = task;
        sucessful.responseObject = responseObject;
        success(sucessful);
        if ([[self allTasks] containsObject:session]) {
            [[self allTasks] removeObject:session];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YYNetWorkFailure *failureful = [[YYNetWorkFailure alloc]init];
        failureful.task = task;
        failureful.error = error;
        [[self allTasks] removeObject:session];
    }];
    [session resume];
    if (session) {  //加入缓存池
        [[self allTasks] addObject:session];
    }
    return session;
    
}

#pragma mark - 多文件上传
+ (NSArray<NSURLSessionDataTask *> *)uploadFilesWithUrl:(NSString *)url
                                              fileDatas:(NSArray *)datas
                                                   type:(NSString *)type
                                                   name:(NSString *)name
                                               mimeType:(NSString *)mimeType
                                               paramter:(id)paramter
                                               progress:(YYProgress)progress
                                                success:(YYSuccess)success
                                                failure:(YYFailure)failure {
    __block NSMutableArray *sessions = [NSMutableArray array];
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    //创建一个队列组
    dispatch_group_t uploadGroup = dispatch_group_create();
    for (int i =0;i<datas.count;i++) {
        __block NSURLSessionDataTask *session = nil;
        session = [self uploadFileWithUrl:url fileData:datas[i] type:type name:name mimeType:mimeType paramter:paramter progress:^(int64_t bytesRead, int64_t totalBytes) {
            if (progress) {
                progress(bytesRead,totalBytes);
            }
        } success:^(YYNetWorkSuccess *success) {
            [responses addObject:success.responseObject];
            dispatch_group_leave(uploadGroup);
            [sessions removeObject:session];
        } failure:^(YYNetWorkFailure *failure) {
            NSError *Error = [NSError errorWithDomain:url code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i],@"index":@(i)}];
            [failResponse addObject:Error];
            dispatch_group_leave(uploadGroup);
            [sessions removeObject:session];
        }];
        [session resume];
        if (session) {
            [sessions addObject:session];
        }
    }
    [[self allTasks] addObjectsFromArray:sessions];
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            if (success) {
                success([responses copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
        if (failResponse.count > 0) {
            if (failure) {
                failure([failResponse copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
    });
    return [sessions copy];
}

#pragma mark - 文件下载请求
+ (NSURLSessionDataTask *)requestDownloadFileWithURLString:(NSString *)urlString
                                                 paramater:(id)paramter
                                                   success:(YYDownloadCompletionBlock)success
                                                  progress:(YYProgress)progress{
    if(!urlString){
        return nil;
    }
    __block NSURLSessionDataTask *session = nil;
    NSURL *downloadUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadUrl];
    [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if(downloadProgress){
            progress(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"targetPath:%@",targetPath);
        NSLog(@"fullPath:%@",fullPath);
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        success(response,filePath,error);
         [[self allTasks] removeObject:session];
    }];
    [session resume];
    if (session) {  //加入缓存池
        [[self allTasks] addObject:session];
    }
    return session;
}

#pragma mark - 创建一个全局静态区的session缓存池
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasksPool == nil) requestTasksPool = [NSMutableArray array];
    });
    return requestTasksPool;
}
#pragma mark - 当前运行的请求任务
+ (NSArray *)currentRunningTasks {
    return [[self allTasks] copy];
}

#pragma mark - 请求头
+ (NSDictionary *)requestHeader{
    return headers;
}

#pragma mark - 配置请求头
+ (void)configHttpHeader:(NSDictionary *)httpHeader {
    headers = httpHeader;
}

#pragma mark - 取消指定的某个URL的响应。
+ (void)cancelOneRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionDataTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}

#pragma mark - 请求全部的指定的URL响应
+ (void)cancelAllRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionDataTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                }
            }
        }];
    }
}

#pragma mark - 取消所有请求
+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionDataTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

#pragma mark - 设置超时时间
+ (void)setupTimeout:(NSTimeInterval)timeout {
    requestTimeout = timeout;
}
@end
