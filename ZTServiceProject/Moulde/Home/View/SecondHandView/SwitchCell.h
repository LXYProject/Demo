//
//  SwitchCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/19.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *details;

@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,assign)CGFloat cellHeight;


@end
