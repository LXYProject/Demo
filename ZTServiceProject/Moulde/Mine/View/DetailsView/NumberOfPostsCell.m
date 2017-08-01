//
//  NumberOfPostsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NumberOfPostsCell.h"

@interface NumberOfPostsCell ()
@property (weak, nonatomic) IBOutlet UILabel *PostNumber;

@end
@implementation NumberOfPostsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
