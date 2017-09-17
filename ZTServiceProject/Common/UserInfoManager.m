//
//  UserInfoManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/9/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "UserInfoManager.h"
//注册验证码核对 属性保存
#define GenderKey              @"gender"
#define HeadImageKey           @"headImage"
#define HuanxinUserNameKey     @"huanxinUserName"
#define HuanxinUserpasswordKey @"huanxinUserpassword"
#define IsIdentificationKey    @"isIdentification"
#define NickNameKey            @"nickName"
#define PhoneNumKey            @"phoneNum"
#define TokenKey               @"token"
#define UserIdKey              @"userId"
@implementation UserInfoManager

ZX_IMPLEMENT_SINGLETON(UserInfoManager);
- (void)saveUserModel:(LoginDataModel *)userLoginModel {
    DefaultSaveKeyValue(                 GenderKey, userLoginModel.gender);
    DefaultSaveKeyValue(              HeadImageKey, userLoginModel.headImage);
    DefaultSaveKeyValue(        HuanxinUserNameKey, userLoginModel.huanxinUserName);
    DefaultSaveKeyValue(    HuanxinUserpasswordKey, userLoginModel.huanxinUserpassword);
    DefaultSaveKeyValue(       IsIdentificationKey, userLoginModel.isIdentification);
    DefaultSaveKeyValue(               NickNameKey, userLoginModel.nickName);
    DefaultSaveKeyValue(               PhoneNumKey, userLoginModel.phoneNum);
    DefaultSaveKeyValue(                  TokenKey, userLoginModel.token);
    DefaultSaveKeyValue(                 UserIdKey, userLoginModel.userId);
}

- (void)removeUserInfo {
    DefaultRemoveValueForKey(GenderKey);
    DefaultRemoveValueForKey(HeadImageKey);
    DefaultRemoveValueForKey(HuanxinUserNameKey);
    DefaultRemoveValueForKey(HuanxinUserpasswordKey);
    DefaultRemoveValueForKey(IsIdentificationKey);
    DefaultRemoveValueForKey(NickNameKey);
    DefaultRemoveValueForKey(PhoneNumKey);
    DefaultRemoveValueForKey(TokenKey);
    DefaultRemoveValueForKey(UserIdKey);
}

- (LoginDataModel *)userInfoModel {
    if (!GetValueForKey(GenderKey)&&
        !GetValueForKey(HeadImageKey)&&
        !GetValueForKey(HuanxinUserNameKey)&&
        !GetValueForKey(HuanxinUserpasswordKey)&&
        !GetValueForKey(IsIdentificationKey)&&
        !GetValueForKey(NickNameKey)&&
        !GetValueForKey(PhoneNumKey)&&
        !GetValueForKey(TokenKey)&&
        !GetValueForKey(UserIdKey)) {
        return nil;
    }
    if (!_userInfoModel) {
        _userInfoModel = [[LoginDataModel alloc]init];
    }
    _userInfoModel.gender = GetValueForKey(GenderKey);
    _userInfoModel.headImage = GetValueForKey(HeadImageKey);
    _userInfoModel.huanxinUserName = GetValueForKey(HuanxinUserNameKey);
    _userInfoModel.huanxinUserpassword = GetValueForKey(HuanxinUserpasswordKey);
    _userInfoModel.isIdentification = GetValueForKey(IsIdentificationKey);
    _userInfoModel.nickName = GetValueForKey(NickNameKey);
    _userInfoModel.phoneNum = GetValueForKey(PhoneNumKey);
    _userInfoModel.token = GetValueForKey(TokenKey);
    _userInfoModel.userId = GetValueForKey(UserIdKey);
    return _userInfoModel;
    
}

@end
