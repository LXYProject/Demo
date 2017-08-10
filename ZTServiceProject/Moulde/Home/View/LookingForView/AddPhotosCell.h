//
//  AddPhotosCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTools.h"
#import "ACSelectMediaView.h"
typedef void(^SelectFinishedBlock)(NSArray* images);

@interface AddPhotosCell : UITableViewCell
@property (nonatomic,strong)NSArray *imagesArray;
@property (nonatomic,strong) ACSelectMediaView* mediaView;
@property (nonatomic,copy)Int_Block btnClickBlock;
@property (nonatomic,copy)SelectFinishedBlock finishedBlock;
@end
