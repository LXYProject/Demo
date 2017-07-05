//
//  BtnSelectCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "OrderSelectCell.h"

@interface OrderSelectCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end
@implementation OrderSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn1.layer.borderColor = UIColorFromRGB(0xe8e8e8).CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)rejectBtn {
    if (self.btnClickIndex) {
        self.btnClickIndex(0);
    }
}
- (IBAction)acceptBtn {
    if (self.btnClickIndex) {
        self.btnClickIndex(1);
    }
}

@end
