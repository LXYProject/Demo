//
//  MessageCenterViewController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageCenterViewController : BaseViewController



@property (nonatomic,assign)NSString* commentType;

@property (nonatomic,copy)NSString *targetUserId;

@property (nonatomic,assign)BOOL isShowKeyBoard;
@end
