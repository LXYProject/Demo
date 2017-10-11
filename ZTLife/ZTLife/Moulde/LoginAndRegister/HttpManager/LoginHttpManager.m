//
//  LoginHttpManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LoginHttpManager.h"
#import "LoginDataModel.h"

@implementation LoginHttpManager

//用户注册登录获取验证码
+ (void)requestLoginRegisterCode:(LoginRegisterCode)loginRegisterCode
               phoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               };
    
    NSString *url = nil;
    if (loginRegisterCode == LoginCode) {
        url = A_loginUrl;
    }
    else {
        url = A_registerUrl;
    }
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:url paramter:paramter success:^(id response) {
        success(response);
        
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
//        success(modelArray);
        
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//注册验证码核对
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"code":code?code:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_registerCheck paramter:paramter success:^(id response) {
        LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
        success(model);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//登录验证码核对
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                   code:(NSString *)code
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"code":code?code:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_loginCheck paramter:paramter success:^(id response) {
         LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
        success(model);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//手机号密码登录
+ (void)requestPhoneNum:(NSString *)phoneNum
               passWord:(NSString *)passWord
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
             clientType:(NSString *)clientType
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"passWord":passWord?passWord:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_phoneNumLogin paramter:paramter success:^(id response) {        
        LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
        success(model);
        
        
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//token登陆
+ (void)requestMachineId:(NSString *)machineId
         machineName:(NSString *)machineName
          clientType:(NSString *)clientType
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"clientType":clientType?clientType:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_tokenLogin paramter:paramter success:^(id response) {
        LoginDataModel *model = [LoginDataModel mj_objectWithKeyValues:response];
        success(model);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//修改密码
+ (void)requestPhoneNum:(NSString *)phoneNum
              machineId:(NSString *)machineId
            machineName:(NSString *)machineName
                  token:(NSString *)token
            newPassWord:(NSString *)newPassWord
                success:(HttpRequestSuccess)success
                failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phoneNum":phoneNum?phoneNum:@"",
                               @"machineId":machineId?machineId:@"",
                               @"machineName":machineName?machineName:@"",
                               @"token":token?token:@"",
                               @"newPassWord":newPassWord?newPassWord:@"",
                               };
    
    
    [[HttpAPIManager sharedHttpAPIManager]getWithTwoUrl:A_updatePassWord paramter:paramter success:^(id response) {
        
        success(response);
        
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
//        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

//修改个人信息
+ (void)requestProps:(NSString *)props
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"props":props?props:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateUser paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}

////修改头像
//+ (void)requestImage:(UIImage *)image
//             success:(HttpRequestSuccess)success
//             failure:(HttpRequestFailure)failure{
//    
//    //UIImageJPEGRepresentation(originImage, 0.5);
//    //UIImagePNGRepresentation(originImage);
////    UIImage *originImage = image;
////    NSData *data = UIImagePNGRepresentation(originImage);
////
////    if (data) {
////        UIImageJPEGRepresentation(image, 0.5);
////    }
//    
//    UIImage *originImage = image;
//    
////    NSData *data = UIImageJPEGRepresentation(originImage, 0.1);
//    NSData *data = UIImagePNGRepresentation(originImage);
//    
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    
//    NSString *s = @"iVBORw0KGgoAAAANSUhEUgAAADQAAAAsCAYAAAAq/ZsdAAAMFmlDQ1BJQ0MgUHJvZmlsZQAASImVVwdYU8kWnltSCAktEAEpoXekSBcIHaRKBxshCRBKhISgYkcWFVwLKhYUFV0Bsa0FkMWGXVkEe38gorKyLhawoPImBXR97Xvn+yb3z5lzzvzn3HPnmwFA2Y6dm5uNqgCQI8gXRgf5MhOTkpmkbkAECGAAM+DA5ohyfaKiwgCU0effZeg2tIVyw0YS61/n/6uocnkiDgBIFMSpXBEnB+KjAOCanFxhPgCENqg3mp2fK8EDEKsLIUEAiLgEp8uwpgSnyrC11CY22g9iFgBkKpstTAdAScKbWcBJh3GUJBztBFy+AOKtEHtxMthciB9CbJ2TMwtiZTLE5qnfxUn/W8zUsZhsdvoYluUiFbI/X5SbzZ77f5bjf0tOtnh0DUM4qBnC4GhJzrButVmzQiWYCnGLIDUiEmI1iC/xuVJ7Cb6fIQ6Ok9v3c0R+sGbwPQMUcNn+oRDrQMwQZ8X5yLEDWyj1hfZoBD8/JFaOU4WzouXx0QJBdkSYPM7yDF7IKK7iiQJiRm3S+IEhEMNOQ48WZsQmyHii5wr48REQK0HcIcqKCZX7Pi7M8IsYtRGKoyWcjSF+lyYMjJbZYJo5otG8MFsOW7oW7AWMlZ8RGyzzxRJ5osSwUQ5cnn+AjAPG5Qni5Nww2F2+0XLfktzsKLk9VsXLDoqW1Rk7JCqIGfW9ng8bTFYH7Ekme3KUfK2h3PyoWBk3HAVhwA/4AyYQw5EKZoFMwG/vb+yH/2QzgYANhCAd8ICNXDPqkSCdEcDfGFAI/oSIB0Rjfr7SWR4ogPovY1rZrw1Ik84WSD2ywDOIc3Bt3Av3wMPgLwsOB9wVdxv1YyqPrkoMIPoTg4mBRIsxHhzIOhsOIeD/G10ofPJgdhIugtEcvsUjPCN0Ep4QbhG6CPdAPHgqjSK3mskvEv7AnAnCQReMFijPLhXG7Bu1wU0hayfcF/eE/CF3nIFrAxt8IszEB/eGuTlB7fcMxWPcvtXyx/UkrL/PR65XslRykrNIHXszfmNWP0bx+65GXPgM/dESW44dwS5iZ7DLWAvWCJjYKawJa8NOSPBYJzyVdsLoatFSblkwDn/Uxq7ers/u8w9rs+XrS+olyufNyZd8DH6zcucK+ekZ+UwfuBvzmCECjq0108HO3gUAyd4u2zreMqR7NsK48k2XdxoAt1KoTP+mYxsBcPwZAPShbzqjN7Dd1wBwooMjFhbIdJLtGBAABSjDr0IL6AEjYA7zcQDOwAOwQACYDCJBLEgCM2DFM0AO5DwbzAdLQAkoA2vABrAFbAe7QC3YDw6DRtACzoAL4CroALfAA9gXveAlGABDYBhBEBJCQ+iIFqKPmCBWiAPiinghAUgYEo0kISlIOiJAxMh8ZClShpQjW5CdSB3yK3IcOYNcRjqRe0g30oe8QT6hGEpF1VFd1BSdgLqiPmgoGotOR9PRPLQQLUZXoZvQanQf2oCeQa+it9Au9CU6iAFMEWNgBpgN5or5YZFYMpaGCbGFWClWgVVjB7Bm+J5vYF1YP/YRJ+J0nInbwN4MxuNwDp6HL8RX4lvwWrwBP4ffwLvxAfwrgUbQIVgR3AkhhERCOmE2oYRQQdhDOEY4D7+bXsIQkUhkEM2ILvC7TCJmEucRVxK3EQ8STxM7iT3EQRKJpEWyInmSIklsUj6phLSZtI90inSd1Ev6QFYk65MdyIHkZLKAXESuIO8lnyRfJz8nDyuoKJgouCtEKnAV5iqsVtit0KxwTaFXYZiiSjGjeFJiKZmUJZRNlAOU85SHlLeKioqGim6KUxT5iosVNykeUryk2K34kapGtaT6UadRxdRV1Brqaeo96lsajWZKY9GSafm0VbQ62lnaY9oHJbqSrVKIEldpkVKlUoPSdaVXygrKJso+yjOUC5UrlI8oX1PuV1FQMVXxU2GrLFSpVDmuckdlUJWuaq8aqZqjulJ1r+pl1RdqJDVTtQA1rlqx2i61s2o9dIxuRPejc+hL6bvp5+m96kR1M/UQ9Uz1MvX96u3qAxpqGhM14jXmaFRqnNDoYmAMU0YII5uxmnGYcZvxaZzuOJ9xvHErxh0Yd33ce83xmixNnmap5kHNW5qftJhaAVpZWmu1GrUeaePaltpTtGdrV2mf1+4frz7eYzxnfOn4w+Pv66A6ljrROvN0dum06Qzq6ukG6ebqbtY9q9uvx9Bj6WXqrdc7qdenT9f30ufrr9c/pf8HU4Ppw8xmbmKeYw4Y6BgEG4gNdhq0GwwbmhnGGRYZHjR8ZEQxcjVKM1pv1Go0YKxvHG4837je+L6JgomrSYbJRpOLJu9NzUwTTJeZNpq+MNM0CzErNKs3e2hOM/c2zzOvNr9pQbRwtciy2GbRYYlaOllmWFZaXrNCrZyt+FbbrDqtCdZu1gLraus7NlQbH5sCm3qbbluGbZhtkW2j7asJxhOSJ6ydcHHCVzsnu2y73XYP7NXsJ9sX2Tfbv3GwdOA4VDrcdKQ5BjoucmxyfD3RaiJvYtXEu050p3CnZU6tTl+cXZyFzgec+1yMXVJctrrccVV3jXJd6XrJjeDm67bIrcXto7uze777Yfe/PGw8sjz2eryYZDaJN2n3pB5PQ0+2507PLi+mV4rXDq8ubwNvtne19xOWEYvL2sN67mPhk+mzz+eVr52v0PeY73s/d78Ffqf9Mf8g/1L/9gC1gLiALQGPAw0D0wPrAweCnILmBZ0OJgSHBq8NvhOiG8IJqQsZmOwyecHkc6HU0JjQLaFPwizDhGHN4Wj45PB14Q8jTCIEEY2RIDIkcl3koyizqLyo36YQp0RNqZzyLNo+en70xRh6zMyYvTFDsb6xq2MfxJnHieNa45Xjp8XXxb9P8E8oT+hKnJC4IPFqknYSP6kpmZQcn7wneXBqwNQNU3unOU0rmXZ7utn0OdMvz9CekT3jxEzlmeyZR1IIKQkpe1M+syPZ1ezB1JDUrakDHD/ORs5LLou7ntvH8+SV856neaaVp71I90xfl96X4Z1RkdHP9+Nv4b/ODM7cnvk+KzKrJmskOyH7YA45JyXnuEBNkCU4N0tv1pxZnblWuSW5XXnueRvyBoShwj0iRDRd1JSvDo85bWJz8U/i7gKvgsqCD7PjZx+ZozpHMKdtruXcFXOfFwYW/jIPn8eZ1zrfYP6S+d0LfBbsXIgsTF3YushoUfGi3sVBi2uXUJZkLfm9yK6ovOjd0oSlzcW6xYuLe34K+qm+RKlEWHJnmcey7cvx5fzl7SscV2xe8bWUW3qlzK6souzzSs7KKz/b/7zp55FVaavaVzuvrlpDXCNYc3ut99ractXywvKedeHrGtYz15euf7dh5obLFRMrtm+kbBRv7NoUtqlps/HmNZs/b8nYcqvSt/LgVp2tK7a+38bddr2KVXVgu+72su2fdvB33N0ZtLOh2rS6YhdxV8GuZ7vjd1/8xfWXuj3ae8r2fKkR1HTVRteeq3Opq9urs3d1PVovru/bN21fx37//U0HbA7sPMg4WHYIHBIf+uPXlF9vHw493HrE9ciBoyZHtx6jHyttQBrmNgw0ZjR2NSU1dR6ffLy12aP52G+2v9W0GLRUntA4sfok5WTxyZFThacGT+ee7j+TfqandWbrg7OJZ2+em3Ku/Xzo+UsXAi+cvehz8dQlz0stl90vH7/ieqXxqvPVhjantmO/O/1+rN25veGay7WmDreO5s5JnSeve18/c8P/xoWbITev3oq41Xk77vbdO9PudN3l3n1xL/ve6/sF94cfLH5IeFj6SOVRxWOdx9X/sPjHwS7nrhPd/t1tT2KePOjh9Lx8Knr6ubf4Ge1ZxXP953UvHF609AX2dfwx9Y/el7kvh/tL/lT9c+sr81dH/2L91TaQOND7Wvh65M3Kt1pva95NfNc6GDX4eChnaPh96QetD7UfXT9e/JTw6fnw7M+kz5u+WHxp/hr69eFIzshILlvIlh4FMDjQtDQA3tQAQEuCZ4cOAChKsruXVBDZfVGKwH/CsvuZVJwBqGEBELcYgDB4RqmCwwRiKnxKjt6xLIA6Oo4NuYjSHB1ksajwBkP4MDLyVhcAUjMAX4QjI8PbRka+7IZk7wFwOk9255MIEZ7vd9hKUEfvK/Cj/BMuJ20k8VLSywAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAAZtpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iPgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+NTI8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+NDQ8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KKewQbwAAABxpRE9UAAAAAgAAAAAAAAAWAAAAKAAAABYAAAAWAAAAi8F4mhEAAABXSURBVGgF7NKxDQAhDARBuwxC+u+HdqCGS1YW2s+tEzvfZ69bH33tg4ZrKjQcqBRSCC7gLwcHj+cUipPBBwrBweM5heJk8IFCcPB4TqE4GXygEBw8nnsAAAD//2W3p/sAAABUSURBVO3SsQ0AIQwEQbsMQvrvh3aghktWFtrPrRM732evWx997YOGayo0HKgUUggu4C8HB4/nFIqTwQcKwcHjOYXiZPCBQnDweE6hOBl8oBAcPJ57mRZawar0e4wAAAAASUVORK5CYII=";
//    
//    NSString *str = [[NSString alloc] init];
//    
////    str = @"{\"type\":\"png\",\"base64\":\"%@\"}";
//    
//    str = @"{\"type\":\"png\",\"base64\":\"%@\"}";
//
//    
//    NSString *ab = [NSString stringWithFormat:str, encodedImageStr];
//    
//    NSLog(@"ab=%@", ab);
//    
//    
////    NSDictionary *paramter = @{@"image":@{@"type":@"png", @"base64":encodedImageStr?encodedImageStr:@""}};
//    
//    
//    NSDictionary *paramter = @{@"image":ab};
//
//    
//    
////    NSDictionary *paramter = @{@"image": [Tools dictTransformToJson:@{@"type":@"png",@"base64":@"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"}]};
//    
//    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateHeadImage paramter:paramter success:^(id response) {
//        NSLog(@"%@", response);
//        success(response);
////        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
////        success(modelArray);
//    } failure:^(NSError *error, NSString *message) {
//        failure(error,message);
//    }];
//    
//
//    
//    //    "image": {
//    //        "type":"1545454sdasd",
//    //        "base64":"1545454sdasd"}
//    //
//    //}
//    //@{“image”:@{@“”：@“”，@“”：@“”}}
//    //"image":@{@"type":@"添加参数",@"base64":@"添加参数"}
//    //    NSDictionary *dd = @{@"image":@{@"type":@"", @"base64":@""}};
//    //    NSLog(@"dd%@", dd);
////======================================================
//    //    NSData *data = UIImagePNGRepresentation(image);
//    //    if (data) {
//    //        UIImageJPEGRepresentation(image, 0.5);
//    //    }
//    //
//    //    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
////    @"image/jpeg",
////    @"image/png",
////    NSURL *url=[NSURL URLWithString:A_updateHeadImage];
//    
////    [[HttpAPIManager sharedHttpAPIManager]uploadDataWithUrl:A_updateHeadImage fileData:encodedImageStr type:@"jpg" name:@"image" mimeType:@"image/jpeg" paramter:parameter progressBlock:^(CGFloat progress) {
////    } success:^(id response) {
////        NSLog(@"%@", response);
////        success(response);
////    } failure:^(NSError *error, NSString *message) {
////        failure(error,message);
////    }];
//
//}


//+ (NSString*)encodeURL:(NSString *)string
// {
//      NSString *str =   [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"]];
//    
//     if (str) {
//         return str;
//    }
//     return @"";
//}



+ (void)requestImage:(NSString *)image
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"image":image?image:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_updateHeadImage paramter:paramter success:^(id response) {
        success(response);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];
    
}

//上传个人图片
+ (void)requestImages:(NSString *)images
              success:(HttpRequestSuccess)success
              failure:(HttpRequestFailure)failure{
    
}


//通过id查询用户信息
+ (void)requestTargetUserId:(NSString *)targetUserId
                    success:(HttpRequestSuccess)success
                    failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"targetUserId":targetUserId?targetUserId:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_findUserInfoById paramter:paramter success:^(id response) {
        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response];
        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}


//通过手机号查询用户信息
+ (void)requestPhone:(NSString *)phone
             success:(HttpRequestSuccess)success
             failure:(HttpRequestFailure)failure{
    
    NSDictionary *paramter = @{@"phone":phone?phone:@"",
                               };
    
    [[HttpAPIManager sharedHttpAPIManager]getWithUrl:A_findUserInfoByPhone paramter:paramter success:^(id response) {
//        NSArray *modelArray = [LoginDataModel mj_objectArrayWithKeyValuesArray:response[@"userList"]];
//        success(modelArray);
    } failure:^(NSError *error, NSString *message) {
        failure(error,message);
    }];

}
@end
