//
//  MySpareCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MySpareCell.h"
#import "SecondHandModel.h"
#import "MessagePhotoModel.h"

@interface MySpareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *saleState;
@property (nonatomic,copy)NSString *url;

@end
@implementation MySpareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SecondHandModel *)model{
    
    _model = model;
    
//    for (MessagePhotoModel *photoModel in model.secondHandNormalImageList) {
//        self.url = photoModel.url;
//    }
//    
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    //这string 就是你获取imgae的字符串
    NSArray *array = [model.imageUrlList componentsSeparatedByString:@","];
    if (array.count>0) {
        
        //写你要取值神马的！
        _url = array[0];
    }
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _headIcon.contentMode=UIViewContentModeScaleAspectFill;
    _headIcon.clipsToBounds=YES;

    _title.text = model.secondHandTitle;
    _details.text = model.secondHandContent;
    _price.text = [NSString stringWithFormat:@"￥%.0f",[model.secPrice doubleValue]];
    _time.text = model.createTime;
    if ([model.postStatus intValue] ==0) {
        _saleState.text = @"已下架";
    }else{
        _saleState.text = @"出售中";
    }

    
}
@end
