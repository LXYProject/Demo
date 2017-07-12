//
//  MyDoorServiceCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyDoorServiceCell.h"
#import "MyDoorServiceModel.h"

@interface MyDoorServiceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ServiceType;
@property (weak, nonatomic) IBOutlet UILabel *theEvent;
@property (weak, nonatomic) IBOutlet UIButton *initiateBtn;
@property (nonatomic,copy)NSString *url;
@end
@implementation MyDoorServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.initiateBtn.layer.masksToBounds = YES;
    [self.initiateBtn.layer setBorderWidth:1.0];   //边框宽度
    self.initiateBtn.layer.cornerRadius = self.initiateBtn.bounds.size.width * 0.08;
    self.initiateBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyDoorServiceModel *)model{
    
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.houseName;
    _ServiceType.text = model.serviceCategory;
    _theEvent.text = model.serviceDiscribe;
    [_initiateBtn setTitle:model.status forState:UIControlStateNormal];
    
}
- (IBAction)initiateBtnClick {
}

@end
