//
//  BaseTableView.h
//  CarMortgage
//
//  Created by zhangyy on 2017/5/17.
//  Copyright © 2017年 FinupGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView
/**
 *  设置下拉刷新（不实现则默认没有下拉刷新）
 *
 *  @param refreshBlock 下拉刷新事件回调
 */
- (void)setHeaderRefreshBlock:(void(^)())refreshBlock;
/**
 *  设置上拉加载（不实现则默认没有上拉加载）
 *
 *  @param refreshBlock 上拉加载事件回调
 */
- (void)setFooterRefreshBlock:(void(^)())refreshBlock;
/**
 *  开始刷新
 */
- (void)beginHeaderRefreshing;
/**
 *  开始加载
 */
- (void)beginFooterRefreshing;
/**
 *  结束刷新
 */
- (void)endRefreshing;
/**
 *  结束刷新，显示没有更多数据
 */
- (void)endRefreshingWithNoMoreData;
@end
