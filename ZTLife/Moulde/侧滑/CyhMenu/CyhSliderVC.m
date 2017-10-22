//
//  CyhSliderVC.m
//  CyhSlider
//
//  Created by Macx on 16/8/15.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "CyhSliderVC.h"

static CyhSliderVC * cyhslider;
static UINavigationController * mynvc;
@interface CyhSliderVC ()<UIGestureRecognizerDelegate>

@property (nonatomic , strong)UIBarButtonItem * leftItem;
@property (nonatomic , strong)UIButton * pushBtn;

@end

@implementation CyhSliderVC
{
    UIView * mainview;
    UIView * leftview;
    UIView * rightview;
    CGPoint mainPoint;
    CGRect moveframe;
    UIScreenEdgePanGestureRecognizer * _sPanGR;
    UIPanGestureRecognizer * rightpanGR;
    UITapGestureRecognizer * _TapGR;
}


- (void)sliderBlicked:(UIButton *)btn
{
    
    if (btn.selected == NO) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, 0, self.view.frame.size.width, self.view.frame.size.height);
            _sPanGR.enabled = NO;
            rightpanGR.enabled = YES;
            _TapGR.enabled = YES;
            self.Mainvc.view.userInteractionEnabled = NO;
        }];
    }
   else
   {
       [UIView animateWithDuration:0.3 animations:^{
           
           mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
           _sPanGR.enabled = YES;
           rightpanGR.enabled = NO;
           _TapGR.enabled = NO;
           self.Mainvc.view.userInteractionEnabled = YES;
       }];
   
   }
    btn.selected = !btn.selected;
    self.pushBtn = btn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.Leftvc];
    [self addChildViewController:self.Mainvc];
    
    mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    leftview = [[UIView alloc] initWithFrame:self.view.bounds];
//    rightview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor whiteColor];
    leftview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:leftview];
    [self.view addSubview:mainview];
    self.Mainvc.view.frame = mainview.bounds;
    self.Leftvc.view.frame = leftview.bounds;
    [mainview addSubview:self.Mainvc.view];
    [leftview addSubview:self.Leftvc.view];
    
    [_Mainvc didMoveToParentViewController:self];
    [_Leftvc didMoveToParentViewController:self];
 
    [self creatScreenPangGesture];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];


}


- (void)creatScreenPangGesture
{
    _sPanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(sPanGRBlicked:)];
    _sPanGR.delegate = self;
    _sPanGR.maximumNumberOfTouches = 1;
    _sPanGR.minimumNumberOfTouches = 1;
    _sPanGR.edges = UIRectEdgeLeft;
    _sPanGR.enabled = YES;
    
    _TapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGRBlicked:)];
    _TapGR.delegate = self;
    _TapGR.enabled = NO;
    self.Mainvc.view.userInteractionEnabled = YES;
   rightpanGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightpanGRBlicked:)];
    rightpanGR.maximumNumberOfTouches = 1;
    rightpanGR.minimumNumberOfTouches = 1;
    rightpanGR.enabled = NO;
    
    mainview.userInteractionEnabled = YES;
    mainview.multipleTouchEnabled = YES;
    [mainview addGestureRecognizer:_sPanGR];
    [mainview addGestureRecognizer:rightpanGR];
    [mainview addGestureRecognizer:_TapGR];
}

- (void)TapGRBlicked:(UITapGestureRecognizer *)TapGR
{
    [UIView animateWithDuration:0.3 animations:^{
        
        mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.Mainvc.view.userInteractionEnabled = YES;
        _sPanGR.enabled = YES;
        rightpanGR.enabled = NO;
        _TapGR.enabled = NO;
        self.pushBtn.selected = YES;
    }];

}

- (void)rightpanGRBlicked:(UIPanGestureRecognizer *)panGR
{
    CGPoint point = [panGR translationInView:self.view];
   
    if (panGR.state == UIGestureRecognizerStateBegan) {

        mainPoint = point;
        
    }
    if (panGR.state == UIGestureRecognizerStateChanged) {
        self.Mainvc.view.userInteractionEnabled = NO;
        moveframe = mainview.frame;
        moveframe.origin.x = self.view.frame.size.width * 2/3 + (point.x - mainPoint.x);
        mainview.frame = CGRectMake(moveframe.origin.x, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        if (mainview.frame.origin.x <= 0) {
            mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        }
        
    }
    if (panGR.state == UIGestureRecognizerStateEnded) {

        if (mainview.frame.origin.x >= self.view.frame.size.width * 1/2){
            
            self.Mainvc.view.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                _TapGR.enabled = YES;
                self.Mainvc.view.userInteractionEnabled = NO;
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                
            } completion:^(BOOL finished) {
                self.pushBtn.selected = NO;
                rightpanGR.enabled = NO;
                _sPanGR.enabled = YES;
                _TapGR.enabled = NO;
                self.Mainvc.view.userInteractionEnabled = YES;
            }];
            
            
        }
 }

}
- (void)sPanGRBlicked:(UIScreenEdgePanGestureRecognizer *)sPanGR
{
    
    CGPoint point = [sPanGR translationInView:self.view];
    
    if (sPanGR.state == UIGestureRecognizerStateBegan) {

       mainPoint = [sPanGR translationInView:self.view];
        
    }
    if (sPanGR.state == UIGestureRecognizerStateChanged) {
        
        moveframe = mainview.frame;
        moveframe.origin.x = point.x - mainPoint.x;
        mainview.frame = CGRectMake(moveframe.origin.x, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        if (mainview.frame.origin.x > self.view.frame.size.width * 2/3)
        {
            mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        }
    }
    if (sPanGR.state == UIGestureRecognizerStateEnded) {

        if (mainview.frame.origin.x >= self.view.frame.size.width * 1/2)
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(self.view.frame.size.width * 2/3, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            } completion:^(BOOL finished) {
                rightpanGR.enabled = YES;
                _sPanGR.enabled = NO;
                _TapGR.enabled = YES;
                self.Mainvc.view.userInteractionEnabled = NO;
            }];
            
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                mainview.frame = CGRectMake(0, moveframe.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                
            } completion:^(BOOL finished) {
                self.pushBtn.selected = NO;
                _TapGR.enabled = NO;
                self.Mainvc.view.userInteractionEnabled = YES;
                
                
            }];
          
            
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)otherGestureRecognizer.view;
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    return NO;
}

- (void)pushSubvc:(id)trag
{
    [UIView animateWithDuration:0.3 animations:^{
        
        mainview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _sPanGR.enabled = YES;
        rightpanGR.enabled = NO;
        _TapGR.enabled = NO;
        self.Mainvc.view.userInteractionEnabled = YES;
        self.pushBtn.selected = NO;
    }];
    [self.pudelegate pushsubVC:trag];
    
}

@end
