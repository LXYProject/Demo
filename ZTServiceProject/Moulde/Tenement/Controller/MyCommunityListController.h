//
//  MyCommunityListController.h
//  ZTServiceProject
//
//  Created by ZT on 2017/6/21.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "BaseViewController.h"

@protocol MyCommunityListControllerDelegate <NSObject>

-(void)passTrendValues:(NSString *)values;//1.1定义协议与方法


@end

@interface MyCommunityListController : BaseViewController

///1.定义向趋势页面传值的委托变量

@property (assign,nonatomic) id <MyCommunityListControllerDelegate> delegate;

@end
