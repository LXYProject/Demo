//
//  RegularTool.h
//  SmallGuards_3.0
//
//  Created by tf on 16/7/15.
//  Copyright © 2016年 GanYue. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RegularTool : NSObject

// 匹配手机号码
+(BOOL) isValidateMobile:(NSString *)mobile;

// 邮箱
+ (BOOL) validateEmail:(NSString *)email;

@end
