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

#define  placeholderColor   [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9]
#define LabelY 615
@interface PublishServiceController ()<CityListViewDelegate, AMapLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)CGFloat addPhotoHeight;

@end

@implementation PublishServiceController
{
    NSArray *_sectionOneArr;
    NSArray *_sectionTwoArr;
    NSArray *_sectionThreeArr;
    
    NSString *_serviceTitle;
    NSString *_online;
    NSString *_price;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];

}

- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    
}

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
    
    // 发布
    [NearByHttpManager rqeuestTitle:_serviceTitle
                            content:self.content
                            address:self.locationInfo
                             online:_online
                              price:_price
                               unit:self.unitStr
                         categoryId:self.categoryId
                       categoryName:self.serviceTypeStr
                               area:@""
                             cityId:@""
                                  x:@""
                                  y:@""
                              resId:@""
                            resName:@""
                             images:@""
                            success:^(id response) {
                            
                            } failure:^(NSError *error, NSString *message) {
                            
                            }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 3;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }

}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {

    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    [cell.mediaView observeViewHeight:^(CGFloat mediaHeight) {
        self.addPhotoHeight = mediaHeight;
        [self.tableView reloadData];
    }];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
    };
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.text = @"我能";
        cell.content.placeholder = @"为自己的服务起一个响亮的名字";
        cell.contentLeading.constant = 50;
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _serviceTitle = obj;
        };
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
        
    }else if (indexPath.section==1) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return self.addPhotoHeight;
    }else if(indexPath.section==1){
        return 50;
    }else{
        if (indexPath.row==0) {
            return 150;
        }else{
            return 50;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

@end
