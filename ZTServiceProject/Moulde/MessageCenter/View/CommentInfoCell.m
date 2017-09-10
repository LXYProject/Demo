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
#import "UILabel+YBAttributeTextTapAction.h"
#import "TTTAttributeLabelView.h"
@interface CommentInfoCell()<TTTAttributeLabelViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet TTTAttributeLabelView *lable;

@end

@implementation CommentInfoCell
{
    CommentUserModel *_userModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.lable.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CommentUserModel *)model {
    _model = model;
    if (model) {
        _lable.hidden = YES;
        _commentLable.hidden = NO;
        NSString *str1 = model.userName;
        NSString *str2 = model.targetUserName;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        
        NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        [attr appendAttributedString:attr1];
        if (![model.userId isEqualToString:model.targetUserId]&&model.userId&&model.targetUserId) {
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
    _lable.hidden = NO;
    _commentLable.hidden = YES;
    NSMutableArray *strsArray = [NSMutableArray arrayWithCapacity:1];
    //创建一个可变的字符串 ，把所有的评论内容和人物都放在里面
    NSString *str1 = secondModel.userName;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    [attr appendAttributedString:attr1];
    
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",secondModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
    [attr appendAttributedString:attr2];
    if (secondModel.subCommentList.count>0) {
        [secondModel.subCommentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableString *totleStr = [[NSMutableString alloc]initWithCapacity:1];
            NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc]init];
            paragraphstyle.lineBreakMode = NSLineBreakByCharWrapping;
            NSAttributedString *lineSpace = [[NSAttributedString alloc]initWithString:@"\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphstyle}];
            [attr appendAttributedString:lineSpace];
            CommentUserModel *userModel = obj;
            NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:userModel.userName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
            [attr appendAttributedString:attr3];
            [totleStr appendString:attr3.string];
            if (![userModel.userId isEqualToString:userModel.targetUserId]) {
                NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
                [totleStr appendString:attr4.string];
                NSAttributedString *attr5 = [[NSAttributedString alloc]initWithString:userModel.targetUserName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
                [totleStr appendString:attr5.string];
                if (userModel.targetUserName.length>0) {
                    [attr appendAttributedString:attr4];
                    [attr appendAttributedString:attr5];
                }
            }
            NSAttributedString *attr6 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",userModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
            [totleStr appendString:attr6.string];
            [attr appendAttributedString:attr6];
            [strsArray addObject:totleStr];
            NSRange range1 = [attr.string rangeOfString:userModel.comment];
            [_lable addLinkStringRange:range1 flag:[NSString stringWithFormat:@"%lu",(unsigned long)idx]];
        }];
        _lable.attributedString = attr;
        _lable.activeLinkColor = [UIColor lightGrayColor];
        _lable.linkColor = UIColorFromRGB(0x4e4e4e);
        [_lable render];
        [_lable resetSize];
    }
}

- (void)TTTAttributeLabelView:(TTTAttributeLabelView *)attributeLabelView linkFlag:(NSString *)flag {
    NSLog(@"%@", flag);
    NSInteger index = [flag integerValue];
    NSString *commentId = [_secondModel.subCommentList[index] commentId];
#warning 你需要用的commentID
}

@end
