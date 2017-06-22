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
#import "SecondHandModel.h"
#import "RentHouseModel.h"
#import "ServiceModel.h"    

@interface ProductItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailsContent;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, copy) NSString *url;
@end
@implementation ProductItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 去帮忙Model
- (void)setModel:(NearByItemModel *)model {
    _model = model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.userImgUrl?model.userImgUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = model.title;
    _detailsContent.text = model.content;
    _placeLabel.text = model.address;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.0f/天",[model.price doubleValue]];
    _timeLabel.text = [model.createDate substringToIndex:10];//截取掉下标7之后的字符串
}

///找服务model
- (void)setServiceModel:(ServiceModel *)serviceModel
{
    _serviceModel =  serviceModel;
    
    for (NSDictionary *dic in serviceModel.normalImageList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
        self.url = imageUrl;
    }
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = serviceModel.title;
    _detailsContent.text = serviceModel.content;
    _placeLabel.text = serviceModel.address;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@/个", serviceModel.price];
    //    _placeLabel.text = [NSString stringWithFormat:@"%.0f/个",[serviceModel.price doubleValue]];
    _timeLabel.text = [serviceModel.createDate substringToIndex:10];//截取掉下标7之后的字符串

}


// 二手物品Model
- (void)setSecondModel:(SecondHandModel *)secondModel{
    _secondModel = secondModel;
    
    for (NSDictionary *dic in secondModel.secondHandNormalImageList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
//        NSLog(@"imageUrl==%@", imageUrl);
        self.url = imageUrl;
    }
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = secondModel.secondHandTitle;
    _detailsContent.text = secondModel.secondHandContent;
    _placeLabel.text = secondModel.address;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.0f/个",[secondModel.secPrice doubleValue]];
    _timeLabel.text = [secondModel.createTime substringToIndex:10];//截取掉下标7之后的字符串
//    _timeLabel.text = secondModel.createTime;

}

// 租房Model
- (void)setRentHouseModel:(RentHouseModel *)rentHouseModel{
    _rentHouseModel = rentHouseModel;
    
    for (NSDictionary *dic in rentHouseModel.housePicList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
//        NSLog(@"imageUrl==%@", imageUrl);
        self.url = imageUrl;
    }
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = rentHouseModel.houseUseful;
    _detailsContent.text = rentHouseModel.houseType;
    _placeLabel.text = rentHouseModel.address;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.0f/月",[rentHouseModel.rentPrice doubleValue]];
    
    _timeLabel.text = [rentHouseModel.publishTime substringToIndex:10];//截取掉下标7之后的字符串
//    _timeLabel.text = rentHouseModel.publishTime;


}


@end
