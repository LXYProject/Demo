//
//  CommentPhotoCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel;
@interface CommentPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 存放小图和大图
 
 @param smallImgs 小图
 @param normalImg 大图
 */
- (void)smallImgs:(NSArray *)smallImgs
       normalImgs:(NSArray *)normalImg;

@end
