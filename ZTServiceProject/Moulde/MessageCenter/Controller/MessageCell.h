//
//  MessageCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageCell : UITableViewCell
@property (nonatomic,strong)MessageModel* model;
@property (nonatomic,copy)Void_Block reloadBlock;
@end
