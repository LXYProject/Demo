//
//  OrderBodyCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/5.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "OrderBodyCell.h"
#import "BuyOrderModel.h"
#import "HelpOrderModel.h"

@interface OrderBodyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation OrderBodyCell

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
    
    _headIcon.layer.masksToBounds = YES;
    _headIcon.layer.cornerRadius = _headIcon.bounds.size.width * 0.5;
    _headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userIcon?model.userIcon:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _name.text = model.userName;
    _time.text = model.appointmentTime;
}

- (void)setHelpOrderModel:(HelpOrderModel *)helpOrderModel
{
    _helpOrderModel = helpOrderModel;
    
    _headIcon.layer.masksToBounds = YES;
    _headIcon.layer.cornerRadius = _headIcon.bounds.size.width * 0.5;
    _headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:helpOrderModel.serviceUserIcon?helpOrderModel.serviceUserIcon:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _name.text = helpOrderModel.serviceUserName;
    _time.text = helpOrderModel.serviceTime;
}

// 电话
- (IBAction)callPhone {
    NSLog(@"电话");
}

// 对话
- (IBAction)dialogue {
    NSLog(@"对话");

}

@end
