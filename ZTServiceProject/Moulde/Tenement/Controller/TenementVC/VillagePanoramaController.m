//
//  VillagePanoramaController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VillagePanoramaController.h"
#import "TenementHttpManager.h"
#import "VillagePanoramaModel.h"

@interface VillagePanoramaController ()<CLLocationManagerDelegate,MAMultiPointOverlayRendererDelegate, MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navBgView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) UIScrollView *scrollView;




//查看查看小区全景 的数据相关的
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation VillagePanoramaController
{
    NSString *_featureX;
    NSString *_featureY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableArray *pointArray = [NSMutableArray arrayWithCapacity:1];
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(featureX, featureY);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";
//    self.mapView addAnnotations:<#(NSArray *)#>
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"小区全景"
                  titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"上报设施"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];

    
    
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow; // 追踪用户位置.
//    self.mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
//    self.mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);  //设置比例尺位置
//    self.mapView.scaleSize();
//    [self.mapView setZoomLevel:13 animated:YES];
//    MACoordinateSpan span = MACoordinateSpanMake(0.004913, 0.013695);
//    MACoordinateRegion region = MACoordinateRegionMake(_mapView.centerCoordinate, span);
//    _mapView.region = region;
    
    [self initMapView];
    
    [self configLocationManager];

    [self requestLookVillagePanorama];
    
    [self reverseGeocoder];

}

- (void)rightBarClick{
    [PushManager pushViewControllerWithName:@"ReportViewController" animated:YES block:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.locationManager startUpdatingLocation];
}
- (void)createNavBtn{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.dataSource.count*120, 49)];
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<self.dataSource.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(120*i, 9, 120, 30);
        [btn setTitle:[self.dataSource[i] featureCategory] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize: 14];
        [btn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        _featureX = [self.dataSource[i] featureX];
        _featureY = [self.dataSource[i] featureY];
        [self.scrollView addSubview:btn];
        NSLog(@"=====%@", [self.dataSource[i] featureCategory]);
    }
}

#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //两个授权设置选项
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//最高精度
    self.locationManager.distanceFilter = 1000.0f;//移动位置最小信息的距离
}

#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        [AMapServices sharedServices].enableHTTPS = YES;

//        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT-119)];
        self.mapView.showsUserLocation = YES;//这句就是开启定位

        [self.mapView setDelegate:self];
        
        [self.view addSubview:self.mapView];
    }
}

- (void)navBtnClick:(UIButton *)sender{
    NSLog(@"%ld", sender.tag);
    if (sender.selected) {
        //将GPS转成高德坐标
//        CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(39.989612,116.480972), AMapCoordinateType);
    }
}
// 小区全景
- (void)requestLookVillagePanorama{
    [TenementHttpManager requestListOrPanorama:VillagePanorama
                                        zoneId:self.zoneId
                                       success:^(id response) {
                                       
                                           [self.dataSource addObjectsFromArray:response];
                                           NSLog(@"self.dataSource==%@", self.dataSource);
                                           
                                           [self createNavBtn];

                                       } failure:^(NSError *error, NSString *message) {
                                       
                                       }];
}
/**
 地理反编码
 */
- (void)reverseGeocoder{
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    //经度
    NSString *longitude = @"103.88842301";
    //纬度
    NSString *latitude = @"30.80872819";
    
    
    //创建位置
    CLLocation *location=[[CLLocation alloc]initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    
    
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            //详细地址
            NSString *addressStr = placemark.name;
            NSLog(@"详细地址1：%@",addressStr);
            NSLog(@"详细地址2：%@",placemark.addressDictionary);
            NSLog(@"详细地址3：%@",placemark.locality);
//            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//            pointAnnotation.coordinate = CLLocationCoordinate2DMake(103.88842301, 30.80872819);
//            pointAnnotation.title = placemark.locality;
//            pointAnnotation.subtitle = placemark.name;
//            [self.mapView addAnnotation:pointAnnotation];
            
            if (self.pointAnnotaiton == nil)
            {
                self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
                [self.pointAnnotaiton setCoordinate:location.coordinate];
                [self.mapView addAnnotation:self.pointAnnotaiton];
            }
            
            [self.pointAnnotaiton setCoordinate:location.coordinate];
            
            [self.mapView setCenterCoordinate:location.coordinate];
            [self.mapView setZoomLevel:16.1 animated:NO];

        } 
        
    }]; 
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = NO;
        annotationView.animatesDrop     = NO;
        annotationView.draggable        = NO;
        annotationView.pinColor = MAPinAnnotationColorPurple;
//        annotationView.image            = [UIImage imageNamed:@"icon_location"];
        
        return annotationView;
    }
    
    return nil;
}

- (void)setFeatureCategory:(NSString *)featureCategory{
    _featureCategory = featureCategory;
    [self requestLookVillagePanorama];
}
- (void)setFeatureId:(NSString *)featureId{
    _featureId = featureId;
    [self requestLookVillagePanorama];

}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
