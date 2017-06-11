//
//  SectionHeaderCell.m
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SectionHeaderCell.h"
#import "NoticeView.h"

@interface SectionHeaderCell()<NoticeViewDelegate>
@property (nonatomic , strong) NSArray *dataArray;

@property (weak, nonatomic) IBOutlet NoticeView *noticeView;

@end

@implementation SectionHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _noticeView.delegate = self;
    _noticeView.interval = 2;
}

- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index{
    NSLog(@"%@",_notificationNews[index]);
}

- (void)setNotificationNews:(NSArray *)notificationNews {
    _noticeView.localizationNoticeGroup =notificationNews;
    [_noticeView startTimer];
}
@end
