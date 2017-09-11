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
@property (weak, nonatomic) IBOutlet ACSelectMediaView *mediaView;
@property (nonatomic,copy)Int_Block btnClickBlock;
@property (nonatomic,copy)SelectFinishedBlock finishedBlock;
@property (nonatomic,assign)NSInteger maxCount;


- (void)setImageMaxCount:(NSInteger)imageMaxCount imageArray:(NSArray *)imageArray;
@end
