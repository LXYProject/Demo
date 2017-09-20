//
//  PraiseComplaintCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PraiseComplaintCell.h"
#import "MyPraiseModel.h"

@interface PraiseComplaintCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ServiceType;
@property (weak, nonatomic) IBOutlet UILabel *theEvent;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (nonatomic,copy)NSString *url;
@end
@implementation PraiseComplaintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyPraiseModel *)model{
    
    _model = model;
    
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.imageList.firstObject ?model.imageList.firstObject:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
//    _title.text = model.affairTitle;
//    _ServiceType.text = model.affairCategory;
//    _theEvent.text = model.affairDiscribe;
//    _time.text = model.createDate;
    
    
    //这string 就是你获取imgae的字符串
    NSArray *array = [model.imageList componentsSeparatedByString:@","];
    if (array.count>0) {
        
        //写你要取值神马的！
        _url = array[0];
    }
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _headIcon.contentMode=UIViewContentModeScaleAspectFill;
    _headIcon.clipsToBounds=YES;
    _title.text = model.title;
    _ServiceType.text = model.categoryId;
    _theEvent.text = model.content;
    _time.text = model.createDate;

    
}
@end
