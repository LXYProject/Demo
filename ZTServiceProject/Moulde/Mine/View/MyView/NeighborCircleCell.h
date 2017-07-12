//
//  NeighborCircleCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeighborCircleModel;
@interface NeighborCircleCell : UITableViewCell

@property (nonatomic,strong)NeighborCircleModel *model;

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *months;

@end
