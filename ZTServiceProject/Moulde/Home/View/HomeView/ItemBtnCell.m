//
//  ItemBtnCell.m
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.

//

#import "ItemBtnCell.h"
#define ItemsNumber 10
#define BtnTag  10000000
#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define BtnTag  100

@implementation ItemBtnCell
{
    NSInteger _itemCloums;
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
     return   [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)setTitleAndImageDictArray:(NSArray *)titleAndImageDictArray {
    _titleAndImageDictArray = titleAndImageDictArray;
    if (_titleAndImageDictArray.count%5==0) {
        _itemCloums = 5;
    }
    else {
        _itemCloums = 4;
    }
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }];
    
    [self initSubView];
}

- (void)initSubView {
    CGFloat top = 18;
    CGFloat left = 25;
    CGFloat right = 25;
    CGFloat bottom = 18;
    CGFloat btnW = 50;
    CGFloat btnH = 60;
    CGFloat rowSpace = (ScreenW - left- right-btnW*_itemCloums)/(_itemCloums - 1);
    CGFloat listSpace = 18;
    for(int i =0;i<_titleAndImageDictArray.count;i++) {
        NSInteger row = i/_itemCloums;
        NSInteger list = i%_itemCloums;
        EJVerticalButton *btn = [EJVerticalButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left+list*(btnW+rowSpace), top+row*(btnH+listSpace), btnW, btnH);
        [btn setTitle:_titleAndImageDictArray[i][@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:_titleAndImageDictArray[i][@"icon"]] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x4e4e4e) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        if (i== _titleAndImageDictArray.count-1) {
            self.cellHeight = btn.frame.origin.y+btnH+bottom;
        }
        btn.tag = BtnTag + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}


- (void)btnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(sender.tag-BtnTag);
    }
}

@end
