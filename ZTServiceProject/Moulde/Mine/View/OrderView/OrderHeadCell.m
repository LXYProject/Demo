//
//  OrderHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/5.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "OrderHeadCell.h"

@interface OrderHeadCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end
@implementation OrderHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
