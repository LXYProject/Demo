//
//  AddressBookController.h
//  ZTLife
//
//  Created by ZT on 2017/10/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SelectedItem)(NSString *item);
@interface AddressBookController : BaseViewController

@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;

@end
