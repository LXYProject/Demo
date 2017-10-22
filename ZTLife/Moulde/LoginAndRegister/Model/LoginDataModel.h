//
//  LoginDataModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface LoginDataModel : NSObject
@property (nonatomic,copy)NSString *information;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *token;
@property (nonatomic, strong) UserInfoModel *userInfo;
@end


