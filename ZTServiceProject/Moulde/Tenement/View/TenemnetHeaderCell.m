//
//  TenemnetHeaderCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenemnetHeaderCell.h"

@implementation TenemnetHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTitleHeader:(UILabel *)titleHeader
{
    _titleHeader = titleHeader;
}
- (void)setTitleArr:(NSArray *)titleArr
{
    
}
@end
