//
//  MessagePhotoCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessagePhotoCell.h"

@interface MessagePhotoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@end

@implementation MessagePhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.numberOfTouchesRequired = 1; 
    [self.icon addGestureRecognizer:tableViewGesture];
    // Initialization code
}

- (void)setUrl:(NSString *)url {
    if (url) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
        
        self.icon.layer.contentsGravity = kCAGravityResizeAspectFill;
        
        
        //        self.icon.contentMode = UIViewContentModeScaleAspectFill;
        //        self.icon.clipsToBounds = YES;
        //        //  是否剪切掉超出 UIImageView 范围的图片
        //        [self.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
    }
}

- (void)commentTableViewTouchInSide {
    if (self.clickPhoto) {
        self.clickPhoto(nil);
    }
}


@end
