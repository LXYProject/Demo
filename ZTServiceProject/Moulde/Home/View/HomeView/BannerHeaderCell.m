//
//  BannerHeaderCell.m
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BannerHeaderCell.h"
#import <SDCycleScrollView.h>
#import "AdvertisementModel.h"

@interface BannerHeaderCell()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@end

@implementation BannerHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
    if (index==0) {
        [PushManager pushViewControllerWithName:@"BannerJumpController" animated:YES block:nil];
    }else{
        
    }
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

@end
