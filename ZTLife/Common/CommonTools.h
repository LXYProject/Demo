//
//  CommonTools.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#ifndef CommonTools_h
#define CommonTools_h
#endif

/**********公用的Block************/
//登录成功的回调

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^LoginSuccess)();
typedef void (^PushBlock)(id viewController);
typedef void (^Void_Block)(void);
typedef void (^Bool_Block)(BOOL value);
typedef void (^Int_Block)(NSInteger value);
typedef void (^Id_Block)(id obj);
typedef void (^Async_Block)(id responseDTO);
typedef void(^SelectIndexData)(id data,NSInteger index);
typedef void (^DataHelper_Block)(id obj, BOOL ret);
typedef void (^DataHelper_Block_Page)(id obj, BOOL ret, int pageNumber);
typedef void (^DataHelper_Block_Auth)(id obj, BOOL ret, NSInteger index);
typedef void (^Location_Block)(id currentLongitude,id currentLatitude);
typedef void (^BtnClickBlock)(UIButton *sender);
typedef void (^OrderbyBtnIndex)(UIButton *sender,BOOL isUp);
typedef void (^SelectStandardMessage)(NSString *selectStandardString);

//strongify  weakify
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//
//  SynthesizeSingleton.h
//  loanCustomer
//
//  Created by zhangyinglong on 14/12/16.
//  Copyright (c) 2014年 yinglongzhang. All rights reserved.
//
#import <objc/runtime.h>

#define ZX_DECLARE_SINGLETON_IMPL(classname, sharedInstance) \
+ (classname*)sharedInstance;

#define ZX_IMPLEMENT_SINGLETON_IMPL(classname, sharedInstance) \
\
+(classname*)sharedInstance \
{ \
static classname *_sharedInstance = nil; \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_sharedInstance = [[classname alloc] init]; \
}); \
\
return _sharedInstance; \
}

#define ZX_DECLARE_SINGLETON(classname) ZX_DECLARE_SINGLETON_IMPL(classname, shared##classname)
#define ZX_IMPLEMENT_SINGLETON(classname) ZX_IMPLEMENT_SINGLETON_IMPL(classname, shared##classname)
#define ZX_CALL_SINGLETON(classname) ([classname shared##classname])



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 基本设备信息
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


// NSUserDefaults
#define DefaultSaveKeyValue(key,value) [[NSUserDefaults standardUserDefaults]setValue:value forKey:key];\
[[NSUserDefaults standardUserDefaults]synchronize];

#define GetValueForKey(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]

#define DefaultRemoveValueForKey(key) [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];\
[[NSUserDefaults standardUserDefaults]synchronize];


#endif /* CommonTools_h */
