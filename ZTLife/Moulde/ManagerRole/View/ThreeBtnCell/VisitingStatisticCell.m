//
//  VisitingStatisticCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VisitingStatisticCell.h"

@interface VisitingStatisticCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *visitingTime;
@property (weak, nonatomic) IBOutlet UILabel *visitingName;
@property (weak, nonatomic) IBOutlet UILabel *visitingRoom;

@end
@implementation VisitingStatisticCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
