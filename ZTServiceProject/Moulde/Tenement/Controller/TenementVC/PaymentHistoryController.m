//
//  PaymentHistoryController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PaymentHistoryController.h"

@interface PaymentHistoryController ()

@end

@implementation PaymentHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"缴费历史" titleColor:[UIColor whiteColor]];
    
    
    UIImage *image = [UIImage imageNamed:@"wd_fwdd"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    

    
    AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]init];
    
    NSDictionary *parameters = @{@"a":@"1",
                                 @"b":@"2"};
    
    [manager POST:@"http://192.168.1.96:8080/ZtscApp/Service?service=file&function=upload" parameters:parameters
     
constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
    
    
    [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
    
    NSString*size=@"1000";
    
    NSData *data = [size dataUsingEncoding:NSUTF8StringEncoding];

    
    [formData appendPartWithFormData:data name:@"size"];
    
    
} progress:^(NSProgress * _Nonnull uploadProgress) {
    
    //显示进度
    
} success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
    
    //显示返回对象
    
    NSLog(@"-------->%@",responseObject);
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    //显示错误信息
    NSLog(@"-------->%@",error);
    
}];
    

}


@end
