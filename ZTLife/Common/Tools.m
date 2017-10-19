//
//  Tools.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "Tools.h"
#import "sys/utsname.h"

@implementation Tools
#pragma mark - 颜色返回图片
+ (UIImage*) createImageWithColor: (UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//#warning 第三步
// 在AppTool.m实现方法，并执行block
- (void)sendBlock:(AppToolBlock)block
{
    NSString *string;
    block(string);
}

+ (void)cellRadio:(UITableView *)tableView cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        // if (tableView == self.tableView) {
        
        CGFloat cornerRadius = 10.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        backgroundLayer.path = pathRef;
        CFRelease(pathRef);
        
        //颜色修改
        
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1].CGColor;
        
        layer.strokeColor=[UIColor whiteColor].CGColor;
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        cell.backgroundView = testView;
        
        
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
        backgroundLayer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
        selectedBackgroundView.backgroundColor = UIColor.clearColor;
        cell.selectedBackgroundView = selectedBackgroundView;
        
    }
}

+ (NSString *)dictTransformToJson:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSString*)deviceVersion{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
//    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
//    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
//    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
//    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
//    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
//    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
//    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
//    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
//    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
//    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
//    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
//    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
//    return deviceString;
    
    //iPhone
    if([deviceString isEqualToString:@"iPhone1,1"])     return@"iPhone 2G";
    if([deviceString isEqualToString:@"iPhone1,2"])     return@"iPhone 3G";
    if([deviceString isEqualToString:@"iPhone2,1"])     return@"iPhone 3GS";
    if([deviceString isEqualToString:@"iPhone3,1"])     return@"iPhone 4";
    if([deviceString isEqualToString:@"iPhone3,2"])     return@"iPhone 4";
    if([deviceString isEqualToString:@"iPhone3,3"])     return@"iPhone 4";
    if([deviceString isEqualToString:@"iPhone4,1"])     return@"iPhone 4S";
    if([deviceString isEqualToString:@"iPhone5,1"])     return@"iPhone 5";
    if([deviceString isEqualToString:@"iPhone5,2"])     return@"iPhone 5";
    if([deviceString isEqualToString:@"iPhone5,3"])     return@"iPhone 5c";
    if([deviceString isEqualToString:@"iPhone5,4"])     return@"iPhone 5c";
    if([deviceString isEqualToString:@"iPhone6,1"])     return@"iPhone 5s";
    if([deviceString isEqualToString:@"iPhone6,2"])     return@"iPhone 5s";
    if([deviceString isEqualToString:@"iPhone7,1"])     return@"iPhone 6 Plus";
    if([deviceString isEqualToString:@"iPhone7,2"])     return@"iPhone 6";
    if([deviceString isEqualToString:@"iPhone8,1"])     return@"iPhone 6s";
    if([deviceString isEqualToString:@"iPhone8,2"])     return@"iPhone 6s Plus";
    if([deviceString isEqualToString:@"iPhone8,4"])     return@"iPhone SE";
    if([deviceString isEqualToString:@"iPhone9,1"])     return@"iPhone 7";
    if([deviceString isEqualToString:@"iPhone9,2"])     return@"iPhone 7 Plus";
    if([deviceString isEqualToString:@"iPhone10,1"])    return@"iPhone 8";
    if([deviceString isEqualToString:@"iPhone10,4"])    return@"iPhone 8";
    if([deviceString isEqualToString:@"iPhone10,2"])    return@"iPhone 8 Plus";
    if([deviceString isEqualToString:@"iPhone10,5"])    return@"iPhone 8 Plus";
    if([deviceString isEqualToString:@"iPhone10,3"])    return@"iPhone X";
    if([deviceString isEqualToString:@"iPhone10,6"])    return@"iPhone X";
    
    //iPod Touch
    if([deviceString isEqualToString:@"iPod1,1"])       return@"iPod Touch 1G";
    if([deviceString isEqualToString:@"iPod2,1"])       return@"iPod Touch 2G";
    if([deviceString isEqualToString:@"iPod3,1"])       return@"iPod Touch 3G";
    if([deviceString isEqualToString:@"iPod4,1"])       return@"iPod Touch 4G";
    if([deviceString isEqualToString:@"iPod5,1"])       return@"iPod Touch 5G";
    if([deviceString isEqualToString:@"iPod7,1"])       return @"iPodTouch6G";
    
    //iPad
    if([deviceString isEqualToString:@"iPad1,1"])       return@"iPad 1G";
    if([deviceString isEqualToString:@"iPad2,1"])       return@"iPad 2";
    if([deviceString isEqualToString:@"iPad2,2"])       return@"iPad 2";
    if([deviceString isEqualToString:@"iPad2,3"])       return@"iPad 2";
    if([deviceString isEqualToString:@"iPad2,4"])       return@"iPad 2";
    if([deviceString isEqualToString:@"iPad3,1"])       return@"iPad 3";
    if([deviceString isEqualToString:@"iPad3,2"])       return@"iPad 3";
    if([deviceString isEqualToString:@"iPad3,3"])       return@"iPad 3";
    if([deviceString isEqualToString:@"iPad3,4"])       return@"iPad 4";
    if([deviceString isEqualToString:@"iPad3,5"])       return@"iPad 4";
    if([deviceString isEqualToString:@"iPad3,6"])       return@"iPad 4";
    
    
    //iPad Air
    if([deviceString isEqualToString:@"iPad4,1"])       return@"iPad Air";
    if([deviceString isEqualToString:@"iPad4,2"])       return@"iPad Air";
    if([deviceString isEqualToString:@"iPad4,3"])       return@"iPad Air";
    if([deviceString isEqualToString:@"iPad5,3"])       return@"iPad Air 2";
    if([deviceString isEqualToString:@"iPad5,4"])       return@"iPad Air 2";
    
    //iPad mini
    if([deviceString isEqualToString:@"iPad2,5"])       return@"iPad Mini 1G";
    if([deviceString isEqualToString:@"iPad2,6"])       return@"iPad Mini 1G";
    if([deviceString isEqualToString:@"iPad2,7"])       return@"iPad Mini 1G";
    if([deviceString isEqualToString:@"iPad4,4"])       return@"iPad Mini 2G";
    if([deviceString isEqualToString:@"iPad4,5"])       return@"iPad Mini 2G";
    if([deviceString isEqualToString:@"iPad4,6"])       return@"iPad Mini 2G";
    if([deviceString isEqualToString:@"iPad4,7"])       return@"iPad Mini 3";
    if([deviceString isEqualToString:@"iPad4,8"])       return@"iPad Mini 3";
    if([deviceString isEqualToString:@"iPad4,9"])       return@"iPad Mini 3";
    if([deviceString isEqualToString:@"iPad5,1"])       return@"iPad Mini 4";
    if([deviceString isEqualToString:@"iPad5,2"])       return@"iPad Mini 4";
    
    if([deviceString isEqualToString:@"iPad6,3"])       return@"iPad Pro 9.7";
    if([deviceString isEqualToString:@"iPad6,4"])       return@"iPad Pro 9.7";
    if([deviceString isEqualToString:@"iPad6,7"])       return@"iPad Pro 12.9";
    if([deviceString isEqualToString:@"iPad6,8"])       return@"iPad Pro 12.9";
    
    if([deviceString isEqualToString:@"i386"])          return@"iPhone Simulator";
    if([deviceString isEqualToString:@"x86_64"])        return@"iPhone Simulator";
    return deviceString;

}
@end
