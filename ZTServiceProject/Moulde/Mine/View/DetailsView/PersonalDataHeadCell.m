//
//  PersonalDataHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PersonalDataHeadCell.h"
#import "CommunityPeopleModel.h"

@interface PersonalDataHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIocn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *oldBtn;
@end
@implementation PersonalDataHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.genderBtn.layer.masksToBounds = YES;
    self.genderBtn.layer.cornerRadius = self.genderBtn.bounds.size.width * 0.1;
    self.genderBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.oldBtn.layer.masksToBounds = YES;
    self.oldBtn.layer.cornerRadius = self.oldBtn.bounds.size.width * 0.1;
    self.oldBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.oldBtn.backgroundColor = [UIColor orangeColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityPeopleModel *)model{
    
    _model = model;
    
    
    [_headIocn sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _titleLabel.text = model.userName;
    
    if ([model.userGender integerValue]==0) {
        [_genderBtn setTitle:@"男" forState:UIControlStateNormal];
        _genderBtn.backgroundColor = [UIColor cyanColor];
    }else{
        [_genderBtn setTitle:@"女" forState:UIControlStateNormal];
        _genderBtn.backgroundColor = [UIColor colorWithRed:253.0/255 green:106.0/255 blue:214.0/255 alpha:1];
    }
    
    [_oldBtn setTitle:[NSString stringWithFormat:@"%@岁", model.userAge] forState:UIControlStateNormal];

}
@end
