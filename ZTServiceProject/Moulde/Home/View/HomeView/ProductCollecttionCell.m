//
//  ProductCollecttionCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ProductCollecttionCell.h"
#import "SecondHandModel.h"
#import "MessagePhotoModel.h"
@interface ProductCollecttionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic,copy)NSString *url;

@end

@implementation ProductCollecttionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SecondHandModel *)model {
    _model = model;
    
    for (MessagePhotoModel *photoModel in model.secondHandNormalImageList) {
        self.url = photoModel.url;
    }

    [_icon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.secondHandTitle;
    _price.text = [NSString stringWithFormat:@"￥%.0f",[model.secPrice doubleValue]];
    
}

@end
