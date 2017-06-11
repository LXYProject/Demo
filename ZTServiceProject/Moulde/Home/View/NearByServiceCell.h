//
//  NearByServiceCell.h
//  Aa
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^BtnClickBlock)(NSInteger senderIdenx);

@interface NearByServiceCell : UITableViewCell
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,copy)Int_Block btnClickBlock;
@end
