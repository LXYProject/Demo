//
//  CommentContentCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondHandModel;
@class CommentUserModel;

@interface CommentContentCell : UITableViewCell

@property (strong, nonatomic) SecondHandModel *model;
@property (nonatomic, strong) CommentUserModel *userModel;


@end
