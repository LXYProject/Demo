//
//  ProductItemCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NearByItemModel;
@class SecondHandModel;
@class RentHouseModel;
@interface ProductItemCell : UITableViewCell
@property (nonatomic,strong)NearByItemModel *model;
@property (nonatomic, strong)SecondHandModel *secondModel;
@property (nonatomic, strong)RentHouseModel *rentHouseModel;
@end
