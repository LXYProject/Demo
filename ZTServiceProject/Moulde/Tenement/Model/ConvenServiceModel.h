//
//  ConvenServiceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"serviceList": [
//                {

//"serviceCategory": "web",
//"serviceProvider": "pc",
//"servicePhoneNum": "00100100111",
//"serviceAddress": "倒萨"
@interface ConvenServiceModel : NSObject

@property (nonatomic,copy)NSString *serviceCategory;
@property (nonatomic,copy)NSString *serviceProvider;
@property (nonatomic,copy)NSString *servicePhoneNum;
@property (nonatomic,copy)NSString *serviceAddress;

@end
