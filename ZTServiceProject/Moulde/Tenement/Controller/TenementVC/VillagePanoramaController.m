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
#import "TOPageTitleView.h"
#import "ReportViewController.h"

@interface VillagePanoramaController ()<CLLocationManagerDelegate,MAMultiPointOverlayRendererDelegate, MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navBgView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *navBtn;
@property (nonatomic, strong) UILabel *redLine;

//查看查看小区全景 的数据相关的
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *featureCategoryArr;
@property (nonatomic, copy) NSString *navStr;

@property (nonatomic,strong) TOPageTitleView *titleView;
@property (nonatomic,strong) NSMutableArray<TOPageItem *> *titles;


@end

@implementation VillagePanoramaController
{
    NSString *_featureX;
    NSString *_featureY;
    UIButton *_selectedBtn;

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
    if (_pushId==0) {
        [self titleViewWithTitle:[NSString stringWithFormat:@"%@全景", self.zoneName] titleColor:[UIColor whiteColor]];
    }else{
        [self titleViewWithTitle:[NSString stringWithFormat:@"%@全景", self.navTitle] titleColor:[UIColor whiteColor]];
    }
    [self rightItemWithNormalName:@""
                            title:@"上报设施"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    

    [self initMapView];
    
    [self requestLookVillagePanorama];
    
    [self reverseGeocoder];

}

- (void)rightBarClick{
    [PushManager pushViewControllerWithName:@"ReportViewController" animated:YES block:^(ReportViewController* viewController) {
        viewController.x = self.x;
        viewController.y = self.y;
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// 小区全景
- (void)requestLookVillagePanorama{
    @weakify(self);
    [TenementHttpManager requestListOrPanorama:VillagePanorama
                                        zoneId:self.zoneId
                                       success:^(id response) {
                                           @strongify(self);
                                           [self.dataSource addObjectsFromArray:response];
                                           NSLog(@"self.dataSource==%@", self.dataSource);
                                           
                                           // 创建 WSFSlideTitlesView
                                           [self createTitlesView];
                                           
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           
                                       }];
}

- (void)createTitlesView{
    [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:@"全部"]];
    for (int i=0; i<self.dataSource.count; i++) {
        [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:[self.dataSource[i] featureCategory]]];
    }
    self.titleView.titles = self.titles;
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.titleView];
}

//将GPS转成高德坐标
//        CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(39.989612,116.480972), AMapCoordinateType);


#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        [AMapServices sharedServices].enableHTTPS = YES;

//        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT-119)];
//        self.mapView.showsUserLocation = YES;//这句就是开启定位

        [self.mapView setDelegate:self];
        
        [self.view addSubview:self.mapView];
    }
}

/**
 地理反编码
 */
- (void)reverseGeocoder{
    //创建地理编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    //经度
    NSString *longitude = self.x;
    //纬度
    NSString *latitude = self.y;
    
    
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

- (NSArray *)featureCategoryArr{
    if (!_featureCategoryArr) {
        _featureCategoryArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _featureCategoryArr;
}

#pragma mark - Getter
- (TOPageTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[TOPageTitleView alloc] init];
        _titleView.miniGap = 10;
    }
    return _titleView;
}
- (NSMutableArray<TOPageItem *> *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:self.featureCategoryArr];
    }
    return _titles;
}

@end
