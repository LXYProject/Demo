//
//  CommentInfoCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommentInfoCell.h"
#import "CommentUserModel.h"
#import "NeighborCircleModel.h"
#import "SecondCommentModel.h"
@interface CommentInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *commentLable;

@end

@implementation CommentInfoCell
{
    CommentUserModel *_userModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CommentUserModel *)model {
    _model = model;
    if (model) {
        NSString *str1 = model.userName;
        NSString *str2 = model.targetUserName;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        
        NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        [attr appendAttributedString:attr1];
        if (![model.userId isEqualToString:model.targetUserId]) {
            NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
            NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:str2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
            if (model.targetUserName.length>0) {
                [attr appendAttributedString:attr2];
                [attr appendAttributedString:attr3];
            }
        }
        NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",model.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
        [attr appendAttributedString:attr4];
        _commentLable.attributedText = attr;
    }
}

- (void)setSecondModel:(SecondCommentModel *)secondModel{
    _secondModel = secondModel;
    if (!secondModel) {
        return;
    }
    //创建一个可变的字符串 ，把所有的评论内容和人物都放在里面
    NSString *str1 = secondModel.userName;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    [attr appendAttributedString:attr1];
    
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",secondModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
    [attr appendAttributedString:attr2];
    
    
    
    if (secondModel.subCommentList.count>0) {
        [secondModel.subCommentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSAttributedString *lineSpace = [[NSAttributedString alloc]initWithString:@"\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
            [attr appendAttributedString:lineSpace];
            CommentUserModel *userModel = obj;
            NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:userModel.userName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
            [attr appendAttributedString:attr3];
            if (![userModel.userId isEqualToString:userModel.targetUserId]) {
                NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
                NSAttributedString *attr5 = [[NSAttributedString alloc]initWithString:userModel.targetUserName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
                if (userModel.targetUserName.length>0) {
                    [attr appendAttributedString:attr4];
                    [attr appendAttributedString:attr5];
                }
            }
            NSAttributedString *attr6 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",userModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
            [attr appendAttributedString:attr6];
        }];
    }
    _commentLable.attributedText = attr;
}
@end
