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
    
    NSString *str1 = secondModel.userName;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    [attr appendAttributedString:attr1];
    
    NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",secondModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
    [attr appendAttributedString:attr4];
    _commentLable.attributedText = attr;


    
    if (secondModel) {
        
        [_secondModel.subCommentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            _userModel = obj;
            
            NSString *str1 = _userModel.userName;
            NSString *str2 = _userModel.targetUserName;
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
            NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
            [attr appendAttributedString:attr1];
            if (![_userModel.userId isEqualToString:_userModel.targetUserId]) {
                NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
                NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:str2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
                if (_userModel.targetUserName.length>0) {
                    [attr appendAttributedString:attr2];
                    [attr appendAttributedString:attr3];
                }
            }
            NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",_userModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
            [attr appendAttributedString:attr4];
            _commentLable.attributedText = attr;
        
        }];

    }

}
@end
