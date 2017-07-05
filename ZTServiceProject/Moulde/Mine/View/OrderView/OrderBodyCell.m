//
//  OrderBodyCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/5.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "OrderBodyCell.h"

@interface OrderBodyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation OrderBodyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 电话
- (IBAction)callPhone {
    NSLog(@"电话");
}

// 对话
- (IBAction)dialogue {
    NSLog(@"对话");

}

@end
