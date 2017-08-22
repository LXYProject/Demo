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
#import "AddPhotosCell.h"

#define LabelY 515
@interface ReleaseHelpController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) CGFloat addPhotoHeight;
@property (nonatomic, strong) NSMutableArray *timeDataSource;
@property (nonatomic, strong) NSArray *timeDataArr;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, strong) NSMutableArray *chooseImgArr;
@end

@implementation ReleaseHelpController
{
    NSArray *_sectionOneArr;
    UITextField *_textField;
    UILabel *_detailLabel;
    
    NSString *_helpTitle;
    NSString *_bounty;
    NSString *_resourceId;
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
    @weakify(self);
    [NearByHttpManager rqeuestTitle:_helpTitle
                            content:self.content    
                            address:self.locationInfo
                              price:_bounty
                         categoryId:self.cateId //self.categoryId
                       categoryName:self.serviceTypeStr
                          validDate:self.timeStr
                             cityId:@"11000"
                         districtId:@"110108"
                                  x:@"116.32"
                                  y:@"39.98"
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
        
        if (images.count==0) {
            return;
        }
        if (self.chooseImgArr.count>0) {
            [self.chooseImgArr removeAllObjects];
        }
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ACMediaModel *model = obj;
            [self.chooseImgArr addObject:model.image];
        }];
        
        // 上传图片
        [self upImageArr];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

    
}

// 多表单上传图片
- (void)upImageArr{
    
    
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
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        //显示返回对象
        NSLog(@"-------->%@",responseObject);
        
        NSDictionary *dictResult = responseObject[@"result"];
        NSLog(@"dictResult==%@", dictResult);
        
        _resourceId = [dictResult objectForKey:@"resourceId"];
        NSLog(@"resourceId==%@", _resourceId);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //显示错误信息
        NSLog(@"-------->%@",error);
        
    }];
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0 || indexPath.row==2) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        if (indexPath.row==0) {
            cell.title.text = @"我要";
            cell.textFieldBlock = ^(id obj) {
                NSLog(@"obj==%@", obj);
                _helpTitle = obj;
            };
            if (_helpTitle.length>0) {
                cell.content.text = _helpTitle;
            }else{
                cell.content.placeholder = @"我需要别人帮我做什么";
            }
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
            if (self.content.length>0) {
                cell.describe.text = self.content;
            }else{
                cell.describe.text = @"说一下具体的求助信息，清楚明确的";
            }
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
            [PushManager pushViewControllerWithName:@"HelpDescriptionController" animated:YES block:nil];
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

- (NSMutableArray *)chooseImgArr{
    if (!_chooseImgArr) {
        _chooseImgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _chooseImgArr;
}

@end
