//
//  CommentBottomCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborDetailCell.h"
#import "NeighborCircleModel.h"
#import "CommentUserModel.h"
#import "MesssgeHttpManager.h"  

@interface NeighborDetailCell()<UITextFieldDelegate>
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

@property (nonatomic, copy) NSString* topicId;
@property (nonatomic,assign)NSString* commentType;


@end

@implementation NeighborDetailCell
{
    BOOL ReplyComment;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.commentTextField.delegate = self;//设置代理
    self.commentTextField.enablesReturnKeyAutomatically = YES;
    self.commentTextField.returnKeyType = UIReturnKeySend;//变为搜索按钮
    
//    if (ReplyComment==YES) {
//        _commentType = 0;//话题评论
//    }else{
//        _commentType = 1;//回复评论
//    }
//

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(NeighborCircleModel *)model {
    _model = model;
    if (_model) {
        _address.text = _model.address.length>0?_model.address:@"未知位置";
        _thumbUpNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)model.likeList.count];
        _comments.text = model.commentCount;
        _topicId = model.topicId;
        
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
//    sender.selected = !sender.selected;
//    if (sender.tag==1) {
//        NSLog(@"11111");
//        if (sender.selected) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"warn_press_40px"] forState:UIControlStateSelected];
//        }
//        else {
//            [sender setBackgroundImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
//
//        }
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *context = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (context.length>0) {
        [self commentRequestWithText:context];
        return YES;
    }
    return NO;
}

#pragma mark - 评论的请求

/**
 评论帖子
//回复
 @param text 评论的内容
 */
- (void)commentRequestWithText:(NSString *)text{
    @weakify(self);
    [MesssgeHttpManager requestTopicId:_topicId comment:text commentType:_commentType targetUserId:@"" success:^(id response) {
        @strongify(self);
        //网络请求的成功回调里面
        if (self.commentSuccessBlock) {
            self.commentSuccessBlock(response);
        }
    } failure:^(NSError *error, NSString *message) {
        
    }];
}


/**
 点赞的网络请求，放点赞的点击方法里面调用
 */
- (void)likeOrDislike {
    @weakify(self);
    [MesssgeHttpManager requestTypeInterface:Thumb_Up TopicId:_topicId success:^(id response) {
        @strongify(self);
        //这个代码放在网络请求的成功回调里面
        if (self.commentSuccessBlock) {
            self.commentSuccessBlock(response);
        }
    } failure:^(NSError *error, NSString *message) {
        
    }];
}
@end
