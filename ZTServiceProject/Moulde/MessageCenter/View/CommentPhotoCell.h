//
//  CommentPhotoCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;
@interface CommentPhotoCell : UITableViewCell
@property (nonatomic,strong)MessageModel* model;
@end