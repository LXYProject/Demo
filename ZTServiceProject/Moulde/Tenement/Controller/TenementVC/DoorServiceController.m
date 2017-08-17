//
//  DoorServiceController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "DoorServiceController.h"
#import "StaticlCell.h"
#import "StaticOneCell.h"
#import "SolicitingHeadCell.h"
#import "DoorServiceCell.h"
#import "AddPhotosCell.h"
#import "DataPickerViewDemo.h"
#import "TenementHttpManager.h"
#import "ServiceTypeController.h"
#import "ACMediaModel.h"

@interface DoorServiceController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString* makeTimeStr;

@property (nonatomic, strong) NSMutableArray *chooseImgArr;
@end

@implementation DoorServiceController
{
    NSArray *_titleArray;
    NSArray *_describeArray;
    NSString *_data;
    NSString *_hour;
    
    NSString *_serviceDiscribe;//报事内容
    NSString *_userRealName;   //上报人的真实姓名
    NSString *_userPhoneNum;   //上报人的现用手机号
    NSString *_resourceId;
    NSString *_serviceTime;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"上门服务" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"提交"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    _titleArray = @[@"联系人:",
                    @"联系电话:"];
    _describeArray = @[@"输入您的姓名",
                      @"输入您的电话"];
    self.tableView.backgroundColor = RGB(247, 247, 247);
    
//    _userRealName = @"王先生";
//    _userPhoneNum = @"15201087720";
//
}

- (void)rightBarClick
{
    NSLog(@"提交");
    
    if (_userRealName.length>0 && _userPhoneNum.length>0 && _serviceDiscribe.length>0 && self.serviceType>0 && self.makeTimeStr.length>0) {
        
        // 发送上门服务信息
        @weakify(self);
        [TenementHttpManager requestZoneId:self.zoneId
                              serviceTitle:@"发送上门服务信息"
                           serviceDiscribe:_serviceDiscribe
                           serviceCategory:self.serviceType
                               serviceTime:_serviceTime
                               userAddress:@"北京市 海淀区 财智大厦 c305室"
                              userRealName:_userRealName
                              userPhoneNum:_userPhoneNum
                                   houseId:@"510002004020"
                                 houseName:@"1单元 1层 2室"
                                         x:@"116.32"
                                         y:@"74.57"
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

// 发送上门服务信息
- (void)requestLookvisitService{
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1 || section==2) {
        return 2;
    }else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==3) {
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==4) {
        return [self sectionFourTableView:tableView indexPath:indexPath];
    }
    else{
        return nil;
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
    cell.textLabel.text = @"选择房屋";
    cell.imageView.image = [UIImage imageNamed:@"dw"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
    cell.title.textColor = TEXT_COLOR;
    cell.title.text = _titleArray[indexPath.row];
    cell.content.placeholder = _describeArray[indexPath.row];
    if (indexPath.row==0) {
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userRealName = obj;
        };
    }else{
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userPhoneNum = obj;
        };
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.textLabel.text = @"选择类型:";
        if (self.serviceType.length>0) {
            cell.detailTextLabel.text = self.serviceType;
        }else{
            cell.detailTextLabel.text = @"请选择类型";
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        cell.detailTextLabel.textColor = TEXT_COLOR;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        DoorServiceCell *cell = (DoorServiceCell *)[self creatCell:tableView indenty:@"DoorServiceCell"];
        cell.textViewBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _serviceDiscribe = obj;
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = @"预约时间:";
    if (_data.length>0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", _data,_hour];
        self.makeTimeStr = cell.detailTextLabel.text;
        _serviceTime = [NSString stringWithFormat:@"%@:00", self.makeTimeStr];
    }else{
        cell.detailTextLabel.text = @"请选择上门时间";
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = TEXT_COLOR;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

//第4组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
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
        
    }else if (indexPath.section==1){
        
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"ServiceTypeController" animated:YES block:^(ServiceTypeController* viewController) {
                viewController.zoneId = self.zoneId;
            }];
        }
    }else if (indexPath.section==3){
        [[DataPickerViewDemo sharedPikerView]show];
        [DataPickerViewDemo sharedPikerView].pikerSelected = ^(NSString *dateStr, NSString *timeStr) {
            NSLog(@"date:%@,time:%@",dateStr,timeStr);
            _data = dateStr;
            _hour = timeStr;
            [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }else{
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section ==1) {
        return 44;
    }else if (indexPath.section ==2) {
        if (indexPath.row==0) {
            return 44;
        }else{
            return 100;
        }
    }else if (indexPath.section==3){
        return 44;
    }
    else {
        return 100;
    }
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return 0.f;
//    }else{
//        return 5.f;
//    }
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    view.backgroundColor = RGB(247, 247, 247);
//    return view;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footView = [[UIView alloc] init];
//    footView.backgroundColor = [UIColor clearColor];
//    return footView;
//}
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 1;
//}

@end
