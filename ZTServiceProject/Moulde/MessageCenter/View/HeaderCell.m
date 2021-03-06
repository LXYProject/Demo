//
//  HeaderCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HeaderCell.h"
#import "MessageModel.h"
#import "NeighborCircleModel.h"

@interface HeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end

@implementation HeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    if (model) {
        _headerIcon.layer.masksToBounds = YES;
        _headerIcon.layer.cornerRadius = _headerIcon.bounds.size.width * 0.5;
        _headerIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        [_headerIcon sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
        _name.text = model.ownerName;
        _time.text = model.createTime;
        _message.text = model.topicTitle;
        
        _topicId = model.topicId;
    }
}

- (void)setNeighborCircleModel:(NeighborCircleModel *)neighborCircleModel{
    
    _neighborCircleModel = neighborCircleModel;
    if (neighborCircleModel) {
        _headerIcon.layer.masksToBounds = YES;
        _headerIcon.layer.cornerRadius = _headerIcon.bounds.size.width * 0.5;
        _headerIcon.layer.borderColor = [UIColor whiteColor].CGColor;
        [_headerIcon sd_setImageWithURL:[NSURL URLWithString:neighborCircleModel.ownerImageUrl?neighborCircleModel.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
        _name.text = neighborCircleModel.ownerName;
        _time.text = neighborCircleModel.createTime;
        _message.text = neighborCircleModel.topicTitle;
        
        _topicId = neighborCircleModel.topicId;
    }

}
@end
