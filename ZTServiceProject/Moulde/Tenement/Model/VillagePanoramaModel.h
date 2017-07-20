//
//  VillagePanoramaModel.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

//"featureList": [
//                {

//"featureCategory": "饮料售卖机",
//"featureId": "20170628173228",
//"featureName": "售水机",
//"featureX": 103.88842301,
//"featureY": 30.80872819
@interface VillagePanoramaModel : NSObject

@property (nonatomic,copy)NSString *featureCategory;
@property (nonatomic,copy)NSString *featureId;
@property (nonatomic,copy)NSString *featureName;
@property (nonatomic,copy)NSString *featureX;
@property (nonatomic,copy)NSString *featureY;

@end
