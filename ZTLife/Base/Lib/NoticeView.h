//
//  NoticeView.h
//  XianJinDai
//
//  Created by 航哥 on 2017/4/10.
//  Copyright © 2017年 com.hangge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoticeViewDelegate <NSObject>

- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index;

@end

@interface NoticeView : UIView

/**
 图片
 */
@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic,copy)NSString *iconImage;

/**
 定时器的循环时间
 */
@property (nonatomic , assign) NSInteger interval;

@property (nonatomic , assign) id<NoticeViewDelegate> delegate;

///** 本地消息数组 */
@property (nonatomic, strong) NSArray *localizationNoticeGroup;


/**
 创建定时器并run
 */
- (void)startTimer;
@end
