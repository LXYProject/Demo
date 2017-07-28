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
#import "MesssgeHttpManager.h"  

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

@property (nonatomic, copy) NSString* topicId;
@property (nonatomic,assign)NSString* commentType;
@property (nonatomic,assign)NSString* targetUserId;



@end

@implementation CommentBottomCell
{
    NSString *contextStr;
}
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
        
        _topicId = model.topicId;

        NSMutableString *likeStr = [[NSMutableString alloc]initWithCapacity:1];
        [_model.likeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentUserModel *userModel = obj;
            [likeStr appendString:[NSString stringWithFormat:@"%@ ",userModel.userName]];

            if (idx == 11) {
                *stop = YES;
            }
        }];
        
        
        [_model.commentList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentUserModel *userModel = obj;
            _commentType = userModel.commentType;
            _targetUserId = userModel.targetUserId;

            [self requestStr1:_commentType str2:_targetUserId];
//            if (idx == 11) {
//                *stop = YES;
//            }
        }];

        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
        NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:likeStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
        NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"等%ld人觉得很赞",_model.likeList.count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0xb2b2b2)}];
        [attr appendAttributedString:attr1];
        [attr appendAttributedString:attr2];
        _supportLable.attributedText = attr;
        
    }
}

- (void)requestStr1:(NSString *)str1 str2:(NSString *)str2{
//    NSLog(@"str1==%@", str1);
//    NSLog(@"str2==%@", str2);
}

- (IBAction)thumbUp:(UIButton *)sender {
    sender.selected = !sender.selected;
    [MesssgeHttpManager requestTypeInterface:Thumb_Up TopicId:_topicId success:^(id response) {
//        //状态码
//        NSString *status = [response objectForKey:@"status"];
//        
//        if ([status integerValue]==0) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"warn_press_40px"] forState:UIControlStateSelected];
//        }else{
//            [sender setBackgroundImage:[UIImage imageNamed:@"thumb_up"] forState:UIControlStateNormal];
//        }

        //这个代码放在网络请求的成功回调里面
        if (self.commentSuccessBlock) {
            self.commentSuccessBlock(response);

        }
    } failure:^(NSError *error, NSString *message) {
        
    }];

    if (sender.tag==1) {
        NSLog(@"11111");
        if (sender.selected) {
        }
        else {

        }
    }
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
- (void)commentRequestWithText:(NSString *)text {
    
    NSLog(@"评论的内容==%@", text);
    NSLog(@"评论的commentType==%@", _commentType);
    NSLog(@"评论的targetUserId==%@", _targetUserId);


    @weakify(self);
    [MesssgeHttpManager requestTopicId:_topicId comment:text commentType:_commentType targetUserId:_targetUserId success:^(id response) {
        @strongify(self);
        //网络请求的成功回调里面
        if (self.commentSuccessBlock) {
            self.commentSuccessBlock(response);
        }
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"error==%@mesxsage==%@", error, message);
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
