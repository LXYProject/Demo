//
//  SecondHanditemCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHanditemCell.h"

@interface SecondHanditemCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageLable;

@end

@implementation SecondHanditemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _messageLable.text= title;
}

@end
