//
//  NearByHeaderCell.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Second_Type,
    Nearby_Type,
    Rent_Type

}PushType;

@interface NearByHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellHeadIcon;
@property (nonatomic,assign)PushType type;
@end
