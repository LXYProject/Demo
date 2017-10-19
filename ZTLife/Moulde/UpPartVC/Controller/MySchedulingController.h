//
//  MySchedulingController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_OPTIONS(NSUInteger,DateTypes)  {
    
    Tickets,                 //  门票
    ThroughTrain,            //  直通车
    GroupTour,               //  跟团游
};


@class MonthModel;

@interface MySchedulingController : BaseViewController

// 控制器

@property (nonatomic,assign)DateTypes type;
@property (nonatomic,strong)void(^dateAction)(NSDate *date);

//@property (nonatomic,strong)ProductDetailsMode *productDetailsMode;


@end


@interface CalendarHeaderView : UICollectionReusableView
@end


@interface CalendarCell : UICollectionViewCell
@property (weak, nonatomic) UILabel *dayLabel;
@property (weak, nonatomic) UILabel *dayLabel2;
@property (strong, nonatomic) MonthModel *monthModel;
@end


@interface MonthModel : NSObject
@property (assign, nonatomic) NSInteger dayValue;
@property (strong, nonatomic) NSDate *dateValue;
@property (assign, nonatomic) BOOL isSelectedDay;   // 当天
@property (assign, nonatomic) BOOL isCanClick;      // 能否点击
@end
