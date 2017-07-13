//
//  GroupNumberCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "GroupNumberCell.h"
#import "TwoLabelBtn.h"

@interface GroupNumberCell ()

@end
@implementation GroupNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[TwoLabelBtn class]]) {
            [obj removeFromSuperview];
            
        }
    }];
    

    [self createBtn];
}

- (void)createBtn
{
    for (int i = 0; i < 4; i++) {
        TwoLabelBtn *twobtn = [[TwoLabelBtn alloc]initWithFrame:CGRectMake(ScreenWidth/4 * i, 10, ScreenWidth/4, 60)];
        if (i>0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/4*i, 15, 0.5, 35)];
            line.backgroundColor = UIColorFromRGB(0xb2b2b2);
            [self.contentView addSubview:line];
        }
        if (i == 0) {
            twobtn.label.text = @"22";
            twobtn.label1.text = @"好友";
        }else if (i == 1){
            twobtn.label.text = @"312";
            twobtn.label1.text = @"关注";
        }else if (i == 2){
            twobtn.label.text = @"43";
            twobtn.label1.text = @"粉丝";
        }else{
            twobtn.label.text = @"2";
            twobtn.label1.text = @"群组";
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            twobtn.label.font = [UIFont systemFontOfSize:15];
        }else{
            twobtn.label.font = [UIFont systemFontOfSize:16];
        }
        twobtn.label1.alpha = .5;
        twobtn.tag = i+1;
        [twobtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:twobtn];
    }

}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%ld", (long)btn.tag);
    [PushManager pushViewControllerWithName:@"ChatFriendsController" animated:YES block:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

@end
