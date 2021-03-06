//
//  CommentsHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommentsHeadCell.h"
#import "SecondHandModel.h"

@interface CommentsHeadCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;

@end
@implementation CommentsHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SecondHandModel *)model{
    
    _model = model;
    
    _commentsCount.text = [NSString stringWithFormat:@"评论(%@)", model.commentCount];
    
}
@end
