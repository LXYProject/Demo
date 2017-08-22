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
#import "HomeHttpManager.h" 

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SecondHandModel *)model{
    
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _time.text = model.createTime;
    _title.text = model.secondHandTitle;

}

- (void)setUserModel:(CommentUserModel *)userModel {
    NSLog(@"commentId==%@", _userModel.commentId);
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
//- (void)requestReplyData :(CommentUserModel *)commentUserModel text:(NSString *)text{

- (IBAction)ThumbupbtnClick {
    NSLog(@"secondHandId==%@", _model.secondHandId);
    NSLog(@"commentId==%@", _userModel.commentId);
    [HomeHttpManager requestSecondHandId:_model.secondHandId
                               commentId:_userModel.commentId
                                      success:^(id response) {
                                          
                                          if (self.commentSuccessBlock) {
                                              self.commentSuccessBlock(response);
                                          }
                                          
//                                     //状态码
//                                     NSString *status = [response objectForKey:@"status"];
//                                     if ([status integerValue]==0) {
//                                         //这个代码放在网络请求的成功回调里面
//                                         if (self.commentSuccessBlock) {
//                                             self.commentSuccessBlock(response);
//                                         }
//                                     }
                                 } failure:^(NSError *error, NSString *message) {
                                     
                                 }];
    
}


- (IBAction)commentsBtnClick {
}

@end
