//
//  SecondDetailsCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondHandModel;

@interface SecondDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (nonatomic,strong)SecondHandModel *model;


@end
