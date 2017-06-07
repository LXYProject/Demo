//
//  CommonTools.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#ifndef CommonTools_h
#define CommonTools_h
/**********公用的Block************/
//登录成功的回调
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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 基本设备信息
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


#endif /* CommonTools_h */
