//
//  CommentBottomCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommentBottomCell.h"
#import "MessageModel.h"
#import "CommentUserModel.h"
@interface CommentBottomCell()<UITextFieldDelegate>
//地址
@property (weak, nonatomic) IBOutlet UILabel *address;
//评论的输入框
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
//显示赞
@property (weak, nonatomic) IBOutlet UILabel *supportLable;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *thumbUpNumber;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UILabel *shareNumber;
@end

@implementation CommentBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentTextField.delegate = self;//设置代理
    self.commentTextField.enablesReturnKeyAutomatically = YES;
    self.commentTextField.returnKeyType = UIReturnKeySend;//变为搜索按钮

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    if (_model) {
        _address.text = _model.address.length>0?_model.address:@"未知位置";
        _thumbUpNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)model.likeList.count];
        _comments.text = model.commentCount;
        NSMutableString *likeStr = [[NSMutableString alloc]initWithCapacity:1];
        [_model.likeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentUserModel *userModel = obj;
            [likeStr appendString:[NSString stringWithFormat:@"%@ ",userModel.userName]];
            if (idx == 11) {
                *stop = YES;
            }
        }];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:likeStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"等%ld人觉得很赞",_model.likeList.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xb2b2b2)}];
        [attr appendAttributedString:attr1];
        [attr appendAttributedString:attr2];
        _supportLable.attributedText = attr;
        
    }
}

- (IBAction)thumbUp:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag==1) {
        NSLog(@"11111");
        if (sender.selected) {
            [sender setBackgroundImage:[UIImage imageNamed:@"warn_press_40px"] forState:UIControlStateSelected];
        }
        else {
            [sender setBackgroundImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];

        }
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击了发表");
    return YES;
}
@end
