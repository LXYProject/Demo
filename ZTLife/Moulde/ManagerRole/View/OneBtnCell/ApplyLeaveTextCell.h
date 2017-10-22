//
//  DoorServiceCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceTextView;
@interface ApplyLeaveTextCell : UITableViewCell
@property (nonatomic,copy)Id_Block textViewBlock;
@property (weak, nonatomic) IBOutlet PlaceTextView *textView;
@end
