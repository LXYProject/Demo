//
//  AnnounceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AnnounceCell.h"
#import "AnnounceModel.h"

@interface AnnounceCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *bulletinCategory;
@property (weak, nonatomic) IBOutlet UILabel *bulletinSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation AnnounceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AnnounceModel *)model
{
    _model = model;
    
    _title.text = model.bulletinTitle;
    [_bulletinCategory setTitle:model.bulletinCategory forState:UIControlStateNormal];
    _bulletinSubtitle.text = model.bulletinSubtitle;
    _time.text = model.createTime;
}
@end
