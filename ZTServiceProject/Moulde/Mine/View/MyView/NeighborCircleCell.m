//
//  NeighborCircleCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborCircleCell.h"
#import "NeighborCircleModel.h"
#import "MessagePhotoModel.h"
@interface NeighborCircleCell ()
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *photosCount;
@property (weak, nonatomic) IBOutlet UILabel *ThumbCount;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLeft;


@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSMutableArray *imgArr;

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
    
    for  (MessagePhotoModel*dic in model.topicSmallImageList) {
        
        //self.url = dic.url;
        [self.imgArr addObject:dic.url];

    }

    if (model.topicSmallImageList.count==0) {
        self.imgH.constant = 10;
        self.imgW.constant = 0;
        _textLeft.constant = 0;
        _headIcon.hidden = YES;
        _photosCount.hidden = YES;
    }
    else {
        self.imgH.constant = 74;
        self.imgW.constant = 88;
        _textLeft.constant = 15;
        _headIcon.hidden = NO;
        _photosCount.hidden = NO;
        
        self.url = [self.imgArr objectAtIndex:0];
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];

    }
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

- (NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArr;
}
@end
