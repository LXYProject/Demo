//
//  NeighborTextCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/3.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborTextCell.h"
#import "NeighborCircleModel.h"

@interface NeighborTextCell ()

@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ThumbCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;

@end
@implementation NeighborTextCell

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
    

    _day.text = [self day:[self dateformatter:model.createTime]];
    _address.text = model.address;
    
    _title.text = model.topicTitle;
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
