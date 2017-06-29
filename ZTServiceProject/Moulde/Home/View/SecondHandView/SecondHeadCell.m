//
//  SecondHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/29.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHeadCell.h"
#import "SecondHandModel.h" 

@interface SecondHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation SecondHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SecondHandModel *)model {
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _name.text = model.onwerName;
    _time.text = model.createTime;
    _price.text = [NSString stringWithFormat:@"￥%.0f",[model.secPrice doubleValue]];
    
}

@end
