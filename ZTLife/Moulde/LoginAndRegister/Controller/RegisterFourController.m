//
//  RegisterFourController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/30.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "RegisterFourController.h"
#import "RegisterHeadCell.h"
#import "BDImagePicker.h"
#import "LoginHttpManager.h"
#import "YJSelectionView.h"
#import "UICustomDatePicker.h"
#import "CityListViewController.h"

#define btnY 420
@interface RegisterFourController ()<CityListViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString* genderStr;
@property (nonatomic, copy) NSString* birthdayStr;
@property (nonatomic, copy) NSString* hometownStr;
@end

@implementation RegisterFourController
{
    NSArray *_sectionOneArr;
    NSArray *_sectionTwoArr;
    NSArray *_sectionThreeArr;
    
    UIImage *_headImage;
    NSArray *_genderArr;
    NSString *_resourceId;
    int _age;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    
    if (_experience==0) {
        self.navigationItem.leftBarButtonItem = nil;
        UIButton *leftMask =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
        leftMask.backgroundColor = UIColorFromRGB(0xe64e51);
        UIBarButtonItem *leftItemBtn = [[UIBarButtonItem alloc] initWithCustomView:leftMask];
        self.navigationItem.leftBarButtonItem = leftItemBtn;
        [self titleViewWithTitle:@"恭喜您 注册成功" titleColor:[UIColor whiteColor]];
    }else{
        [self titleViewWithTitle:@"个人信息" titleColor:[UIColor whiteColor]];
        
    }
    _sectionOneArr = @[@"昵称", @"性别", @"生日"];
    _sectionTwoArr = @[@"个性签名", @"故乡"];
    _sectionThreeArr = @[@"联系方式", @"我的地址"];
    _genderArr = @[@"男", @"女"];
    
    [self.tableView reloadData];
    [self createUI];
}

- (void)createUI
{
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, btnY, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    if (_experience==0) {
        [submitBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    }else{
        [submitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];
}

- (void)submitClick
{
    if (_experience==0) {
        NSLog(@"立即体验");
        [self.navigationController  popToRootViewControllerAnimated:YES];
        
    }else{
        NSLog(@"退出登录");
        [self createAlertView];
    }
}

- (void)createAlertView{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"你确定要退出登录吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"哈哈");
        [[UserInfoManager sharedUserInfoManager] removeUserInfo];
        [[PushManager shareManager]backLoginVc];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:determineAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if(indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else if(indexPath.section==2){
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionThreeWithTableView:tableView indexPath:indexPath];
    }
//        }else{
//            static NSString *ID = @"cell";
//            // 根据标识去缓存池找cell
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//            // 不写这句直接崩掉，找不到循环引用的cell
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//            }
//            if (indexPath.section==1) {
//                cell.textLabel.text = _sectionOneArr[indexPath.row];
//                if (indexPath.row==0) {
//                    cell.detailTextLabel.text = GetValueForKey(NickNameKey);
//                }else if (indexPath.row==1){
//                    cell.detailTextLabel.text = GetValueForKey(GenderKey);
//                }else{
//                    return nil;
//                }
//            }else if (indexPath.section==2){
//                cell.textLabel.text = _sectionTwoArr[indexPath.row];
//            }else{
//                cell.textLabel.text = _sectionThreeArr[indexPath.row];
//                if (indexPath.row==0) {
//                    cell.detailTextLabel.text = GetValueForKey(PhoneNumKey);
//                }
//            }
//            if (IS_IPHONE_4 || IS_IPHONE_5) {
//                cell.textLabel.font = [UIFont systemFontOfSize:13];
//                cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
//            }else{
//                cell.textLabel.font = [UIFont systemFontOfSize:14];
//                cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//            }
//            cell.detailTextLabel.text = @"hhh";
//            cell.textLabel.textColor = TEXT_COLOR;
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            return cell;
//    
//        }
//    
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    RegisterHeadCell *cell = (RegisterHeadCell *)[self creatCell:tableView indenty:@"RegisterHeadCell"];
    if (_headImage) {
        cell.headIcon.image = _headImage;
    }else{
        //        cell.headIcon.image = [UIImage imageNamed:@"Oval 3 Copy"];
        [cell.headIcon sd_setImageWithURL:[NSURL URLWithString:[UserInfoManager sharedUserInfoManager].userInfoModel.headImage?[UserInfoManager sharedUserInfoManager].userInfoModel.headImage:@""] placeholderImage:[UIImage imageNamed:@"Oval 3 Copy"]];
    }
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        //cell.detailTextLabel.text = self.nickNameStr;
        cell.detailTextLabel.text = [UserInfoManager sharedUserInfoManager].userInfoModel.nickName;
    }else if (indexPath.row==1){
        //cell.detailTextLabel.text = self.genderStr;
        if ([[UserInfoManager sharedUserInfoManager].userInfoModel.gender integerValue]==0) {
            cell.detailTextLabel.text = @"女";
        }else{
            cell.detailTextLabel.text = @"男";
        }
    }else{
        cell.detailTextLabel.text = self.birthdayStr;
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = UIColorFromRGB(0xb2b2b2);
    cell.textLabel.text = _sectionOneArr[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        cell.detailTextLabel.text = self.signatureStr;
    }else{
        cell.detailTextLabel.text = self.hometownStr;
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.text = _sectionTwoArr[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

//第3组
- (UITableViewCell *)sectionThreeWithTableView:(UITableView *)tableView
                                     indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        //cell.detailTextLabel.text = GetValueForKey(PhoneNumKey);
        //字符串的截取
        NSString *string = [[UserInfoManager sharedUserInfoManager].userInfoModel.phoneNum substringWithRange:NSMakeRange(3,4)];
        //字符串的替换
        cell.detailTextLabel.text = [[UserInfoManager sharedUserInfoManager].userInfoModel.phoneNum stringByReplacingOccurrencesOfString:string withString:@"****"];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.text = _sectionThreeArr[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
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
{  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            NSLog(@"image==%@", image);
            if (image) {
                //_selectPhoto = image;
                _headImage = image;
                
                //上传图片
                [self upHeadImage];
                
                //修改头像
                if (_resourceId.length>0) {
                    
                    @weakify(self);
                    [LoginHttpManager requestImage:_resourceId
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
                    [AlertViewController alertControllerWithTitle:@"提示" message:@"稍等" preferredStyle:UIAlertControllerStyleAlert controller:self];
                }
                
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"ChangeNickNameController" animated:YES block:nil];
        }else if (indexPath.row==1){
            // 选择性别
            [YJSelectionView showWithTitle:@"性别" options:@[@"男", @"女"] singleSelection:YES delegate:self completionHandler:^(NSInteger index, NSArray *array) {
                NSLog(@"index==%ld", index);
                if (index==0) {
                    self.genderStr = @"男";
                    _age = 0;
                    [self requestGender];
                }else if(index==1){
                    self.genderStr = @"女";
                    _age = 1;
                    [self requestGender];
                    
                }else{
                    self.genderStr = @"";
                }
                for (id obj in array) {
                    NSLog(@"obj==%@", obj);
                }
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
        }else{
            // 弹出时间选择器
            [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
                NSLog(@"current Date:%@",date);
                //用于格式化NSDate对象
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //设置格式：zzz表示时区
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                //NSDate转NSString
                self.birthdayStr = [dateFormatter stringFromDate:date];
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [self requestBirth];
                
            } cancelBlock:^{
                
            }];
        }
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"ChangeSignatureController" animated:YES block:nil];
        }else{
            [self hometown];
        }
    }else{
        return;
    }
}

//
- (void)upHeadImage{
    
    
    AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc]init];
    
    NSDictionary *paramter = @{};
    
    NSString *url = @"http://192.168.1.96:8080/ZtscApp/Service?service=file&function=upload";
    
    [manager POST:url parameters:paramter constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(_headImage, 0.5);
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.png" mimeType:@"image/png"];
        
        NSString*size=@"1000";
        
        NSData *data = [size dataUsingEncoding:NSUTF8StringEncoding];
        
        
        [formData appendPartWithFormData:data name:@"size"];
        
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

// 修改性别
- (void)requestGender{
    
    
    //    NSString *testStr = @"{\"nickName\":\"1545454sdasd\",\"gender\":\"1\", \"selfIntroduction\":\"哈哈\",\"birth\":\"2015-05-05\", \"hometown\":\"成都市\",\"hometownCode\":\"510100\"}";
    
    
    NSDictionary  *dict = @{@"gender":@(_age)};
    
    NSString *jsonStr = [Tools convertToJsonData:dict];
    
    NSLog(@"=================%@", [Tools convertToJsonData:dict]);
    
    @weakify(self);
    [LoginHttpManager requestProps:jsonStr
                           success:^(id response) {
                               //操作失败的原因
                               @strongify(self);
                               NSString *information = [response objectForKey:@"information"];
                               //状态码
                               NSString *status = [response objectForKey:@"status"];
                               
                               if ([status integerValue]==0) {
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }else{
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }
                           } failure:^(NSError *error, NSString *message) {
                               
                           }];
}

// 修改性别
- (void)requestBirth{
    
    NSDictionary  *dict = @{@"birth":self.birthdayStr};
    
    NSString *jsonStr = [Tools convertToJsonData:dict];
    
    NSLog(@"=================%@", [Tools convertToJsonData:dict]);
    
    @weakify(self);
    [LoginHttpManager requestProps:jsonStr
                           success:^(id response) {
                               //操作失败的原因
                               @strongify(self);
                               NSString *information = [response objectForKey:@"information"];
                               //状态码
                               NSString *status = [response objectForKey:@"status"];
                               
                               if ([status integerValue]==0) {
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }else{
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }
                           } failure:^(NSError *error, NSString *message) {
                               
                           }];
}

//self.hometownStr
- (void)requestHometown{
    
    NSDictionary  *dict = @{@"hometown":self.hometownStr};
    
    NSString *jsonStr = [Tools convertToJsonData:dict];
    
    NSLog(@"=================%@", [Tools convertToJsonData:dict]);
    
    @weakify(self);
    [LoginHttpManager requestProps:jsonStr
                           success:^(id response) {
                               //操作失败的原因
                               @strongify(self);
                               NSString *information = [response objectForKey:@"information"];
                               //状态码
                               NSString *status = [response objectForKey:@"status"];
                               
                               if ([status integerValue]==0) {
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }else{
                                   [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                               }
                           } failure:^(NSError *error, NSString *message) {
                               
                           }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        return 72;
    }else{
        return 44;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)hometown
{
    NSLog(@"leftBarClick");
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
    self.hometownStr = cityName;
    [self requestHometown];
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
