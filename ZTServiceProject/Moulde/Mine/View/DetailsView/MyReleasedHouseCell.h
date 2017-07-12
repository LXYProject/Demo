//
//  MyReleasedHouseCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RentHouseModel;
@class ServiceModel;
@class NearByItemModel;
@interface MyReleasedHouseCell : UITableViewCell

@property (nonatomic,strong)RentHouseModel *model;
@property (nonatomic,strong)ServiceModel *serviceModel;
@property (nonatomic,strong)NearByItemModel *nearByItemModel;

@end
