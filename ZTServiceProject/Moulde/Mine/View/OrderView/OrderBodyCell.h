//
//  OrderBodyCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/5.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BuyOrderModel;
@class HelpOrderModel;
@interface OrderBodyCell : UITableViewCell

@property (nonatomic,strong)BuyOrderModel *model;
@property (nonatomic,strong)HelpOrderModel *helpOrderModel;

@end
