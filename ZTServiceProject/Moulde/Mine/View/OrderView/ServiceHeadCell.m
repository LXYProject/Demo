//
//  ServiceHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceHeadCell.h"
#import "BuyOrderModel.h"
#import "HelpOrderModel.h"

@interface ServiceHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end
@implementation ServiceHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BuyOrderModel *)model {
    _model =  model;
    
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.cornerRadius = _userIcon.bounds.size.width * 0.5;
    _userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
//    [_userIcon sd_setImageWithURL:[NSURL URLWithString:model.userIcon?model.userIcon:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//
//    _userName.text = model.userName;
//    _orderTime.text = model.createTime;
//    _orderStatus.text = model.statusStr;
    
    
    _userName.text = model.salerName;
    _orderTime.text = model.createDate;
    _orderStatus.text = model.status;


}

-(void)setHelpOrderModel:(HelpOrderModel *)helpOrderModel
{
    _helpOrderModel = helpOrderModel;
    
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.cornerRadius = _userIcon.bounds.size.width * 0.5;
    _userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
//    [_userIcon sd_setImageWithURL:[NSURL URLWithString:helpOrderModel.serviceUserIcon?helpOrderModel.serviceUserIcon:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//    
//    _userName.text = helpOrderModel.serviceUserName;
//    _orderTime.text = helpOrderModel.serviceTime;
//    _orderStatus.text = helpOrderModel.indentStatusStr;
    
    _userName.text = helpOrderModel.appealerName;
    _orderTime.text = helpOrderModel.orderCreateDate;
    _orderStatus.text = helpOrderModel.orderStatus;
}
@end
