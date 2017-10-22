//
//  FiltrateCell.m
//  3198CommercialChance
//
//  Created by iOS开发 on 15/12/8.
//  Copyright © 2015年 路鹏. All rights reserved.
//

#import "FiltrateCell.h"

@implementation FiltrateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.angleImgView.hidden = YES;
}
- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLab.textColor = [UIColor redColor];
        self.angleImgView.hidden = NO;
    }else
    {
        self.titleLab.textColor = [UIColor blackColor];
        self.angleImgView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
