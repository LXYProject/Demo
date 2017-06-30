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
        if (i == 0) {
            twobtn.label.text = @"0";
            twobtn.label1.text = @"好友";
        }else if (i == 1){
            twobtn.label.text = @"0";
            twobtn.label1.text = @"关注";
        }else if (i == 2){
            twobtn.label.text = @"0";
            twobtn.label1.text = @"粉丝";
        }else{
            twobtn.label.text = @"0";
            twobtn.label1.text = @"群组";
        }
        if (IS_IPHONE_6) {
            twobtn.label.font = [UIFont systemFontOfSize:11];
        }else if (IS_IPHONE_6p){
            twobtn.label.font = [UIFont systemFontOfSize:12];
        }else{
            twobtn.label.font = [UIFont systemFontOfSize:10];
        }
        twobtn.label.alpha = .5;
        twobtn.label1.alpha = .5;
        
        [self.contentView addSubview:twobtn];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

@end
