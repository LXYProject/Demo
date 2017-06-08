//
//  ProductCollecttionCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ProductCollecttionCell.h"


@interface ProductCollecttionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation ProductCollecttionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
