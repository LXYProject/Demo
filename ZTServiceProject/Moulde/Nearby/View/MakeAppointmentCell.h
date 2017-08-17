//
//  MakeAppointmentCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MakeAppointmentCell;

@protocol MakeAppointmentDelegate <NSObject>

- (void)bookCellDidClickPlusButton:(MakeAppointmentCell * )bookCell;

- (void)bookCellDidClickMinusButton:(MakeAppointmentCell * )bookCell;

@end


@interface MakeAppointmentCell : UITableViewCell

@property (nonatomic,weak)  id<MakeAppointmentDelegate> delegate;//代理


@end
