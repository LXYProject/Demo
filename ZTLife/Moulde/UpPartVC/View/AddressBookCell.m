//
//  AddressBookCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddressBookCell.h"
#import "AddressBookModel.h"

@interface AddressBookCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;

@end

@implementation AddressBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(AddressBookModel *)model{
    _model = model;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl?model.headImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.propertyUserName;
    _details.text = model.genderStr;
}
@end
