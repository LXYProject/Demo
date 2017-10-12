//
//  MainVC.m
//  CyhSlider
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "MainVC.h"
#import "CyhSliderVC.h"
#import "subVC.h"
#import "LeftVc.h"
#import "UIButton+TitleImgEdgeInsets.h"

// 宽度(自定义)
#define PIC_WIDTH 50
// 高度(自定义)
#define PIC_HEIGHT 50
// 列数(自定义)
#define COL_COUNT 4
@interface MainVC ()<UIScrollViewDelegate,pushdelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIView *lineView;
//scrollView上面的btn
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;
//五个btn
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *topBtnArray;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *downViewArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *upTitleArr;
@property (nonatomic, strong) NSArray *downTitleArr;
@property (nonatomic, strong) NSArray *viewOneArr;
@property (nonatomic, strong) NSArray *viewTwoArr;
@property (nonatomic, strong) NSArray *viewThreeArr;
@property (nonatomic, strong) NSArray *viewfourArr;

@end

@implementation MainVC
{
    UIView *_upView;
    UIButton *_reciveBtn;
    BOOL _isNeedScroll;
    NSInteger _itemCloums;
    CGFloat top;
    CGFloat left;
    CGFloat right;
    CGFloat bottom;
    CGFloat btnW;
    CGFloat btnH;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [CyhSliderVC initCyhslider].pudelegate = self;
    _isNeedScroll = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGB(247, 247, 247);
    self.upTitleArr = @[@"代办", @"工作日志", @"我的消息", @"通讯录", @"我的排班"];
    self.downTitleArr = @[@"日常", @"管理", @"统计", @"巡查"];
    self.viewOneArr = @[@"请假历史", @"请假申请", @"签退签到"];
    self.viewTwoArr = @[@"表扬", @"投诉", @"安保管理", @"投票管理", @"员工动态", @"公共报事"];
    self.viewThreeArr = @[@"日考勤统计", @"月考勤统计", @"考勤汇总", @"临停车辆统计", @"物资车辆进入统计", @"来访查询", @"上门服务", @"公共报事"];
    self.viewfourArr = @[@"巡查计划"];
    [self btnClick:self.btnArray[0]];
    

    [self createDownIcon];
    
}


- (IBAction)headerIconAction:(UIButton *)sender {
    [[CyhSliderVC initCyhslider]sliderBlicked:sender];
}

- (void)changeBtnFrameUp {
    for (UIButton *btn in self.topBtnArray) {
        [self setButtonContentCenter:btn];
        [btn setTitle:self.upTitleArr[btn.tag] forState:UIControlStateNormal];
        switch (btn.tag) {
            case 0:
                
                break;
                
            default:
                break;
        }
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}

- (void)pushsubVC:(id)trag {
    [self.navigationController pushViewController:trag animated:YES];
    
}

-(void)setButtonContentCenter:(UIButton *) button {
    [button setTitle:@"sad" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self changeBtnFrameUp];
}


- (IBAction)btnClick:(UIButton*)sender {
    if (sender.selected) {
        return;
    }
    _reciveBtn.selected = NO;
    sender.selected = YES;
    _reciveBtn = sender;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation(sender.origin.x, 0);
    }];
    if (_isNeedScroll) {
        [self.scrollView scrollRectToVisible:CGRectMake([self.btnArray indexOfObject:sender]*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.height) animated:YES];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
        NSInteger index = (int)(scrollView.contentOffset.x/SCREEN_WIDTH);
        NSLog(@"%ld",(long)index);
        [self btnClick:self.btnArray[index]];
        _isNeedScroll = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isNeedScroll = NO;
}


- (void)createDownIcon{
    for (UIView *view in self.downViewArray) {
        switch (view.tag) {
            case 0:
                for (int i=0; i<self.viewOneArr.count; i++) {
                    SQCustomButton *button1 = [[SQCustomButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 * i +25, 35, PIC_HEIGHT, PIC_HEIGHT) type:SQCustomButtonTopImageType imageSize:CGSizeMake(PIC_HEIGHT, PIC_HEIGHT) midmargin:10];
                    
                    button1.isShowSelectBackgroudColor = YES;
                    button1.imageView.image = [UIImage imageNamed:@"image"];
                    button1.backgroundColor = [UIColor clearColor];
                    button1.titleLabel.text = self.viewOneArr[i];
                    button1.titleLabel.textColor = [UIColor darkGrayColor];
                    button1.tag = i;
                    [view addSubview:button1];
                    [button1 touchAction:^(SQCustomButton * _Nonnull button) {
                        NSLog(@"");
                    }];
                }
                break;
            case 1:
                for (int i= 0; i<self.viewTwoArr.count; i++) {
                    // 图片所在行
                    NSInteger row = i / COL_COUNT;
                    // 图片所在列
                    NSInteger col = i % COL_COUNT;
                    // 间距
                    CGFloat margin = (self.view.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1) + 10;
                    // PointX
                    CGFloat picX = margin + (PIC_WIDTH + margin) * col - 10;
                    // PointY
                    CGFloat picY = margin + (PIC_HEIGHT + margin) * row;

                    //创建图片
                    SQCustomButton *button1 = [[SQCustomButton alloc] initWithFrame:CGRectMake(picX, picY, PIC_HEIGHT, PIC_HEIGHT) type:SQCustomButtonTopImageType imageSize:CGSizeMake(PIC_HEIGHT, PIC_HEIGHT) midmargin:10];
                    button1.isShowSelectBackgroudColor = YES;
                    button1.imageView.image = [UIImage imageNamed:@"image"];
                    button1.backgroundColor = [UIColor clearColor];
                    button1.titleLabel.text = self.viewTwoArr[i];
                    button1.titleLabel.textColor = [UIColor darkGrayColor];
                    button1.tag = i;
                    [view addSubview:button1];
                    [button1 touchAction:^(SQCustomButton * _Nonnull button) {
                        NSLog(@"");
                    }];

                }
                break;
            case 2: {
                for (int i= 0; i<self.viewThreeArr.count; i++) {
                    // 图片所在行
                    NSInteger row = i / COL_COUNT;
                    // 图片所在列
                    NSInteger col = i % COL_COUNT;
                    // 间距
                    CGFloat margin = (self.view.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1) + 10;
                    // PointX
                    CGFloat picX = margin + (PIC_WIDTH + margin) * col - 10;
                    // PointY
                    CGFloat picY = margin + (PIC_HEIGHT + margin) * row;

                    //创建图片
                    SQCustomButton *button1 = [[SQCustomButton alloc] initWithFrame:CGRectMake(picX, picY, PIC_HEIGHT, PIC_HEIGHT) type:SQCustomButtonTopImageType imageSize:CGSizeMake(PIC_HEIGHT, PIC_HEIGHT) midmargin:10];
                    button1.isShowSelectBackgroudColor = YES;
                    button1.imageView.image = [UIImage imageNamed:@"image"];
                    button1.backgroundColor = [UIColor clearColor];
                    button1.titleLabel.text = self.viewThreeArr[i];
                    button1.titleLabel.textColor = [UIColor darkGrayColor];
                    button1.tag = i;
                    [view addSubview:button1];
                    [button1 touchAction:^(SQCustomButton * _Nonnull button) {
                        NSLog(@"");
                    }];
                }

                break;
            }
                
            case 3: {
                for (int i=0; i<self.viewfourArr.count; i++) {
                    SQCustomButton *button1 = [[SQCustomButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4 * i +25, 35, PIC_HEIGHT, PIC_HEIGHT) type:SQCustomButtonTopImageType imageSize:CGSizeMake(PIC_WIDTH, PIC_HEIGHT) midmargin:10];
                    
                    button1.isShowSelectBackgroudColor = YES;
                    button1.imageView.image = [UIImage imageNamed:@"image"];
                    button1.backgroundColor = [UIColor clearColor];
                    button1.titleLabel.text = self.viewfourArr[i];
                    button1.titleLabel.textColor = [UIColor darkGrayColor];
                    button1.tag = i;
                    [view addSubview:button1];
                    [button1 touchAction:^(SQCustomButton * _Nonnull button) {
                        NSLog(@"");
                    }];
                }

                break;
            }
        }
        
    }
}



@end
