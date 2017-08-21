//
//  ReportViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportCell.h"

#define TITLE_HEIGHT                    32.f

@interface ReportViewController ()<CLLocationManagerDelegate, MAMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MAMapView *mapView;
@property(nonatomic,strong)CLLocationManager* locationManager;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;

@end

@implementation ReportViewController
{
    // 地图中心点的标记
    UIImageView *_centerMaker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"小区设施上报" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"上报"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    self.tableView.bounces = NO;
    
    [self reverseGeocoder];

}

- (void)rightBarClick{
    NSLog(@"上报");
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else{
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {

    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    self.mapView = [[MAMapView alloc] initWithFrame:cell.bounds];
    self.mapView.delegate = self;
    [cell.contentView addSubview:self.mapView];
    
    UIImage *image = [UIImage imageNamed:@"wateRedBlank"];
    _centerMaker = [[UIImageView alloc] initWithImage:image];
    _centerMaker.frame = CGRectMake(ScreenWidth/2-image.size.width/2,150-image.size.height/2, image.size.width, image.size.height);
    //_centerMaker.frame = CGRectMake(self.view.frame.size.width/2-image.size.width/2, _mapView.bounds.size.height/2-image.size.height, image.size.width, image.size.height);
    //_centerMaker.center = CGPointMake(self.view.frame.size.width / 2, (CGRectGetHeight(_mapView.bounds) -  _centerMaker.frame.size.height - TITLE_HEIGHT) * 0.5);
    
    
    [cell.contentView addSubview:_centerMaker];


    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.textLabel.text = @"设施类型";
        cell.detailTextLabel.text = @"设置";
        cell.textLabel.textColor = TEXT_COLOR;
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];

        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        ReportCell *cell = (ReportCell *)[self creatCell:tableView indenty:@"ReportCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"FacilitiesTypeController" animated:YES block:nil];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 300;
    }else{
        if (indexPath.row==0) {
            return 44;
        }else{
            return 88;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 5.f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(247, 247, 247);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
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
            
//            if (self.pointAnnotaiton == nil)
//            {
//                self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
//                [self.pointAnnotaiton setCoordinate:location.coordinate];
//                [self.mapView addAnnotation:self.pointAnnotaiton];
//            }
//            
//            [self.pointAnnotaiton setCoordinate:location.coordinate];
            
            [self.mapView setCenterCoordinate:location.coordinate];
            [self.mapView setZoomLevel:16.1 animated:NO];
            
        }
        
    }];
}

#pragma mark - MAMapView Delegate
//
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
//        
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//        }
//        
//        annotationView.canShowCallout   = NO;
//        annotationView.animatesDrop     = NO;
//        annotationView.draggable        = NO;
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        //        annotationView.image            = [UIImage imageNamed:@"icon_location"];
//        
//        return annotationView;
//    }
//    
//    return nil;
//}

- (void)initCenterMarker
{
}
@end
