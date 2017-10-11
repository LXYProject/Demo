//
//  KeyBoardManager.h
//  ZTServiceProject
//
//  Created by ZT on 2017/9/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTKeyBoardManager : NSObject
ZX_DECLARE_SINGLETON(ZTKeyBoardManager);
@property (nonatomic,assign,readonly)BOOL keyBoardIsShowing;
@end
