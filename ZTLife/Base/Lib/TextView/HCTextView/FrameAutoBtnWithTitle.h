//
//  FrameAutoBtnWithTitle.h
//  textTable
//
//  Created by zhngyy on 16/4/11.
//  Copyright © 2016年 zhangyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClickBlock)(UIButton *btn , int index);
@interface FrameAutoBtnWithTitle : UIView

//正常图片
@property (nonatomic,copy)NSString *normalImageName;
//选中图片
@property (nonatomic,copy)NSString *selectImageName;
//选中颜色
@property (nonatomic,strong)UIColor *selectColor;
//正常颜色
@property (nonatomic,strong)UIColor *normalColor;

@property (nonatomic,assign)NSInteger selectIndex;
/**
 *  规格页的UI封装
 *
 *  @param titleArray Title的数组
 *  @param top        上边距
 *  @param left       左边距
 *  @param buttom     下边距
 *  @param spaceH     水平间距
 *  @param spaceV     垂直间距
 *  @param btnHeight  btn的高度
 *  @param width      这个View的宽度
 *
 *  @return 返回整个的高度
 */

- (CGFloat)autoBtnWithTitleArray:(NSArray *)titleArray
                             top:(CGFloat)top
                            left:(CGFloat)left
                          buttom:(CGFloat)buttom
                          spaceH:(CGFloat)spaceH
                          spaceV:(CGFloat)spaceV
                       btnHeight:(CGFloat)btnHeight
                           width:(CGFloat)width;


/**
 *  btn点击block
 *
 *  @param block 回调的block
 */
- (void)btnClickWithBlock:(btnClickBlock)block;

@end
