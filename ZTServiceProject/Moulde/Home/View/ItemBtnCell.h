//
//  ItemBtnCell.h
//  Aa
//
//  Created by 张圆圆 on 17/6/5.
//  Copyright © 2017年 张圆圆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemBtnCell : UITableViewCell
@property (nonatomic,copy)Int_Block btnClickBlock;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)NSArray *titleAndImageDictArray;
@end
