//
//  ProductItemCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ProductItemCell.h"
#import "NearByHeaderCell.h"
#import "NearByItemModel.h"

@interface ProductItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailsContent;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation ProductItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NearByItemModel *)model {
    _model = model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = model.title;
    _detailsContent.text = model.content;
    _placeLabel.text = model.address;
    _priceLabel.text = [NSString stringWithFormat:@"%.0f元",[model.price doubleValue]];

}
@end
