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



@interface UserInfoManager ()
@property (nonatomic,copy)NSString *savePath;
@property (nonatomic,strong)NSFileManager *fileManager;
@end
@implementation UserInfoManager

ZX_IMPLEMENT_SINGLETON(UserInfoManager);
- (void)saveUserModel:(LoginDataModel *)userLoginModel {
    if ([self createFileWithName:self.savePath]) {
        BOOL success =  [NSKeyedArchiver archiveRootObject:userLoginModel toFile:self.savePath];
        NSLog(@"%@",success?@"保存成功":@"保存失败");
        return;
    }
    NSLog(@"创建文件失败");
}

- (void)saveUserToken:(NSString *)userToken {
    if (userToken) {
        DefaultSaveKeyValue(TokenKey, userToken);
    }
}

- (NSString *)token {
   return GetValueForKey(TokenKey);
}

- (void)removeUserInfo {
    if ([self fileIsHave:self.savePath]) {
        [self.fileManager removeItemAtPath:self.savePath error:nil];
    }
}

- (BOOL)createFileWithName:(NSString *)path {
    if ([self fileIsHave:path]) {
        return YES;
    }
    else {
      BOOL creatSuccess = [self.fileManager createFileAtPath:path contents:nil attributes:nil];
        return creatSuccess;
    }
}


- (BOOL)fileIsHave:(NSString *)path {
    
    if(![self.fileManager fileExistsAtPath:path]) {
        return NO;
    }
    return YES;
}

- (LoginDataModel *)userInfoModel {
    LoginDataModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:self.savePath];
    if (model) {
        return model;
    }
    return nil;
}

- (NSString *)savePath {
    if (!_savePath) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _savePath = [path stringByAppendingPathComponent:@"loginModel.data"];
    }
    return _savePath;
}

-(NSFileManager *)fileManager {
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

@end
