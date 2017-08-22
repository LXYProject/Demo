//
//  SecondUserCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondUserCell.h"
#import "SecondHandModel.h"

@interface SecondUserCell ()
@end
@implementation SecondUserCell

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
        
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _name.text = model.onwerName;
    _time.text = model.createTime;
    _presentPrice.text = [NSString stringWithFormat:@"￥%.0f",[model.secPrice doubleValue]];
    _originalPrice.text = [NSString stringWithFormat:@"￥%.0f",[model.oriPrice doubleValue]];

}

@end
