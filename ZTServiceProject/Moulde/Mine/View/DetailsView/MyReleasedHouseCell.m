//
//  MyReleasedHouseCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyReleasedHouseCell.h"
#import "RentHouseModel.h"
#import "ServiceModel.h"
#import "NearByItemModel.h"

@interface MyReleasedHouseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *leaseState;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *StopRentBtn;
@property (nonatomic,copy)NSString *url;

@end
@implementation MyReleasedHouseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.StopRentBtn.layer.masksToBounds = YES;
    self.StopRentBtn.layer.cornerRadius = self.StopRentBtn.bounds.size.width * 0.05;
    self.StopRentBtn.layer.borderColor = [UIColor whiteColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//我发布的出租屋
- (void)setModel:(RentHouseModel *)model{
    
    _model = model;
    
    for (NSDictionary *dic in model.housePicList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
        self.url = imageUrl;
    }
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.houseType;
    _details.text = model.houseUseful;
    _price.text = [NSString stringWithFormat:@"￥%.0f/月",[model.rentPrice doubleValue]];
    
    if ([model.publishStatus intValue] == 0) {
        _leaseState.text = @"停住出租";
    }else{
        _leaseState.text = @"正在出租";
    }
    
}

//我发布的服务
- (void)setServiceModel:(ServiceModel *)serviceModel{
    
    _serviceModel = serviceModel;
    
//    for (NSDictionary *dic in serviceModel.smallImageList) {
//        NSString *imageUrl = [dic objectForKey:@"url"];
//        self.url = imageUrl;
//    }
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:serviceModel.imageUrl?serviceModel.imageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];

    _title.text = serviceModel.title;
    _details.text = serviceModel.content;
    _price.text = [NSString stringWithFormat:@"￥%.0f/%@",[serviceModel.price doubleValue], serviceModel.unit];
    _leaseState.text = serviceModel.statusDesc;
    
    if ([serviceModel.status intValue] == 0) {
        [_StopRentBtn setTitle:@"暂停服务" forState:UIControlStateNormal];
    }else{
        [_StopRentBtn setTitle:@"恢复服务" forState:UIControlStateNormal];
    }
}

//我发布的求助
- (void)setNearByItemModel:(NearByItemModel *)nearByItemModel{
    
    _nearByItemModel = nearByItemModel;
    
//    for (NSDictionary *dic in nearByItemModel.normalImageList) {
//        NSString *imageUrl = [dic objectForKey:@"url"];
//        self.url = imageUrl;
//    }
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:nearByItemModel.userHeaderImageUrl?nearByItemModel.userHeaderImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = nearByItemModel.title;
    _details.text = nearByItemModel.content;
    _price.text = [NSString stringWithFormat:@"%@元/次", nearByItemModel.price];
    _leaseState.text = nearByItemModel.statusDesc;
    [_StopRentBtn setTitle:@"删除" forState:UIControlStateNormal];
    
}
- (IBAction)StopRentBtnClick {
}

@end
