//
//  SearchHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SearchHeadCell.h"

@interface SearchHeadCell ()


@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end
@implementation SearchHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = self.searchBtn.bounds.size.width * 0.01;
    self.searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)searchBtnClick {
    [PushManager pushViewControllerWithName:@"SearchViewController" animated:YES block:nil];

}
@end
