//
//  LeaveHistoryCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LeaveHistoryCell.h"
#import "LeaveHistoryModel.h"

@interface LeaveHistoryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *states;
@property (weak, nonatomic) IBOutlet UILabel *leaveType;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *approver;
@property (weak, nonatomic) IBOutlet UILabel *approvalTime;
@property (weak, nonatomic) IBOutlet UILabel *approvalState;
@property (weak, nonatomic) IBOutlet UILabel *approvalOpinion;

@end
@implementation LeaveHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LeaveHistoryModel *)model{
    _model = model;
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl?model.headImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//    _name.text = model.applyUserName;
//    _time.text = model.applyUserDeptName;
//    if ([model.approveStatus integerValue]==0) {
//        _states.text = @"未审批";
//    }else if ([model.approveStatus integerValue]==1){
//        _states.text = @"审批同意";
//    }else{
//        _states.text = @"审批同意";
//    }
//    _leaveType.text = model.leaveTypeName;
//    _details.text = model.leaveDetails;
//    _startTime.text = model.startTime;
//    _endTime.text = model.endTime;
//    _approver.text = model.approveUserName;
//    _approvalTime.text = model.applyTime;
//    _approvalState.text = model.approveStatus;
//    _approvalOpinion.text = model.approveMessage;
}
@end
