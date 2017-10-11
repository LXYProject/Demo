//
//  RegisterHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterHeadCell.h"
#import "LoginDataModel.h"  

@interface RegisterHeadCell ()


@end
@implementation RegisterHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.cornerRadius = self.headIcon.bounds.size.width * 0.5;
    self.headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
