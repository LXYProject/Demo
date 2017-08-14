//
//  PaymentHistoryController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PaymentHistoryController.h"

@interface PaymentHistoryController ()
@property (nonatomic, strong) NSArray *imgArray;
@end

@implementation PaymentHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"缴费历史" titleColor:[UIColor whiteColor]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self testUp];
}
- (void)testUp{
    
    UIImage *image = [UIImage imageNamed:@"wd_fwdd"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    
    
    AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]init];
    
    NSDictionary *paramter = @{@"a":@"1", @"b":@"2"};
    
//    NSDictionary *paramter = @{@"userId":@"1362111422120170322120834",
//                               @"content":@"测试",
//                               @"photos":@"20170811150802",
//                               @"cityId":@"",
//                               @"districtId":@"",
//                               @"address":@"",
//                               @"resId":@"",
//                               @"resName":@"",
//                               @"x":@"",
//                               @"y":@"",
//                               };
    
    
    //NSString *url1 = @"http://192.168.1.96:8080/ZtscApp/Service?service=file&function=upload";
    
    NSString *url2 = @"http://192.168.1.96:8080/ZtscApp/Service?service=topic&function=newTopic";
    
    [manager POST:url2
             parameters:paramter
            constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
                
                [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
    
                NSString*size=@"1000";
                
                NSData *data = [size dataUsingEncoding:NSUTF8StringEncoding];
                
                
                [formData appendPartWithFormData:data name:@"size"];
            
            
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                //显示进度
            }success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                
                //显示返回对象
                NSLog(@"-------->%@",responseObject);
            
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //显示错误信息
                NSLog(@"-------->%@",error);
            
            }];

}


- (void)textAPP{
    
    NSDictionary *pareames;
    
    NSString *url;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:pareames constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        
        for (id value in self.imgArray) {
            
                        if ([value isKindOfClass:[NSData class]]) {//判断是否是二进制数据
            [formData appendPartWithFileData:value name:@"img"fileName:@"123.jpg"mimeType:@"image/png/jpg/jpeg"];
            }else if ([value isKindOfClass:[UIImage class]]){//如果不是二进制数据进行转换
               // NSData *data = [self scaleImgWithImage:value Width:1080 DataBytes:200];//这个方法是自己写的压缩图片并转换
                NSData *data;
            [formData appendPartWithFileData:data name:@"img"fileName:@"123.jpg"mimeType:@"image/png/jpg/jpeg"];
            }
        }
        
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
//        CGFloat progres = (CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount;//这里是返回的上传图片进度,一定要用CGFloat进行接收
//        if (progress) {
//            progress(progres);
//        }
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
//        @try {//这里的responseObject也是一个二进制的数据，需要转换一下
//            NSDictionary *dic = [self dataHandle:responseObject];
//            if (result) {
//                result(dic);
//            }
//        }
//        @catch (NSException *exception) {
//            if (errors) {
//                errors(exception.reason);
//            }
//        }
//        @finally {
//            
//        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        
        }];
}
@end
