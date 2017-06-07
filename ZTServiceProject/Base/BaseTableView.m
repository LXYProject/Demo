//
//  BaseTableView.m
//  CarMortgage
//
//  Created by zhangyy on 2017/5/17.
//  Copyright © 2017年 FinupGroup. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.separatorColor = UIColorFromRGB(0xe5e5e5);
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self.separatorColor = UIColorFromRGB(0xe5e5e5);
    return  [super initWithFrame:frame style:style];
}

#pragma mark - 设置下拉刷新
- (void)setHeaderRefreshBlock:(void (^)())refreshBlock {
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (refreshBlock) {
            refreshBlock();
        }
    }];
}

#pragma mark - 设置上拉加载
- (void)setFooterRefreshBlock:(void (^)())refreshBlock {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (refreshBlock) {
            refreshBlock();
        }
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
    
}

#pragma mark - 开始刷新
- (void)beginHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

#pragma mark - 开始加载
- (void)beginFooterRefreshing {
    [self.mj_footer beginRefreshing];
}

#pragma mark - 结束刷新
- (void)endRefreshing {
    
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)endRefreshingWithNoMoreData {
    
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshingWithNoMoreData];
}

@end
