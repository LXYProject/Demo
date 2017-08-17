//
//  SolicitOneRowCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/8/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SolicitOneRowCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (nonatomic,copy)Id_Block textFieldBlock;

@end
