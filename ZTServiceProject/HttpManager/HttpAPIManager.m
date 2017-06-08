//
//  HttpAPIManager.m
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HttpAPIManager.h"
#import "YYRequest.h"
@implementation HttpAPIManager
ZX_IMPLEMENT_SINGLETON(HttpAPIManager);
- (void)postWithUrl:(NSString *)url
           paramter:(id)paramter
            success:(HttpRequestSuccess)success
            failure:(HttpRequestFailure)failure {
    
    [YYRequest requestPostWithURLString:[self dealWithURL:url] paramater:[self dealWithParamter:paramter] success:^(YYNetWorkSuccess *successful) {
        NSLog(@"请求返回的值：%@",successful.responseObject);
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        NSLog(@"请求错误信息：%@",failured.error);
         failure(failured.error,nil);
    } progress:nil];
}

- (void)getWithUrl:(NSString *)url
          paramter:(id)paramter
           success:(HttpRequestSuccess)success
           failure:(HttpRequestFailure)failure {
    [YYRequest requestGETtWithURLString:[self dealWithURL:url] paramater:[self dealWithParamter:paramter] success:^(YYNetWorkSuccess *successful) {
        if ([successful.responseObject[@"code"] integerValue]==200) {
            success(successful.responseObject[@"result"]);
        }
        else {
            failure(nil,successful.responseObject[@"message"]);
        }
    } failure:^(YYNetWorkFailure *failured) {
        failure(failured.error,nil);
    } progress:nil];
}

- (void)uploadDataWithUrl:(NSString *)url
                 fileData:(NSData *)data
                     type:(NSString *)type
                     name:(NSString *)name
                 mimeType:(NSString *)mimeType
                 paramter:(id)paramter
            progressBlock:(HttpRequestProgress)progressBlock
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure {
    [YYRequest uploadFileWithUrl:[self dealWithURL:url] fileData:data type:type name:name mimeType:mimeType paramter:[self dealWithParamter:paramter] progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    } success:^(YYNetWorkSuccess *successful) {
        success(successful.responseObject);
    } failure:^(YYNetWorkFailure *failured) {
        failure(failured.error,nil);
    }];
    
}

- (void)uploadDataArrayWithUrl:(NSString *)url
                      fileData:(NSArray *)data
                          type:(NSString *)type
                          name:(NSString *)name
                      mimeType:(NSString *)mimeType
                      paramter:(id)paramter
                 progressBlock:(HttpRequestProgress)progressBlock
                       success:(HttpRequestSuccess)success
                       failure:(HttpRequestFailure)failure {
    [YYRequest uploadFilesWithUrl:[self dealWithURL:url] fileDatas:data type:type name:name mimeType:mimeType paramter:[self dealWithParamter:paramter] progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    } success:^(YYNetWorkSuccess *successful) {
        success(successful.responseObject);
    } failure:^(YYNetWorkFailure *failured) {
        failure(failured.error,nil);
    }];
}

- (void)downloadDataWithUrl:(NSString *)url
                   savePath:(NSString *)savePath
                  paramater:(id)paramter
              progressBlock:(HttpRequestProgress)progressBlock
                    success:(HttpRequestCompletionBlock)success
                    failure:(HttpRequestFailure)failure {
    [YYRequest requestDownloadFileWithURLString:[self dealWithURL:url] savePath:savePath paramater:[self dealWithParamter:paramter] success:^(NSURLResponse *respose, NSURL *filePath, NSError *error) {
        if (error){
            failure(error,@"");
        }
        else {
            success(respose,filePath);
        }
    } progress:^(int64_t bytesRead, int64_t totalBytes) {
        progressBlock((CGFloat)bytesRead/totalBytes);
    }];
}


//预留接口方便参数加密
- (id)dealWithParamter:(id)paramter{
    NSMutableDictionary *newParamter = [[NSMutableDictionary alloc]init];
    if ([paramter isKindOfClass:[NSArray class]]) {
    
    }
    else if ([paramter isKindOfClass:[NSDictionary class]]) {
        [newParamter setValuesForKeysWithDictionary:paramter];
        [newParamter setValue:@"1" forKey:@"token"];
        [newParamter setValue:@"1" forKey:@"userId"];
    }
    else {
    
    }
    NSLog(@"请求的参数：%@",paramter);
    return paramter;
}

//为了URL管理
- (NSString *)dealWithURL:(NSString *)urlString {
    NSLog(@"请求路径：%@",MRRemote(urlString));
    return MRRemote(urlString);
}


@end