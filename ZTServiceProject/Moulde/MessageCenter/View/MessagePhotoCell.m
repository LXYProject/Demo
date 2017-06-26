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
    // Initialization code
}

- (void)setUrl:(NSString *)url {
    if (url) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[[UIImage alloc]init]];
    }
}
@end
