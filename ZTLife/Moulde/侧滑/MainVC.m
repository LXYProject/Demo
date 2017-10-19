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

#import "HomeBtnItemCell.h"


@interface MainVC ()<UIScrollViewDelegate,pushdelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *lineView;
//scrollView上面的btn
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *downViewArray;
@property (strong, nonatomic) IBOutletCollection(UICollectionView) NSArray *collectionViewArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSArray *dataSource1;
@property (nonatomic,strong)NSArray *dataSource2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (nonatomic,strong)NSArray *titleOneArr;
@property (nonatomic,strong)NSArray *titleTwoArr;


@end

@implementation MainVC
{
    UIView *_upView;
    UIButton *_reciveBtn;
    BOOL _isNeedScroll;
    CyhSliderVC *_superVC;
}


// 禁止侧滑手势
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.rt_disableInteractivePop = YES;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    
//    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    self.rt_disableInteractivePop = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _superVC =  (CyhSliderVC *)self.parentViewController;
    _superVC.pudelegate = self;
    _isNeedScroll = YES;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGB(247, 247, 247);
    
    self.titleOneArr = @[@"日常", @"管理", @"统计", @"巡查"];
    self.titleTwoArr = @[@"日常", @"统计", @"任务", @"安保"];
    
    [self typeBtnClick:_btn1];
    [self btnClick:self.btnArray[0]];
    
    [self.collectionViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionView *collectView = obj;
        [collectView registerNib:[UINib nibWithNibName:@"HomeBtnItemCell" bundle:nil] forCellWithReuseIdentifier:@"HomeBtnItemCell"];
    }];

    
}
- (IBAction)typeBtnClick:(UIButton *)sender {
   
    if (sender == _btn1) {
        self.dataSource = self.dataSource1;
        for (UIButton *btn in self.btnArray) {
            [btn setTitle:self.titleOneArr[btn.tag] forState:UIControlStateNormal];
            // 1.添加字典, 将数据包到字典中
            NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:tag,@"type", nil];
            // 2.创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:dict];
            // 3.通过 通知中心 发送 通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

        }
    }
    else if(sender == _btn2) {
        self.dataSource = self.dataSource2;
        for (UIButton *btn in self.btnArray) {
            [btn setTitle:self.titleTwoArr[btn.tag] forState:UIControlStateNormal];
            // 1.添加字典, 将数据包到字典中
            NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:tag,@"type", nil];
            // 2.创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:dict];
            // 3.通过 通知中心 发送 通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];

        }
    }
    [self.collectionViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionView *collectView = obj;
        [collectView reloadData];
        
    }];

}


- (IBAction)headerIconAction:(UIButton *)sender {
    [_superVC sliderBlicked:sender];
}


- (void)pushsubVC:(id)trag {
    [self.navigationController pushViewController:trag animated:YES];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


//下部分4个按钮事件
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
    if(scrollView == self.scrollView) {
        NSInteger index = (int)(scrollView.contentOffset.x/SCREEN_WIDTH);
        NSLog(@"%ld",(long)index);
        [self btnClick:self.btnArray[index]];
        _isNeedScroll = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isNeedScroll = NO;
}


//pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger index =[self.collectionViewArray indexOfObject:collectionView];
    return [self.dataSource[index] count];
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeBtnItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeBtnItemCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
    NSInteger index =[self.collectionViewArray indexOfObject:collectionView];
    cell.dict = self.dataSource[index][indexPath.row];
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)   collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}



#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isLastObject = collectionView == [self.collectionViewArray lastObject]?YES:NO;
    return CGSizeMake(isLastObject?ScreenWidth/5:ScreenWidth/4, isLastObject?60:ScreenWidth/4);
}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    NSInteger index =[self.collectionViewArray indexOfObject:collectionView];
    NSDictionary * dict = self.dataSource[index][indexPath.row];
    [PushManager pushViewControllerWithName:dict[@"vcName"] animated:YES block:nil];
}


- (NSArray *)dataSource1 {
    if (!_dataSource1){
        _dataSource1 = @[
                        @[
                            @{@"title":@"请假历史",@"icon":@"home_eswp_gd",@"vcName":@"LeaveHistoryController"},
                            @{@"title":@"请假申请",@"icon":@"home_eswp_gd",@"vcName":@"ApplyLeaveController"},
                            @{@"title":@"签退签到",@"icon":@"home_eswp_gd",@"vcName":@"AttendanceController"},
                            ],
                        @[
                            @{@"title":@"表扬",@"icon":@"home_eswp_gd",@"vcName":@"PraiseController"},
                            @{@"title":@"投诉",@"icon":@"home_eswp_gd",@"vcName":@"ComplaintsController"},
                            @{@"title":@"安保管理",@"icon":@"home_eswp_gd",@"vcName":@""},
                            @{@"title":@"投票管理",@"icon":@"home_eswp_gd",@"vcName":@"VotingManageController"},
                            @{@"title":@"员工动态",@"icon":@"home_eswp_gd",@"vcName":@""},
                            @{@"title":@"公共报事",@"icon":@"home_eswp_gd",@"vcName":@""},
                            ],
                        @[
                            @{@"title":@"日考勤统计",@"icon":@"home_eswp_gd",@"vcName":@"DailyAttendanceController"},
                            @{@"title":@"月考勤统计",@"icon":@"home_eswp_gd",@"vcName":@"MonthlyAttendanceController"},
                            @{@"title":@"考勤汇总",@"icon":@"home_eswp_gd",@"vcName":@""},
                            @{@"title":@"临停车辆统计",@"icon":@"home_eswp_gd",@"vcName":@"CarOutController"},
                            @{@"title":@"物资车辆进入系统",@"icon":@"home_eswp_gd",@"vcName":@"GoodsCarController"},
                            @{@"title":@"来访统计",@"icon":@"home_eswp_gd",@"vcName":@"VisitingStatisticController"},
                            @{@"title":@"上门服务",@"icon":@"home_eswp_gd",@"vcName":@"DoorServiceController"},
                            @{@"title":@"公共报事",@"icon":@"home_eswp_gd",@"vcName":@"PublicThingsController"},
                            ],
                        @[
                            @{@"title":@"巡查计划",@"icon":@"home_eswp_gd",@"vcName":@"TourPlanController"},
                          ],
                        @[
                            @{@"title":@"待办",@"icon":@"home_eswp_gd",@"vcName":@"ToDoController"},
                            @{@"title":@"工作日志",@"icon":@"home_eswp_gd",@"vcName":@""},
                            @{@"title":@"我的消息",@"icon":@"home_eswp_gd",@"vcName":@"MyNewsController"},
                            @{@"title":@"通讯录",@"icon":@"home_eswp_gd",@"vcName":@"AddressBookController"},
                            @{@"title":@"我的排班",@"icon":@"home_eswp_gd",@"vcName":@"MySchedulingController"},
                            ],
                        ];
    }
    return _dataSource1;
}

- (NSArray *)dataSource2 {
    if (!_dataSource2){
        _dataSource2 = @[
                         @[
                             @{@"title":@"签退签到",@"icon":@"home_eswp_gd",@"vcName":@"AttendanceController"},
                             @{@"title":@"请假申请",@"icon":@"home_eswp_gd",@"vcName":@"ApplyLeaveController"},
                             @{@"title":@"请假历史",@"icon":@"home_eswp_gd",@"vcName":@"LeaveHistoryController"},
                             ],
                         @[
                             @{@"title":@"日考勤统计",@"icon":@"home_eswp_gd",@"vcName":@"DailyAttendanceController"},
                             @{@"title":@"月考勤统计",@"icon":@"home_eswp_gd",@"vcName":@"MonthlyAttendanceController"},
                             @{@"title":@"来访统计",@"icon":@"home_eswp_gd",@"vcName":@"VisitingStatisticController"},
                             @{@"title":@"车辆出入统计",@"icon":@"home_eswp_gd",@"vcName":@"CarOutController"},
                             @{@"title":@"物资车辆进出统计",@"icon":@"home_eswp_gd",@"vcName":@"GoodsCarController"},
                             ],
                         @[
                             @{@"title":@"员工抄表",@"icon":@"home_eswp_gd",@"vcName":@"PraiseController"},
                             @{@"title":@"表扬",@"icon":@"home_eswp_gd",@"vcName":@"PraiseController"},
                             @{@"title":@"投诉",@"icon":@"home_eswp_gd",@"vcName":@"ComplaintsController"},
                             @{@"title":@"巡查任务",@"icon":@"home_eswp_gd",@"vcName":@"TourPlanController"},
                             ],
                         @[
                             @{@"title":@"物资车辆入场登记",@"icon":@"home_eswp_gd",@"vcName":@"GoodsCarController"},
                             @{@"title":@"物资车辆出场登记",@"icon":@"home_eswp_gd",@"vcName":@"GoodsCarController"},
                             @{@"title":@"临停车辆入场登记",@"icon":@"home_eswp_gd",@"vcName":@"CarOutController"},
                             @{@"title":@"临停车辆出场登记",@"icon":@"home_eswp_gd",@"vcName":@"CarOutController"},
                             @{@"title":@"来访登记",@"icon":@"home_eswp_gd",@"vcName":@""},
                             @{@"title":@"安保巡查",@"icon":@"home_eswp_gd",@"vcName":@""},
                             ],
                         @[
                             @{@"title":@"待办",@"icon":@"home_eswp_gd",@"vcName":@"ToDoController"},
                             @{@"title":@"工作日志",@"icon":@"home_eswp_gd",@"vcName":@""},
                             @{@"title":@"我的消息",@"icon":@"home_eswp_gd",@"vcName":@"MyNewsController"},
                             @{@"title":@"通讯录",@"icon":@"home_eswp_gd",@"vcName":@"AddressBookController"},
                             @{@"title":@"我的排班",@"icon":@"home_eswp_gd",@"vcName":@"MySchedulingController"},
                             ],
                         ];
    }
    return _dataSource2;
}

//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:@"InfoNotification" name:nil object:self];
//}
@end
