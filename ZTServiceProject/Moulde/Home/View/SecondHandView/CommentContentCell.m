//
//  CommentContentCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommentContentCell.h"
#import "SecondHandModel.h"
#import "CommentUserModel.h"

@interface CommentContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *dzBtn;
@property (weak, nonatomic) IBOutlet UIButton *plBtn;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *comments;

@end
@implementation CommentContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)ThumbupbtnClick {
}
- (IBAction)commentsBtnClick {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SecondHandModel *)model{
    
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _time.text = model.createTime;
    _title.text = model.secondHandTitle;

}

- (void)setUserModel:(CommentUserModel *)userModel {
    
        _userModel = userModel;
        NSString *str1 = userModel.userName;
        NSString *str2 = userModel.targetUserName;
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:str1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"回复" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
        NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:str2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@",userModel.comment] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4e4e4e)}];
        [attr appendAttributedString:attr1];
        if (userModel.targetUserName.length>0) {
            [attr appendAttributedString:attr2];
            [attr appendAttributedString:attr3];
        }
        [attr appendAttributedString:attr4];
        _comments.attributedText = attr;

}
@end
