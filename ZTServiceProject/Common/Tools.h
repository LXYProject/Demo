//
//  Tools.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//#warning 第一步：定义Block属性
typedef void(^AppToolBlock)(NSString *string);

@interface Tools : NSObject
+ (UIImage*) createImageWithColor: (UIColor*) color;

//#warning 第二步
// 声明方法，在方法中封装block
- (void)sendBlock:(AppToolBlock)block;


@end
