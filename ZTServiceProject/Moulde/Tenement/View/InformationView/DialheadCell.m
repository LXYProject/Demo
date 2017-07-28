//
//  DialheadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DialheadCell.h"

@interface DialheadCell()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@end
@implementation DialheadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.callBtn.layer.masksToBounds = YES;
//    self.callBtn.layer.cornerRadius = self.callBtn.bounds.size.width * 0.01;
//    self.callBtn.layer.borderColor = [UIColor clearColor].CGColor;
//    
    self.callBtn.layer.masksToBounds = YES;
    self.callBtn.layer.cornerRadius = 4.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callBtnClick:(id)sender {
}

@end
