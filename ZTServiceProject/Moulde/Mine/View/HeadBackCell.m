//
//  HeadBackCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HeadBackCell.h"

@interface HeadBackCell  ()

@property (weak, nonatomic) IBOutlet UIImageView *headIcon;


@end
@implementation HeadBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)loginAndRegister {
    
    [PushManager pushViewControllerWithName:@"LoginViewController" animated:YES block:nil];
}

@end
