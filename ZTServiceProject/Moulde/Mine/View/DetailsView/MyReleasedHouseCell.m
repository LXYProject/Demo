//
//  MyReleasedHouseCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyReleasedHouseCell.h"

@interface MyReleasedHouseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *leaseState;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *StopRentBtn;

@end
@implementation MyReleasedHouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.StopRentBtn.layer.masksToBounds = YES;
    self.StopRentBtn.layer.cornerRadius = self.StopRentBtn.bounds.size.width * 0.05;
    self.StopRentBtn.layer.borderColor = [UIColor whiteColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)StopRentBtnClick {
}

@end
