//
//  SecondBannerCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondBannerCell.h"
#import <SDCycleScrollView.h>
#import "AdvertisementModel.h"
#import "MessagePhotoModel.h"
@interface SecondBannerCell ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@end
@implementation SecondBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bannerView.delegate = self;
    self.bannerView.autoScroll = YES;
    self.bannerView.showPageControl = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    NSMutableArray *imageURLArray = [NSMutableArray arrayWithCapacity:1];
    for (AdvertisementModel *model in modelArray) {
        [imageURLArray addObject:model.imageUrl];
    }
    self.bannerView.imageURLStringsGroup = imageURLArray;
    
    //    self.bannerView.localizationImageNamesGroup = modelArray;
}


- (void)setSecondModelArray:(NSArray *)secondModelArray
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    [secondModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessagePhotoModel *model = obj;
        if (model.url){
            [array addObject:model.url];
        }
    }];
    self.bannerView.imageURLStringsGroup = array;

}
@end
