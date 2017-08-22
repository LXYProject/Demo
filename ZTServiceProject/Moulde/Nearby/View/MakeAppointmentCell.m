//
//  MakeAppointmentCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MakeAppointmentCell.h"
#import "ServiceModel.h"    

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
    if (_maxNum ==0) {
        _maxNum = 10;
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ServiceModel *)model {
    _model = model;
    _titleLable.text = model.userName;
    _detailsLabel.text = model.createDate;
    _priceLabel.text = [NSString stringWithFormat:@"%2f/%@", [model.price doubleValue], model.unit];
    
}
- (IBAction)addBtnClick:(UIButton *)sender {
    self.currentNum++;
    if (_currentNum>=_maxNum) {
        sender.enabled = NO;
    }
    else {
        sender.enabled  = YES;
    }
    self.reductionBtn.enabled = YES;
}

- (IBAction)reductionBtnClick:(UIButton *)sender {
    self.currentNum--;
    if (_currentNum<=1) {
        sender.enabled = NO;
    }
    else {
        sender.enabled = YES;
    }
    self.addBtn.enabled = YES;
}

- (void)setCurrentNum:(NSInteger)currentNum {
    _currentNum = currentNum;
    if (_currentNum==0) {
        _currentNum = 1;
        self.reductionBtn.enabled = NO;
    }
    if (self.selectFinishedBlock) {
        self.selectFinishedBlock(_currentNum);
    }
    _countLabel.text = [NSString stringWithFormat:@"%ld",_currentNum];
}

- (void)setMaxNum:(NSInteger)maxNum {
    _maxNum = maxNum;
}

@end
