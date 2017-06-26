//
//  CommentBottomCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;

//block传值

@interface CommentBottomCell : UITableViewCell
@property (nonatomic,strong)MessageModel* model;
//@property (nonatomic,copy)Int_Block btnClickBlock;
//@property (nonatomic,assign)NSInteger selectIndex;

//#warning 第一步：定义Block属性
@property (nonatomic, copy) void(^secondBlock)(NSString *);



@end
