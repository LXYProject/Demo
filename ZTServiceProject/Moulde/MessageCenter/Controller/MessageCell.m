//
//  MessageCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessageCell.h"
#import "NearByItemModel.h"

@interface MessageCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewH;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewArray;

@end

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(NearByItemModel *)model {
    _model = model;
    if (_model.smallImageList.count==0) {
        self.imageViewH.constant = 0;
    }
    else {
        self.imageViewH.constant = 70*ScreenWidth/320;
        [self.imageViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImageView *imageView = obj;
            imageView.image = [UIImage imageNamed:model.smallImageList[idx]];
        }];
    }
}

@end
