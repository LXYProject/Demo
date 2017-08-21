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

@interface VillagePanoramaController ()<CLLocationManagerDelegate,MAMultiPointOverlayRendererDelegate, MAMapViewDelegate,TOPageTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navBgView;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *navBtn;
@property (nonatomic, strong) UILabel *redLine;

//请求完成的数据源
@property (nonatomic,strong)NSMutableArray *dataSource;
//title处理的数据源
@property (nonatomic,strong)NSMutableArray *featureCategoryArr;
//处理完类别的数据源
@property (nonatomic,strong)NSDictionary *fillterDataDictionary;
//当前选中的数据源
@property (nonatomic,strong)NSArray *currentDataSourceArray;

@property (nonatomic, copy) NSString *navStr;
//所有大头针位置的，x，y数组
@property (nonatomic,strong)NSMutableArray *pointArray;
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
    [self.view addSubview:self.mapView];
    //测试数据
   
    
    
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
    if (self.zoneName.length==0 && self.navTitle.length==0) {
        [self titleViewWithTitle:@"岷阳小区全景" titleColor:[UIColor whiteColor]];
    }
    if (self.x.length==0) {
        self.x = @"103.88842301";
        self.y = @"30.80872819";
    }
    [self rightItemWithNormalName:@""
                            title:@"上报设施"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    

    
    
    [self requestLookVillagePanorama];
    
    [self reverseGeocoder];
    
    
    [self testData];

}


- (void)testData {
    NSDictionary *dict =@{ @"featureList":@[
    @{
      @"featureCategory": @"饮料售卖机",
        @"featureId": @"20170628173228",
        @"featureName": @"售水机",
        @"featureX": @(103.88842301),
        @"featureY": @(38.80872819)
        },
    @{
      @"featureCategory": @"饮料售卖机",
        @"featureId": @"20170628173228",
        @"featureName": @"售水机",
        @"featureX": @(103.88842301),
        @"featureY": @(36.60872819)
        },
  @{
    @"featureCategory": @"超市",
      @"featureId": @"20170628173228",
      @"featureName": @"售水机",
      @"featureX": @(103.88842301),
      @"featureY": @(37.50872821)
      },
  @{
    @"featureCategory": @"饮料售卖机",
      @"featureId": @"20170628173228",
      @"featureName": @"售水机",
      @"featureX": @(103.88842301),
      @"featureY": @(32.40872818)
      },@{
          @"featureCategory": @"超市",
            @"featureId": @"20170628173228",
            @"featureName": @"售水机",
            @"featureX": @(103.88842301),
            @"featureY": @(33.30872810)
            },
  @{
    @"featureCategory": @"加油站",
      @"featureId": @"20170628173228",
      @"featureName": @"售水机",
      @"featureX": @(103.88842301),
      @"featureY": @(34.20872811)
      },
    
  @{
    @"featureCategory": @"共享单车",
      @"featureId": @"20170628173228",
      @"featureName": @"售水机",
      @"featureX": @(103.88842301),
      @"featureY": @(35.10872812)
      },
    
    ]
};
//    self.dataSource = [VillagePanoramaModel mj_objectArrayWithKeyValuesArray:dict[@"featureList"]];
//    [self filterDataSource];

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
//                                           [self createTitlesView];
                                           [self filterDataSource];
                                           
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           
                                       }];
}

- (void)createTitlesView{
    [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:@"全部"]];
    for (int i=0; i<self.dataSource.count; i++) {
        [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:[self.dataSource[i] featureCategory]]];
    }

}

- (void)filterDataSource {
    NSMutableDictionary *fillterDict = [NSMutableDictionary dictionaryWithCapacity:1];
    for (VillagePanoramaModel *model in self.dataSource) {
        if ([fillterDict.allKeys containsObject:model.featureCategory]) {
            NSMutableArray *filterChilds = [NSMutableArray arrayWithArray:fillterDict[model.featureCategory]];
            if (!filterChilds) {
                filterChilds = [NSMutableArray arrayWithCapacity:1];
            }
            [filterChilds addObject:model];
            [fillterDict setValue:filterChilds forKey:model.featureCategory];
        }
        else {
            NSMutableArray *fillterChilds = [NSMutableArray arrayWithCapacity:1];
            [fillterChilds addObject:model];
            [fillterDict setValue:fillterChilds forKey:model.featureCategory];
        }
    }
    self.fillterDataDictionary = fillterDict;
     [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:@"全部"]];
    for (NSString *key in fillterDict.allKeys) {
        [self.featureCategoryArr addObject:[TOPageItem itemWithTitle:key]];
    }
    self.titleView.titles = self.titles;
    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    self.titleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.titleView];
    self.currentDataSourceArray = self.dataSource;
    [self setPonitAnnView];
}

//将GPS转成高德坐标
//        CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(39.989612,116.480972), AMapCoordinateType);

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
            
            [self.mapView setCenterCoordinate:location.coordinate];
            [self.mapView setZoomLevel:16.1 animated:NO];

        } 
        
    }]; 
}

#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark - 设置大头针
- (void)setPonitAnnView {
    NSMutableArray *pointAnnotations = [NSMutableArray arrayWithCapacity:1];
    for (VillagePanoramaModel *model in self.currentDataSourceArray) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([model.featureY doubleValue], [model.featureX doubleValue]);
        [pointAnnotations addObject:pointAnnotation];
    }
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:pointAnnotations];
}

#pragma mark - 标题的点击代理
- (void)pageTitleView:(TOPageTitleView *)pageTitleView didSelecteIndex:(NSInteger)index oldIndex:(NSInteger)oldIndex {
    if (index ==0) {
        self.currentDataSourceArray = self.dataSource;
    }
    else {
        NSString *key = [[pageTitleView.titles objectAtIndex:index] title];
        NSLog(@"%@",key);
        self.currentDataSourceArray = self.fillterDataDictionary[key];
    }
    [self setPonitAnnView];
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
        _titleView.titleViewDelegate = self;
    }
    return _titleView;
}
- (NSMutableArray<TOPageItem *> *)titles{
    if (!_titles) {
        _titles = [NSMutableArray arrayWithArray:self.featureCategoryArr];
    }
    return _titles;
}

- (NSMutableArray *)pointArray {
    if (!_pointArray) {
        _pointArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _pointArray;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        
            
            ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
            [AMapServices sharedServices].enableHTTPS = YES;
            
            //        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
            _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, SCREEN_HEIGHT-119)];
    
        _mapView.delegate = self;
        
        

    }
    return _mapView;
}

@end
