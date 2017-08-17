//
//  PublishServiceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublishServiceCell.h"

@implementation PublishServiceCell
{
    __weak IBOutlet UIButton *btn1;
    __weak IBOutlet UIButton *btn2;
    UIButton *_selectedBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    
    if (selectIndex == 0) {
        [self btnClick:btn1];
    }
    else {
        [self btnClick:btn2];
    }
}


- (IBAction)btnClick:(UIButton *)sender {
    _selectedBtn.selected  = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    
    NSInteger index = sender==btn1?0:1;
    if (self.btnClickBlock) {
        self.btnClickBlock(index);
    }
    
}
@end
