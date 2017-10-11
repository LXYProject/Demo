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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *upTitleArr;
@end

@implementation MainVC
{
    UIView *_upView;
    UIButton *_reciveBtn;
    BOOL _isNeedScroll;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [CyhSliderVC initCyhslider].pudelegate = self;
    _isNeedScroll = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGB(247, 247, 247);
    self.upTitleArr = @[@"代办", @"工作日志", @"我的消息", @"通讯录", @"我的排班"];
    [self btnClick:self.btnArray[0]];
}
- (IBAction)headerIconAction:(UIButton *)sender {
    [[CyhSliderVC initCyhslider]sliderBlicked:sender];
}

- (void)changeBtnFrame {
    for (UIButton *btn in self.topBtnArray) {
        [self setButtonContentCenter:btn];
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
    [self changeBtnFrame];
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






- (void)btnClick{
    NSLog(@"点击");
}
@end
