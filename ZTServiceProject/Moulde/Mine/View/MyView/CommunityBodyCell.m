//
//  HouseBodyCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommunityBodyCell.h"
#import "MyNeighborModel.h"
#import "MineHttpManager.h"

@interface CommunityBodyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *details;

@property (nonatomic, copy) NSString *communityId;


@end
@implementation CommunityBodyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.completionBtn.layer.masksToBounds = YES;
    self.completionBtn.layer.cornerRadius = self.completionBtn.bounds.size.width * 0.05;
    self.completionBtn.layer.borderColor = [UIColor whiteColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyNeighborModel *)model{
    
    _model = model;
    
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.zoneImageUrl?model.zoneImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    _title.text = model.zoneName;
    _details.text = model.zoneAddress;

}

- (IBAction)completionBtnClick {
    
    if (self.btnClickBlock) {
        self.btnClickBlock(nil);
    }
    
//    switch (self.type) {
//        case completion_Type: {//补全物业信息
//            NSLog(@"补全物业信息");
//            
//            break;
//        }
//        case CancelAttention_Type: {//取消关注
//            NSLog(@"取消关注");
//            
//            // 取消小区关注
//            [MineHttpManager requestAddToCancelVillage:CancelVillage
//                                           communityId:_communityId
//                                               success:^(id response) {
//                                                   
//                                               } failure:^(NSError *error, NSString *message) {
//                                                   
//                                               }];
//            break;
//        }
//        default:
//            break;
//    }
    
}

@end
