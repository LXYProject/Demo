//
//  HouseBodyCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HouseBodyCell.h"
#import "MyHouseModel.h"
#import "MineHttpManager.h"
#import "MyHouseViewController.h"

@interface HouseBodyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *leaseState;

@property (nonatomic, copy) NSString *houseId;


@property (nonatomic,copy)NSString *url;


@end
@implementation HouseBodyCell
{
    MyHouseViewController *myHoseVC;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.layer.masksToBounds = YES;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyHouseModel *)model{
    
    _model = model;
    
    for (MyHouseModel *photoModel in model.housePicSmallList) {
        self.url = photoModel.url;
    }
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];

    _title.text = model.zoneName;
    _details.text = model.title;
    _leaseState.text = model.statusOfHouseStr;

}

- (IBAction)removeBinding {
    
    if (self.btnClickBlock) {
        self.btnClickBlock(nil);
    }
}

@end
