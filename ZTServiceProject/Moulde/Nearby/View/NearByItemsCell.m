//
//  NearByItemsCell.m
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByItemsCell.h"
#import "NearByItemModel.h"

@interface NearByItemsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *sexIcon;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end

@implementation NearByItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NearByItemModel *)model {
    _model =  model;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _name.text = model.userName;
    _price.text = model.price;
    _detail.text = model.content;
    _title.text = model.title;
    _address.text = model.address;
}

@end
