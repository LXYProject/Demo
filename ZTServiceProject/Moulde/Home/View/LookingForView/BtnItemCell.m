//
//  BtnItemCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BtnItemCell.h"
#import "GBFlatSelectableButton.h"
#import "UIColor+GBFlatButton.h"

@interface BtnItemCell ()
@property (weak, nonatomic) IBOutlet GBFlatButton *btnOne;

@end
@implementation BtnItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.btnOne.buttonColor = [UIColor gb_redColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
