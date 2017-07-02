//
//  SecondAddressCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondAddressCell.h"
#import "SecondHandModel.h"

@interface SecondAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *thumbup;
@property (weak, nonatomic) IBOutlet UILabel *comments;

@end
@implementation SecondAddressCell

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
    
    _address.text = _model.address.length>0?_model.address:@"未知位置";
    _thumbup.text = model.isLiked;
    _comments.text = model.commentCount;

}

@end
