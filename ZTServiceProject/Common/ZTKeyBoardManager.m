//
//  KeyBoardManager.m
//  ZTServiceProject
//
//  Created by ZT on 2017/9/10.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ZTKeyBoardManager.h"


@interface ZTKeyBoardManager ()
@property (nonatomic,assign)BOOL isShowKeyBoard;
@end

@implementation ZTKeyBoardManager
ZX_IMPLEMENT_SINGLETON(ZTKeyBoardManager);


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
        [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
        _isShowKeyBoard = NO;
    }
    return self;
}

- (void)keyboardDidShow
{
    _isShowKeyBoard = YES;
}

- (void)keyboardDidHide
{
    _isShowKeyBoard = NO;
}

- (BOOL)keyBoardIsShowing
{
    return _isShowKeyBoard;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
