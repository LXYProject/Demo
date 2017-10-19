//
//  HomeBtnItemCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HomeBtnItemCell.h"

@interface HomeBtnItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation HomeBtnItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDict:(NSDictionary *)dict {
    if (!dict) {
        return;
    }
    self.icon.image = [UIImage imageNamed:dict[@"icon"]];
    self.title.text = dict[@"title"];
}

@end
