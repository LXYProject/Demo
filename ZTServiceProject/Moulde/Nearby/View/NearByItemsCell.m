//
//  NearByItemsCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
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
@property (nonatomic,copy)NSString *url;

@end

@implementation NearByItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NearByItemModel *)model {
    _model =  model;
    
    for (NSDictionary *dic in model.normalImageList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
//        NSLog(@"imageUrl==%@", imageUrl);
        self.url = imageUrl;
    }

    [_icon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    
//    _price.text = model.price;

    _price.text = [NSString stringWithFormat:@"%.0f元",[model.price doubleValue]];
    _detail.text = model.content;
    _title.text = model.title;
    _address.text = model.address;
}

@end
