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
    
//    for (NSDictionary *dic in model.normalImageList) {
//        NSString *imageUrl = [dic objectForKey:@"url"];
//        self.url = imageUrl;
//    }

//    [_icon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    //这string 就是你获取imgae的字符串
    NSArray *array = [model.imageUrl componentsSeparatedByString:@","];
    if (array.count>0) {
        
        //写你要取值神马的！
        _url = array[0];
    }
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _icon.contentMode=UIViewContentModeScaleAspectFill;
    _icon.clipsToBounds=YES;
    
    _headIcon.layer.masksToBounds = YES;
    _headIcon.layer.cornerRadius = _headIcon.bounds.size.width * 0.5;
    _headIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userHeaderImageUrl?model.userHeaderImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _name.text = model.userName;
//    _price.text = model.price;
    _price.text = [NSString stringWithFormat:@"%@元", model.price];
//    _price.text = [NSString stringWithFormat:@"%.0f元",[model.price doubleValue]];
    _detail.text = model.content;
    _title.text = model.title;
    _address.text = model.address;
}

@end
