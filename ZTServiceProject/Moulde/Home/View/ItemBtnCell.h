//
//  ItemBtnCell.h
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemBtnCell : UITableViewCell
@property (nonatomic,copy)Int_Block btnClickBlock;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)NSArray *titleAndImageDictArray;
@end
