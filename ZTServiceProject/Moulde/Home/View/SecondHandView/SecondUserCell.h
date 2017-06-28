//
//  SecondUserCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondHandModel;
@interface SecondUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *presentPrice;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;
@property (nonatomic,copy)NSString *url;


@property (nonatomic,strong)SecondHandModel *model;



@end
