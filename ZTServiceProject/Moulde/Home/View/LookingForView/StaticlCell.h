//
//  StaticlCell.h
//  CellTab
//
//  Created by ZT on 2017/6/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaticlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLeading;

@property (nonatomic,copy)Id_Block textFieldBlock;


@end
