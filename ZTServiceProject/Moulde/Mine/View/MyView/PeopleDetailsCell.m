//
//  ChatFriendsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PeopleDetailsCell.h"
#import "CommunityPeopleModel.h"

@interface  PeopleDetailsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UIButton *genderBtn;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@end
@implementation PeopleDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.genderBtn.layer.masksToBounds = YES;
    self.genderBtn.layer.cornerRadius = self.genderBtn.bounds.size.width * 0.1;
    self.genderBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.ageBtn.layer.masksToBounds = YES;
    self.ageBtn.layer.cornerRadius = self.ageBtn.bounds.size.width * 0.1;
    self.ageBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.ageBtn.backgroundColor = [UIColor orangeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityPeopleModel *)model{
    
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.userName;
    _details.text = model.userProfile;
    
    if ([model.userGender integerValue]==0) {
        [_genderBtn setTitle:@"男" forState:UIControlStateNormal];
        _genderBtn.backgroundColor = [UIColor cyanColor];
    }else{
        [_genderBtn setTitle:@"女" forState:UIControlStateNormal];
        _genderBtn.backgroundColor = [UIColor colorWithRed:253.0/255 green:106.0/255 blue:214.0/255 alpha:1];
    }
    
    [_ageBtn setTitle:[NSString stringWithFormat:@"%@岁", model.userAge] forState:UIControlStateNormal];
}
@end
