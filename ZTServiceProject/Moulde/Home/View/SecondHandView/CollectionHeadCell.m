//
//  CollectionHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/31.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CollectionHeadCell.h"

@interface CollectionHeadCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;


@end
@implementation CollectionHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setText:(NSString *)text {
    _title.text= text;
}

@end
