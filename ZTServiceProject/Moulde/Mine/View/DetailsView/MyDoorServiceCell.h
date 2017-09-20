//
//  MyDoorServiceCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDoorServiceModel;
@class MyPublicThingsModel;
@interface MyDoorServiceCell : UITableViewCell

@property (nonatomic,strong)MyDoorServiceModel *model;
@property (nonatomic,strong)MyPublicThingsModel *publicModel;


@end
