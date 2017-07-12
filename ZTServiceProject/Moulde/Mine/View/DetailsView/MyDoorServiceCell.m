//
//  MyDoorServiceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyDoorServiceCell.h"

@interface MyDoorServiceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ServiceType;
@property (weak, nonatomic) IBOutlet UILabel *theEvent;
@property (weak, nonatomic) IBOutlet UIButton *initiateBtn;

@end
@implementation MyDoorServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.initiateBtn.layer.masksToBounds = YES;
    [self.initiateBtn.layer setBorderWidth:1.0];   //边框宽度
    self.initiateBtn.layer.cornerRadius = self.initiateBtn.bounds.size.width * 0.08;
    self.initiateBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)initiateBtnClick {
}

@end
