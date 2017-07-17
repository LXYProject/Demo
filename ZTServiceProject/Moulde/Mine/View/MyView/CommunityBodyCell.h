//
//  HouseBodyCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    completion_Type,    //补全物业信息
    CancelAttention_Type//取消关注
}BtnType;


@class MyNeighborModel;
@interface CommunityBodyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *completionBtn;

@property (nonatomic,strong)MyNeighborModel *model;

@property (nonatomic,assign)BtnType type;

@property (nonatomic,copy)BtnClickBlock btnClickBlock;


@end
