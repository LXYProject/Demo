//
//  DoorServiceModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"serviceCategoryList": [
//                        {

//"remark": "",
//"serviceCategoryId": "v005",
//"serviceCategory": "美女上门服务"

@interface DoorServiceModel : NSObject



@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *serviceCategoryId;
@property (nonatomic,copy)NSString *serviceCategory;

@end
