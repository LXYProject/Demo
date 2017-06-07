//
//  NearByServiceCell.h
//  Aa
//
//  Created by 张圆圆 on 17/6/5.
//  Copyright © 2017年 张圆圆. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^BtnClickBlock)(NSInteger senderIdenx);

@interface NearByServiceCell : UITableViewCell
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,copy)Int_Block btnClickBlock;
@end
