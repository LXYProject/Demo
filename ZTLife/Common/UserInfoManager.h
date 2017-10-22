//
//  UserInfoManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDataModel.h"
#import "UserInfoModel.h"
@interface UserInfoManager : NSObject

@property (nonatomic,strong)LoginDataModel *userInfoModel;
ZX_DECLARE_SINGLETON(UserInfoManager);
/**
 保存用户信息
 */
- (void)saveUserModel:(LoginDataModel *)userLoginModel;

/**
 删除用户信息
 */
- (void)removeUserInfo;


@end
