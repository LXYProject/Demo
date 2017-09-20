//
//  ServiceBodyCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceBodyCell.h"
#import "BuyOrderModel.h"   
#import "HelpOrderModel.h"

@interface ServiceBodyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *priceTime;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (nonatomic, copy) NSString *url;

@end
@implementation ServiceBodyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BuyOrderModel *)model {
    _model =  model;
    
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.userIcon?model.userIcon:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//    
//    _title.text = model.serviceTitle;
//    _details.text = model.serviceContent;
//    _price.text = model.servicePrice;
    
    NSArray *array = [model.buyerHeaderImageUrl componentsSeparatedByString:@","];
    if (array.count>0) {
        
        //写你要取值神马的！
        _url = array[0];
    }
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _headIcon.contentMode=UIViewContentModeScaleAspectFill;
    _headIcon.clipsToBounds=YES;


    _title.text = model.serviceTitle;
    _details.text = model.serviceContent;
    _price.text = model.servicePrice;
    _priceTime.text = [NSString stringWithFormat:@"%@/个", model.servicePrice];
}

- (void)setHelpOrderModel:(HelpOrderModel *)helpOrderModel
{
    _helpOrderModel = helpOrderModel;
    
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:helpOrderModel.serviceImg?helpOrderModel.serviceImg:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//    _title.text = helpOrderModel.serviceTitle;
//    _details.text = helpOrderModel.serviceDescribe;
//    _price.text = helpOrderModel.servicePrice;
    
    NSArray *array = [helpOrderModel.appealImageUrl componentsSeparatedByString:@","];
    if (array.count>0) {
        
        //写你要取值神马的！
        _url = array[0];
    }
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _headIcon.contentMode=UIViewContentModeScaleAspectFill;
    _headIcon.clipsToBounds=YES;

    _title.text = helpOrderModel.appealerName;
    _details.text = helpOrderModel.appealContent;
    _price.text = helpOrderModel.appealPrice;
    _priceTime.text = [NSString stringWithFormat:@"%@/个", helpOrderModel.appealPrice];
}
@end
