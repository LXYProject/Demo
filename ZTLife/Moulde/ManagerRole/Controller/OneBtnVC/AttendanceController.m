//
//  AttendanceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AttendanceController.h"
#import "UpPartHttpManager.h"
#import "MySchedulingModel.h"
#import "ManagerRoleHttp.h"
#import "SignTokenModel.h"

@interface AttendanceController ()<MAMapViewDelegate,AMapSearchDelegate>
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIButton *dayBeforeBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentDay;
@property (weak, nonatomic) IBOutlet UILabel *classTypes;      //排班类型
@property (nonatomic, strong) NSMutableArray *dataSource;      //排班数据
@property (nonatomic, strong) NSMutableArray *signTokenSource; //排班数据

@end

@implementation AttendanceController
{
    MAMapView *_mapView;
    // 高德API不支持定位开关，需要自己设置
    UIButton *_locationBtn;
    UIImage *_imageLocated;
    UIImage *_imageNotLocate;
    // 第一次定位标记
    BOOL isFirstLocated;
    UILabel *timeLabel;
    NSTimer *_timer;
    
    NSString *_actionDesc;
}

// 禁止侧滑手势
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rt_disableInteractivePop = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.rt_disableInteractivePop = NO;
    _mapView.delegate = nil; //不用时，置nil
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"考勤" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"考勤记录" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];


    // 排班计划--查
    [self requestScheduling];

    
    [self initMapView];
    
    [self initLocationButton];
    

    
    [_mapView addSubview:self.view1];
    [_mapView addSubview:self.view2];

    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode: UITrackingRunLoopMode];
    
    [self createTimeLabel];
    
    
    // 获取签到签退令牌
    [self requestSignToken];
    
}

- (void)rightBarClick{
    NSLog(@"考勤记录");
}

// 排班计划--查
- (void)requestScheduling{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString1 = [dateFormatter1 stringFromDate:currentDate];
    NSString *threeStr1 = @" 00:00:00";
    NSString *startTime = [NSString stringWithFormat:@"%@%@", dateString, threeStr1];
    NSString *threeStr2 = @" 23:00:00";
    NSString *endTime = [NSString stringWithFormat:@"%@%@", dateString, threeStr2];
    NSString *weekString = [Tools weekdayStringFromDate:currentDate];
    NSLog(@"-%@",weekString);
    self.currentDay.text = [NSString stringWithFormat:@"%@   %@", dateString1, weekString];
    
    @weakify(self);
    [UpPartHttpManager requestWorkerId:@""
                                 orgId:@""
                                deptId:@""
                             startTime:startTime
                               endTime:endTime
                         workShiftType:@""
                            workPlanId:@""
                             machineId:[getUUID getUUID]
                           machineName:[Tools deviceVersion]
                            clientType:@""
                               success:^(id response) {
                                   @strongify(self);
                                   [self.dataSource removeAllObjects];
                                   [self.dataSource addObjectsFromArray:response];
                                   for (MySchedulingModel *model in self.dataSource) {
                                       self.classTypes.text = model.workshiftName;
                                   }
                               } failure:^(NSError *error, NSString *message) {
                                   
                               }];
    
}

// 班次类型--查
- (void)requestShiftType{
    [ManagerRoleHttp requestcode:@""
                            name:@""
                     workShiftId:@""
                       machineId:[getUUID getUUID]
                     machineName:[Tools deviceVersion]
                      clientType:@"0"
                         success:^(id response) {
                         
                         } failure:^(NSError *error, NSString *message) {
                         
                         }];
}

// 获取签到签退令牌
- (void)requestSignToken{
    [ManagerRoleHttp requestSignTokenSuccess:^(id response) {
        //_actionDesc = [response objectForKey:@"action"];
        if ([[response objectForKey:@"action"] integerValue]==0) {
            _actionDesc = @"不可签退，不可签到";
        }else if ([[response objectForKey:@"action"] integerValue]==1) {
            _actionDesc = @"可签到， 不可签退";
        }else{
            _actionDesc = @"不可签到，可签退";
        }
        SignTokenModel *model = [SignTokenModel mj_objectWithKeyValues:response[@"workplan"]];
        self.classTypes.text = model.workshiftType;

    } failure:^(NSError *error, NSString *message) {
    }];
}

// 签到
- (void)requestSignIn{
    [ManagerRoleHttp requestSignType:Sign_in
                           SignToken:@""
                          workPlanId:@""
                                gpsX:@""
                                gpsY:@""
                           locationX:@""
                           locationY:@""
                        locationName:@""
                           machineId:[getUUID getUUID]
                         machineName:[Tools deviceVersion]
                          clientType:@"0"
                             success:^(id response) {
                             
                             } failure:^(NSError *error, NSString *message) {
                             
                             }];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 首次定位
    if (updatingLocation && !isFirstLocated) {
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        isFirstLocated = YES;
    }
}

#pragma mark - 初始化
- (void)initMapView
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, (SCREEN_HEIGHT/4)*2)];
    _mapView.delegate = self;
    // 不显示罗盘
    _mapView.showsCompass = NO;
    // 不显示比例尺
    _mapView.showsScale = NO;
    // 地图缩放等级
    _mapView.zoomLevel = 16;
    // 开启定位
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
}

- (void)initLocationButton
{
    _imageLocated = [UIImage imageNamed:@"gpsselected"];
    _imageNotLocate = [UIImage imageNamed:@"gpsnormal"];
    _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 320, 40, 40)];
    _locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _locationBtn.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _locationBtn.layer.cornerRadius = 3;
    [_locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
    [self.view addSubview:_locationBtn];
}

#pragma mark - Action
- (void)actionLocation
{
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

- (void)createTimeLabel{
    
    UIButton *qiandaoBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100) * .5, (SCREEN_HEIGHT/4)*2+50, 100, 100)];
    [qiandaoBtn setImage:[UIImage imageNamed:@"btn_qiandao"] forState:UIControlStateNormal];
    [qiandaoBtn addTarget:self action:@selector(qiandaoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qiandaoBtn];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT/4)*2+170, SCREEN_WIDTH, 13)];
    timeLabel.alpha = .56;
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = [NSString stringWithFormat:@"%@",dateString];
    [self.view  addSubview:timeLabel];
}

- (void)qiandaoAction{
    
}


- (void)timeAction{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    timeLabel.text = [NSString stringWithFormat:@"%@",dateString];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (NSMutableArray *)signTokenSource{
    if (!_signTokenSource) {
        _signTokenSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}
@end
