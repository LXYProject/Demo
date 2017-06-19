//
//  SolicitBtnItemOneCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/19.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitBtnItemOneCell.h"

@interface SolicitBtnItemOneCell ()
@property (nonatomic,strong) UIButton * chooseBtn;
@end
@implementation SolicitBtnItemOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
        if ([obj isKindOfClass:[UILabel class]]) {
            [obj removeFromSuperview];
        }
        
    }];
    
    [self initSubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initSubView
{
    CGFloat top = 14;
    CGFloat topL = 7;
    
    CGFloat left = 15;
    CGFloat btnW = 15;
    CGFloat btnH = 15;
    CGFloat labelW = 30;
    CGFloat labelH = 30;
    
    CGFloat bal = 10;
    CGFloat space = 30;
    CGFloat rowSpaceL = 15+10;
    
    for (int i=0; i<3; i++) {
        NSArray * nameArr = @[@"中介",@"房东", @"全部"];
        
        self.chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            self.chooseBtn.frame = CGRectMake(left+(left+btnW+bal+labelW+space)*i, top, btnW, btnH);
        }else{
            self.chooseBtn.frame = CGRectMake((left+btnW+bal+labelW+space)*i, top, btnW, btnH);
        }
        //        self.chooseBtn.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.chooseBtn];
        
        self.chooseBtn.tag = 100 + i;
        [self.chooseBtn setImage:[UIImage imageNamed:@"否@3x"] forState:UIControlStateNormal];
        [self.chooseBtn setImage:[UIImage imageNamed:@"是@3x"] forState:UIControlStateSelected];
        [self.chooseBtn addTarget:self action:@selector(styleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //名称
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(bal+(left+15+10+30+rowSpaceL)*i+30, topL, labelW, labelH);
        [self.contentView addSubview:nameLabel];
        nameLabel.text = nameArr[i];
        nameLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        nameLabel.font = [UIFont systemFontOfSize:13];
        
        
    }
}

- (void)styleBtnClick:(UIButton *)button{
    NSLog(@"%ld",button.tag);
    button.selected = !button.selected;
    //    if (button.tag == 100) {
    //        UIButton * btn = [self.contentView viewWithTag:101];
    //        btn.selected = NO;
    //        button.selected = YES;
    //        NSLog(@"zhi");
    //    }else{
    //        UIButton * btn = [self.contentView viewWithTag:100];
    //        btn.selected = NO;
    //        button.selected = YES;
    //        NSLog(@"wei");
    //    }
}

@end
