//
//  ChatFriendsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "FriendsCell.h"

@interface  FriendsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
@implementation FriendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cancelBtnClick {
}

@end
