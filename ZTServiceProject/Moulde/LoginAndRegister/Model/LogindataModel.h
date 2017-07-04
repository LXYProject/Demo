//
//  LoginDataModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>


//用户注册验证码核对
//gender = 0;
//headImage = "http://192.168.1.96:8080/ZtscApp/file/headImage/head.jpg";
//huanxinUserName = 20170704115427;
//huanxinUserpassword = 20170704115427;
//isIdentification = 0;
//nickName = sa18516835791;
//phoneNum = 18516835791;
//status = 0;
//token = "SUM1MI8pEzsGAjpzVZfMQ==";
//userId = 20170704115427;

@interface LoginDataModel : NSObject

@property (nonatomic,copy)NSString *gender;
@property (nonatomic,copy)NSString *headImage;
@property (nonatomic,copy)NSString *huanxinUserName;
@property (nonatomic,copy)NSString *isIdentification;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *phoneNum;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *token;
@property (nonatomic,copy)NSString *userId;


@end
