//
//  NearByCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByCell.h"
#import "ServiceModel.h"
@interface NearByCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *sold;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (nonatomic,copy)NSString *url;

@end
@implementation NearByCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ServiceModel *)model {
    _model =  model;
    
    //self.itemDataSourceArray[value][@"vcName"]

    for (NSDictionary *dic in model.smallImageList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
//        NSLog(@"imageUrl==%@", imageUrl);
        self.url = imageUrl;
    }
    
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];

    
//    [_icon sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.bounds.size.width * 0.5;
    _headImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _title.text = model.title;
    _userName.text = model.userName;
    _price.text = [NSString stringWithFormat:@"%@/单", model.price];
//    _price.text = [NSString stringWithFormat:@"%.0f/单",[model.price doubleValue]];
    _content.text = model.content;
}

@end
