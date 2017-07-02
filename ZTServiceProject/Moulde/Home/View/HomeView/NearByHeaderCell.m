//
//  NearByHeaderCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByHeaderCell.h"
#import "BaseTabbarController.h"
@implementation NearByHeaderCell
{
    BaseTabbarController *_tabBarController;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moreBtn:(id)sender {
    NSLog(@"moreBtn");
    switch (self.type) {
        case Nearby_Type: {
            BaseTabbarController *tabbar = (BaseTabbarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbar.selectedIndex = 2;
            break;
        }
        case Rent_Type: {
            [PushManager pushViewControllerWithName:@"HouseRentViewController" animated:YES block:nil];
            break;
        }
        case Second_Type: {
            [PushManager pushViewControllerWithName:@"SecondHandViewController" animated:YES block:nil];
            break;
        }
            
        default:
            break;
    }
   
}

@end
