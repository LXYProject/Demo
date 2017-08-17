//
//  MakeAppointmentCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MakeAppointmentCell.h"

@interface MakeAppointmentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *reductionBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation MakeAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addBtnClick {
    
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.bookModel.count];
//    self.addBtn.enabled = YES;
//    
//    [self.delegate bookCellDidClickPlusButton:self];

}

- (IBAction)reductionBtnClick {
    
//    self.bookModel.count--;
//    self.countLabel.text = [NSString stringWithFormat:@"%ld",self.bookModel.count];
//    if (self.bookModel.count == 0) {
//        self.addBtn.enabled = NO;
//    }
//    
//    [self.delegate bookCellDidClickMinusButton:self];

}

@end
