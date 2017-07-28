//
//  HouseBodyCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyHouseModel;
@interface HouseBodyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic,strong)MyHouseModel *model;

@property (nonatomic,copy)BtnClickBlock btnClickBlock;

@end
