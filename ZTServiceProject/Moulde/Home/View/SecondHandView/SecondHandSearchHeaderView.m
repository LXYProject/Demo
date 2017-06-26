//
//  SecondHandSearchHeaderView.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHandSearchHeaderView.h"

@interface SecondHandSearchHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation SecondHandSearchHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setText:(NSString *)text {
    _title.text= text;
}

@end
