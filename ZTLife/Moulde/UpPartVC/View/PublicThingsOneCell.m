//
//  PublicThingsOneCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublicThingsOneCell.h"
#import "PublicThingsOneModel.h"

@interface PublicThingsOneCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *department;
@property (weak, nonatomic) IBOutlet UILabel *leaveType;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@end
@implementation PublicThingsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PublicThingsOneModel *)model{
    _model = model;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl?model.headImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _name.text = model.applyUserName;
    _time.text = model.applyTime;
    _department.text = [NSString stringWithFormat:@"所属部门：%@", model.applyUserDeptName];
    _leaveType.text = model.leaveTypeName;
    _details.text = model.leaveDetails;
    _startTime.text = model.startTime;
    _endTime.text = model.endTime;
}
@end
