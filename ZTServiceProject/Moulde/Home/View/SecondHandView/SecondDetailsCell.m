//
//  SecondDetailsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondDetailsCell.h"

@interface SecondDetailsCell ()


@end
@implementation SecondDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //不限制行数
    _detailsLabel.numberOfLines = 0;

}

-(void)setModel:(Model *)model{
    
    _model = model;
    _titleLabel.text = model.title;
    _detailsLabel.text = model.content;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
