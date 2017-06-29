//
//  DetailsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/29.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DetailsCell.h"

@interface DetailsCell ()
@property (weak, nonatomic) IBOutlet UILabel *villagersName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *address;


@end
@implementation DetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callBtnClick {
}

@end
