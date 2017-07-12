//
//  CommentBottomCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeighborCircleModel;

//block传值

@interface NeighborDetailCell : UITableViewCell
@property (nonatomic,strong)NeighborCircleModel* model;
//@property (nonatomic,copy)Int_Block btnClickBlock;
//@property (nonatomic,assign)NSInteger selectIndex;

//#warning 第一步：定义Block属性
@property (nonatomic, copy) void(^secondBlock)(NSString *);

//这个block专门给而外界调用的
@property (nonatomic,copy)Id_Block commentSuccessBlock;

@end
