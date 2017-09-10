//
//  PublishServiceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PublishServiceController.h"
#import "AddPhotosCell.h"
#import "PublishServiceCell.h"
#import "NearByHttpManager.h"
#import "ACSelectMediaView.h"
#import "CityListViewController.h"
#import "LocationChoiceController.h"
#import "StaticlCell.h"
#import "ReleaseHelpCell.h"
#import "AddPhotosCell.h"

#define  placeholderColor   [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]
#define LabelY 615
@interface PublishServiceController ()<CityListViewDelegate, AMapLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)CGFloat addPhotoHeight;
@property (nonatomic, strong) NSMutableArray *chooseImgArr;
@property (nonatomic,assign)NSInteger nearBySelectIndex;

@property (nonatomic,strong)NSArray *imageModelArray;

@property (nonatomic,assign)CGFloat cellHight;

@end

@implementation PublishServiceController
{
    NSArray *_sectionOneArr;
    NSArray *_sectionTwoArr;
    NSArray *_sectionThreeArr;
    
    NSString *_serviceTitle;
    int  online;
    NSString *_price;
    NSString *_resourceId;
    MBProgressHUD *_hud;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.tableView reloadData];
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

}

- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addPhotoHeight = 100;
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"发布服务" titleColor:[UIColor whiteColor]];
    
    _sectionOneArr = @[@"描述", @"我在"];
    _sectionTwoArr = @[@"单位", @"服务类型", @"服务范围"];
    _sectionThreeArr = @[@"用图文详细描述你的服务", @"请选择地理位置"];
    
    [self createLabel];
    
//    self.tableView.tableHeaderView = [self headerView];

}

//- (UIView *)headerView {
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 100)];
//    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:self.tableView indenty:@"AddPhotosCell"];
//    cell.maxCount = 9;
//    cell.frame = view.bounds;
//    [cell.mediaView observeViewHeight:^(CGFloat mediaHeight) {
//        view.frame = CGRectMake(0, 0, ScreenWidth, mediaHeight);
//        cell.frame = view.bounds;
//        self.tableView.tableHeaderView=view;
//    }];
//    cell.finishedBlock = ^(NSArray *images) {
//        NSLog(@"images==%@", images);
//        
//        if (images.count==0) {
//            return;
//        }
//        if (self.chooseImgArr.count>0) {
//            [self.chooseImgArr removeAllObjects];
//        }
//        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            ACMediaModel *model = obj;
//            [self.chooseImgArr addObject:model.image];
//        }];
//        
//        // 上传图片
//        [self upImageArr];
//    };
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [view addSubview:cell];
//    return view;
//}

- (void)createLabel{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, LabelY, 250, 40);
    label.text = @"同意《正图生活平台服务者入住协议》";
    label.textColor = UIColorFromRGB(0xe64e51);
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        label.font = [UIFont systemFontOfSize:11];
    }else{
        label.font = [UIFont systemFontOfSize:12];
    }
    [self.tableView addSubview:label];
}

- (IBAction)releaseBtnClick {
    NSLog(@"online=%d", online);

    NSLog(@"latitude==%@", GetValueForKey(@"latitude"));

    // && self.categoryId.length>0
    if (_serviceTitle.length>0 && self.content.length>0 && _price.length>0 && self.unitStr.length>0 && self.serviceTypeStr>0) {
       
        // 发布
        @weakify(self);
        [NearByHttpManager rqeuestTitle:_serviceTitle
                                content:self.content
                                address:self.locationInfo
                                 online:online
                                  price:_price
                                   unit:self.unitStr
                             categoryId:self.cateId //self.categoryId
                           categoryName:self.serviceTypeStr
                                   area:@"110108"
                                 cityId:@"11000"
                             districtId:@"110108"
                                      x:GetValueForKey(@"longitude") //@"116.32"
                                      y:GetValueForKey(@"latitude")  //@"39.98"
                                  resId:@"510018177815"
                                resName:@"岷阳小区"
                                 images:_resourceId
                                success:^(id response) {
                                    
                                    @strongify(self);
                                    //操作失败的原因
                                    NSString *information = [response objectForKey:@"information"];
                                    //状态码
                                    NSString *status = [response objectForKey:@"status"];
                                    
                                    if ([status integerValue]==0) {
                                        [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:self.view Title:@"Success" detail:information cancelButton:nil Okbutton:@"Sure" block:^(HHAlertButton buttonindex) {
                                            if (buttonindex == HHAlertButtonOk) {
                                                NSLog(@"ok");
                                            }
                                            else
                                            {
                                                NSLog(@"cancel");
                                            }
                                        }];
                                    }else{
                                        [HHAlertView showAlertWithStyle:HHAlertStyleError inView:self.view Title:@"Error" detail:information cancelButton:nil Okbutton:@"I konw"];
                                    }
                                } failure:^(NSError *error, NSString *message) {
                                    
                                }];

    }else{
        [AlertViewController alertControllerWithTitle:@"提示" message:@"请完善信息" preferredStyle:UIAlertControllerStyleAlert controller:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if (section==0){
        return 1;
    }else if(section==1){
        return 3;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if(indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }

}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {

    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    [cell setImageMaxCount:3 imageArray:self.imageModelArray];
    [cell.mediaView observeViewHeight:^(CGFloat mediaHeight) {
        self.cellHight = mediaHeight;
    }];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
        
        if (images.count==0) {
            return;
        }
        self.imageModelArray = images;
        if (self.chooseImgArr.count>0) {
            [self.chooseImgArr removeAllObjects];
        }
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ACMediaModel *model = obj;
            [self.chooseImgArr addObject:model.image];
        }];
        // 上传图片
        [self upImageArr];
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


// 多表单上传图片
- (void)upImageArr{
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
    AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]init];
    
    NSDictionary *paramter = @{};
    
    NSString *url = @"http://192.168.1.96:8080/ZtscApp/Service?service=file&function=upload";
    [manager POST:url parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        for(UIImage *image in self.chooseImgArr) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //显示进度
          [uploadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    }success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        [_hud hide:YES];
        //显示返回对象
        NSLog(@"-------->%@",responseObject);
        
        NSDictionary *dictResult = responseObject[@"result"];
        NSLog(@"dictResult==%@", dictResult);
        
        _resourceId = [dictResult objectForKey:@"resourceId"];
        NSLog(@"resourceId==%@", _resourceId);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_hud hide:YES];
        //显示错误信息
        NSLog(@"-------->%@",error);
        
    }];
    
}
#pragma mark 上传进度

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        
        NSProgress *progress = (NSProgress *)object;
        
        _hud.progress = progress.fractionCompleted;
    }
    
}
//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.text = @"我能";
        cell.contentLeading.constant = 50;
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _serviceTitle = obj;
        };
        if (_serviceTitle.length>0) {
            cell.content.text = _serviceTitle;
        }else{
            cell.content.placeholder = @"为自己的服务起一个响亮的名字";
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
        }
        return cell;
    }else{
        ReleaseHelpCell *cell = (ReleaseHelpCell *)[self creatCell:tableView indenty:@"ReleaseHelpCell"];
        cell.title.text = _sectionOneArr[indexPath.row-1];
        cell.describe.text = _sectionThreeArr[indexPath.row-1];
    
        if (indexPath.row==2) {
            if (self.locationInfo.length>0) {
                cell.describe.text = self.locationInfo;
            }else{
                cell.describe.text = @"请选择地理位置";
            }
        }else{
            if (self.content.length>0) {
                cell.describe.text = self.content;
            }else{
                cell.describe.text = @"用图文详细描述你的服务";
            }
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
        }
        return cell;
    }
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        PublishServiceCell *cell = (PublishServiceCell *)[self creatCell:tableView indenty:@"PublishServiceCell"];
        cell.selectIndex = self.nearBySelectIndex;
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            self.nearBySelectIndex = value;
            online = (int)value;
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==1){
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.text = @"价格";
        cell.content.placeholder = @"请输入服务的价格（元）";
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _price = obj;
        };
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
        }
        cell.contentLeading.constant = 50;
        return cell;
    }else{
        ReleaseHelpCell *cell = (ReleaseHelpCell *)[self creatCell:tableView indenty:@"ReleaseHelpCell"];
        cell.title.text = _sectionTwoArr[indexPath.row-2];
        if (indexPath.row==2) {
            if (self.unitStr.length>0) {
                cell.describe.text = self.unitStr;
            }else{
                cell.describe.text = @"请选择";
            }
        }else if (indexPath.row==3){
            if (self.serviceTypeStr.length>0) {
                cell.describe.text = self.serviceTypeStr;
            }else{
                cell.describe.text = @"请选择";
            }
        }else{
            if (self.serviceScopeStr.length>0) {
                cell.describe.text = self.serviceScopeStr;
            }else{
                cell.describe.text = @"请选择";
            }
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
        }
        cell.describe.textAlignment = NSTextAlignmentRight;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            [PushManager pushViewControllerWithName:@"ServiceDescriptionController" animated:YES block:nil];
        }else{
            [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:^(LocationChoiceController* viewController) {
                viewController.currentController = 2;
            }];
        }
    }else{
        if (indexPath.row==0 || indexPath.row==1) {
            
        }else if (indexPath.row==2){
            [PushManager pushViewControllerWithName:@"ServiceUnitController" animated:YES block:nil];
        }else if (indexPath.row==3){
            [PushManager pushViewControllerWithName:@"SelectServiceTypeController" animated:YES block:nil];
        }else{
            // 服务范围
            [self serviceScope];
        }
    }

}

- (void)serviceScope{
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",
                                 @"北京",
                                 @"天津",
                                 @"厦门",
                                 @"重庆",
                                 @"福州",
                                 @"泉州",
                                 @"济南",
                                 @"深圳",
                                 @"长沙",
                                 @"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",
                                        @"厦门",
                                        @"泉州", nil];

    //定位城市列表
    NSString *locationCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationCity"];
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:locationCity, nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
    
}

- (void)didClickedWithCityName:(NSString*)cityName
{
    NSLog(@"cityName==%@", cityName);
    self.serviceScopeStr = cityName;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        return self.cellHight==0?100:self.cellHight;
    }else if (indexPath.section==1){
        return 50;
    }else{
        if (indexPath.row==0) {
            return 150;
        }else{
            return 50;
        }
    }
//    if(indexPath.section==0){
//        return 50;
//    }else{
//        if (indexPath.row==0) {
//            return 150;
//        }else{
//            return 50;
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSMutableArray *)chooseImgArr{
    if (!_chooseImgArr) {
        _chooseImgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _chooseImgArr;
}



@end
