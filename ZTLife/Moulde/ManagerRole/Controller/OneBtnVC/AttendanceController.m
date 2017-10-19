//
//  AttendanceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AttendanceController.h"

@interface AttendanceController ()<MAMapViewDelegate,AMapSearchDelegate>


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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

    [self initMapView];
    [self initLocationButton];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode: UITrackingRunLoopMode];
    [self createTimeLabel];
}

- (void)rightBarClick{
    NSLog(@"考勤记录");
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
@end
