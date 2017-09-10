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
        //        _btn1.selected = model.isSupper;
        _address.text = _model.address.length>0?_model.address:@"未知位置";
        _thumbUpNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)model.likeList.count];
        _comments.text = model.commentCount;
        NSMutableString *likeStr = [[NSMutableString alloc]initWithCapacity:1];
        [_model.likeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CommentUserModel *userModel = obj;
            [likeStr appendString:[NSString stringWithFormat:@"%@ ",userModel.userName]];
            
            if (idx == 15) {
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

- (void)requestStr1:(NSString *)str1 str2:(NSString *)str2{
    //    NSLog(@"str1==%@", str1);
    //    NSLog(@"str2==%@", str2);
}

- (IBAction)thumbUp:(UIButton *)sender {    
    [MesssgeHttpManager requestTypeInterface:Thumb_Up TopicId:_model.topicId success:^(id response) {
        //状态码
        NSString *status = [response objectForKey:@"status"];
        if ([status integerValue]==0) {
            //这个代码放在网络请求的成功回调里面
            if (self.commentSuccessBlock) {
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
                CommentUserModel * model = [[CommentUserModel alloc]init];
                model.userName = @"李小艳";
                if (_model.likeList.count==0) {
                    [array addObject:model];
                }
                else {
                    [array addObjectsFromArray:_model.likeList];
                    [array addObject:model];
                }
                _model.likeList = array;
                self.commentSuccessBlock(_model);
                
            }
        }
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.beginEditing) {
        self.beginEditing();
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

- (IBAction)commentBtnClick:(id)sender {
    if (self.commentBtnClickBlock) {
        self.commentBtnClickBlock(sender);
    }
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
    [MesssgeHttpManager requestTopicId:_model.topicId comment:text commentType:@"0" targetUserId:_model.ownerId success:^(id response) {
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
