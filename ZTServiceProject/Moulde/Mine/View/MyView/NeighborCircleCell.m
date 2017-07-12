//
//  NeighborCircleCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborCircleCell.h"
#import "NeighborCircleModel.h"

@interface NeighborCircleCell ()
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *photosCount;
@property (weak, nonatomic) IBOutlet UILabel *ThumbCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;



@property (nonatomic, copy) NSString *url;

@end
@implementation NeighborCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NeighborCircleModel *)model{
    _model = model;
    
    for (NSDictionary *dic in model.topicSmallImageList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
        self.url = imageUrl;
    }

    [_headIcon sd_setImageWithURL:[NSURL URLWithString:_url?_url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _createTime = model.createTime;
    
    _year = [model.createTime substringToIndex:4];
    NSString *mouthsTime = [model.createTime substringToIndex:7];
    _months = [mouthsTime substringFromIndex:5];
    
    _day.text = [self day:[self dateformatter:model.createTime]];
    _address.text = model.address;
    
    _title.text = model.topicTitle;
    _photosCount.text = [NSString stringWithFormat:@"共%ld张", model.topicSmallImageList.count];
    _ThumbCount.text = [NSString stringWithFormat:@"%ld", model.likeList.count];
    _commentsCount.text = model.commentCount;



}

- (NSDate *)dateformatter :(NSString *)str {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formaterDate = [dateFormatter dateFromString:str];
    return formaterDate;
}

- (NSString *)day:(NSDate *)formaterDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd日"];
    return [formatter stringFromDate:formaterDate];
}

@end
