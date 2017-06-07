//
//  NearByHomeViewController.m
//  ZTServiceProject
//
//  Created by zhangyy on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByHomeViewController.h"

@interface NearByHomeViewController ()
@property (nonatomic,strong)NSMutableArray *vcDataArray;
@end

@implementation NearByHomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)requestData {
    
}


-(NSMutableArray *)vcDataArray {
    if (!_vcDataArray) {
        _vcDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _vcDataArray;
}
@end
