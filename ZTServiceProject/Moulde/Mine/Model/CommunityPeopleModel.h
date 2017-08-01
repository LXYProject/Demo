//
//  CommunityPeopleModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"userList": [
//             {

//"relationship": 3,
//"userAge": 22,
//"userId": "20170523172645165",
//"isOnline": "0",
//"userGender": "1",
//"userProfile": "想通以后，我把你的备注改成了你的名字，连名带姓最初的样子。",
//"userHuanxinId": "2017052317454286",
//"userImgUrl": "http://192.168.1.96:8080/ZtscApp/file/headImage/u834.jpg",
//"userName": "小心女巫婆z"

@interface CommunityPeopleModel : NSObject

@property (nonatomic,copy)NSString *relationship;
@property (nonatomic,copy)NSString *userAge;
@property (nonatomic,copy)NSString *isOnline;
@property (nonatomic,copy)NSString *userGender;
@property (nonatomic,copy)NSString *userProfile;
@property (nonatomic,copy)NSString *userHuanxinId;
@property (nonatomic,copy)NSString *userImgUrl;
@property (nonatomic,copy)NSString *userName;

@end
