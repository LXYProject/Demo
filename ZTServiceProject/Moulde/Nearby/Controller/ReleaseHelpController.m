//
//  ReleaseHelpController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseHelpController.h"
#import "AddPhotosCell.h"
#import "NearByHttpManager.h"
#import "DataPickerViewOneDemo.h"
#import "StaticlCell.h"
#import "ReleaseHelpCell.h"
#import "LocationChoiceController.h"

#define LabelY 515
@interface ReleaseHelpController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) CGFloat addPhotoHeight;
@property (nonatomic, strong) NSMutableArray *timeDataSource;
@property (nonatomic, strong) NSArray *timeDataArr;
@property (nonatomic, copy) NSString *timeStr;
@end

@implementation ReleaseHelpController
{
    NSArray *_sectionOneArr;
    UITextField *_textField;
    UILabel *_detailLabel;
    
    NSString *_helpTitle;
    NSString *_bounty;
    NSString *_validDate;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
   // [self.tableView reloadData];

}

- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"发布求助" titleColor:[UIColor whiteColor]];
    
    _sectionOneArr = @[@"我要", @"描述", @"赏金", @"我在", @"求助类型", @"有效期至"];
    
    [self createLabel];
    [self weekTime];
}

- (void)weekTime{
    
    NSDate *date = [NSDate date];//当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *formatDate = [formatter stringFromDate:date];
    [self.timeDataSource addObject:formatDate];
    for (int i=1; i<5; i++) {
        NSDate *nextDay = [NSDate dateWithTimeInterval:i*24*60*60 sinceDate:date];//后一天
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        NSString *DateTime = [formatter stringFromDate:nextDay];
        NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
        [self.timeDataSource addObject:DateTime];
    }
    NSLog(@"timeDataSource==%@", self.timeDataSource);
    self.timeDataArr = self.timeDataSource;
 
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
    [NearByHttpManager rqeuestTitle:_helpTitle
                            content:@""
                            address:self.locationInfo
                              price:_bounty
                         categoryId:self.categoryId
                       categoryName:self.serviceTypeStr
                          validDate:_validDate
                             cityId:@""
                         districtId:@""
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
}


//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
    };
    return cell;
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0 || indexPath.row==2) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        if (indexPath.row==0) {
            cell.title.text = @"我要";
            cell.content.placeholder = @"我需要别人帮我做什么";
            cell.textFieldBlock = ^(id obj) {
                NSLog(@"obj==%@", obj);
                _helpTitle = obj;
            };
        }else{
            cell.title.text = @"赏金";
            cell.content.placeholder = @"我愿意支付的报酬（元）";
            cell.textFieldBlock = ^(id obj) {
                NSLog(@"obj==%@", obj);
                _bounty = obj;
            };
        }
        cell.contentLeading.constant = 50;
        return cell;
    }else{
        ReleaseHelpCell *cell = (ReleaseHelpCell *)[self creatCell:tableView indenty:@"ReleaseHelpCell"];
        if (indexPath.row==1) {
            cell.title.text = @"描述";
            cell.describe.text = @"说一下具体的求助信息，清楚明确的";
        }else if (indexPath.row==3){
            cell.title.text = @"我在";
            if (self.locationInfo.length>0) {
                cell.describe.text = self.locationInfo;
            }else{
                cell.describe.text = @"选择服务地点";
            }
        }else if (indexPath.row==4){
            cell.title.text = @"求助类型";
            if (self.serviceTypeStr.length>0) {
                cell.describe.text = self.serviceTypeStr;
            }else{
                cell.describe.text = @"请选择";
            }
            cell.describe.textAlignment = NSTextAlignmentRight;
        }else{
            cell.title.text = @"有效期至";
            if (self.timeStr.length>0) {
                cell.describe.text = self.timeStr;
            }else{
                cell.describe.text = @"为求助选择一个截止时间";
            }
            cell.describe.textAlignment = NSTextAlignmentRight;
        }
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
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
        }else if (indexPath.row==1){
            
        }else if (indexPath.row==2){
            
        }else if (indexPath.row==3){
            [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:^(LocationChoiceController* viewController) {
                viewController.currentController = 4;
            }];
            
        }else if (indexPath.row==4){
            [PushManager pushViewControllerWithName:@"SelectHelpTypeController" animated:YES block:nil];
        }else{
            [[DataPickerViewOneDemo sharedPikerView]show];
            [DataPickerViewOneDemo sharedPikerView].title = @"选择截取时间";
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:self.timeDataArr];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.timeStr = dateStr;
               [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

            };
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 210;
    }else{
        return 50;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSMutableArray *)timeDataSource{
    if (!_timeDataSource) {
        _timeDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _timeDataSource;
}
@end
