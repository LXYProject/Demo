//
//  CommentInfoCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentUserModel;
@class SecondCommentModel;

@interface CommentInfoCell : UITableViewCell
@property (nonatomic,strong)CommentUserModel *model;
@property (nonatomic,strong)SecondCommentModel *secondModel;

@end
