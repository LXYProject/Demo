//
//  Model.h
//  cell自动计算高度
//
//  Created by bailing on 16/3/31.
//  Copyright © 2016年 bailing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Model : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,assign)CGFloat cellHeight;

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content;


@end
