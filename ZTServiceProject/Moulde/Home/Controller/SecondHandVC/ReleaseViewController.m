//
//  ReleaseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/19.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseViewController.h"
#import "AddPhotosCell.h"
#import "SolicitingHeadCell.h"
#import "BabyDescriptionCell.h"
#import "SwitchCell.h"
#import "HomeHttpManager.h"
#import "DataPickerViewOneDemo.h"
#import "LocationChoiceController.h"
#import "ReleaseClassifiedController.h"
#import "ACMediaModel.h"

//#define btnY 440
//#define labelY 428
//#define btnX 15
#define btnY 542
#define labelY 530
#define btnX 15
@interface ReleaseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy)NSString* oldAndNew;

@property (nonatomic, strong) NSMutableArray *chooseImgArr;

@property (nonatomic,strong)NSArray *imageModelArray;

@property (nonatomic,assign)CGFloat cellHight;

@end

@implementation ReleaseViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSArray *_switchArray;
    UISwitch *_mySwitch;
    
    NSString *_babyTitle;
    NSString *_price;
    NSString *_content;
    
    double oriPrice;
    double secPrice;
    NSString *_resourceId;
    int delivery;    //是否支持快递
    double newOrOld; //新旧程度
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];

}
- (void)setOtherClass:(NSString *)otherClass{
    _otherClass = otherClass;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"发布宝贝" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布须知" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    _titleArray = @[@"宝贝标题 :",
                    @"分类 :",
                    @"价格（元）:"];
    _contentArray = @[@"填写品牌型号更容易被卖家买到",
                      @"",
                      @"请输入价格"];
    _switchArray = @[@"新旧 :",
                     @"支持快递 :",
                     @"原价（元）:"];
    
    [self createUI];
}
- (void)rightBarClick
{
    
}

- (void)createUI
{
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.frame = CGRectMake(btnX, btnY, 15, 15);
    [chooseBtn setImage:[UIImage imageNamed:@"否@3x"] forState:UIControlStateNormal];
    [chooseBtn setImage:[UIImage imageNamed:@"是@3x"] forState:UIControlStateSelected];
    [chooseBtn addTarget:self action:@selector(styleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:chooseBtn];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(btnX+10+15, labelY, 200, 40);
    label.text = @"在邻里圈展示, 曝光更多卖更快哦~";
    label.textColor = TEXT_COLOR;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        label.font = [UIFont systemFontOfSize:11];
    }else{
        label.font = [UIFont systemFontOfSize:12];
    }
    [self.tableView addSubview:label];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, labelY+40, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    [submitBtn setTitle:@"发布" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];
    
}

- (void)submitCLick
{
    NSLog(@"二手物品发布");
    NSLog(@"newOrOld==%f",newOrOld);
    NSLog(@"delivery==%d",delivery);
    if (_babyTitle.length>0 && _content.length>0  && _price.length>0) {
        @weakify(self);
        [HomeHttpManager requestTitle:_babyTitle
                              content:_content
                             pictures:_resourceId
                               cityId:@"11000"
                           districtId:@"110108"
                              address:self.locationInfo
                                resId:@"510018177815"
                              resName:@"岷阳小区"
                                    x:@"116.32"
                                    y:@"39.98"
                             oriPrice:oriPrice
                             secPrice:secPrice
                             delivery:delivery
                              classId:@""
                             newOrOld:newOrOld
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
- (void)styleBtnClick:(UIButton *)button{
    button.selected = !button.selected;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0 || section==2) {
        return 1;
    }else if (section==1){
        return 4;
    }
    else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section==2){
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==3){
        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
    }
    return nil;
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
    
    if (indexPath.row==3) {
        BabyDescriptionCell *cell = (BabyDescriptionCell *)[self creatCell:tableView indenty:@"BabyDescriptionCell"];
        cell.textViewBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _content = obj;
        };
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    
    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
    cell.title.text = _titleArray[indexPath.row];
    cell.content.placeholder = _contentArray[indexPath.row];
    if (indexPath.row==1) {
        if (self.otherClass.length>0) {
            cell.rightContent.text = self.otherClass;
        }else{
            cell.rightContent.text = @"其他";
        }
        cell.content.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [cell.rightContent removeFromSuperview];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row==0) {
            cell.textFieldBlock = ^(id obj) {
                NSLog(@"obj==%@", obj);
                _babyTitle = obj;
            };
            if (_babyTitle.length>0) {
                cell.content.text = _babyTitle;
            }else{
                cell.content.placeholder = @"填写品牌型号更容易被卖家买到";
            }
        }else{
            cell.textFieldBlock = ^(id obj) {
                NSLog(@"obj==%@", obj);
                _price = obj;
                secPrice =  [_price doubleValue];
            };
            if (_price.length>0) {
                cell.content.text = _price;
            }else{
                cell.content.placeholder = @"请输入价格";
            }
        }
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
        cell.rightContent.font = [UIFont systemFontOfSize:11];
        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
        cell.rightContent.font = [UIFont systemFontOfSize:14];
        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    cell.title.textColor = TEXT_COLOR;
    cell.rightContent.textColor = TEXT_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.locationInfo.length>0) {
        cell.textLabel.text = self.locationInfo;
    }else{
        cell.textLabel.text = @"请选择位置信息";
    }
    cell.imageView.image = [UIImage imageNamed:@"dw"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        if (self.oldAndNew.length>0) {
            cell.detailTextLabel.text = self.oldAndNew;
        }else{
            cell.detailTextLabel.text = @"新旧程度";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row==1){
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-85, 7, 20, 10)];
        switchButton.onTintColor = [UIColor redColor];
        //switchButton.thumbTintColor=[UIColor redColor];
        // 控件大小，不能设置frame，只能用缩放比例
        switchButton.transform= CGAffineTransformMakeScale(0.95,0.85);
        // 控件开关
        [switchButton setOn:YES];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.detailTextLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.text = _switchArray[indexPath.row];
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.textColor = TEXT_COLOR;
    return cell;
}

- (void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        delivery = 0;
    }else {
        delivery = 1;
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
        if (indexPath.row==1) {
            [PushManager pushViewControllerWithName:@"ReleaseClassifiedController" animated:YES block:^(ReleaseClassifiedController* viewController) {
                viewController.currentController = 0;
            }];
        }
    }else if (indexPath.section==2){
        [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:^(LocationChoiceController* viewController) {
            viewController.currentController = 1;
        }];

    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            [[DataPickerViewOneDemo sharedPikerView]show];
            [DataPickerViewOneDemo sharedPikerView].title = @"选择新旧程度";
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:@[@"无所谓", @"全新", @"九成新", @"七成新", @"五成新", @"旧货"]];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.oldAndNew = dateStr;
                if ([self.oldAndNew isEqualToString:@"无所谓"]) {
                    newOrOld = 10.0;
                }else if ([self.oldAndNew isEqualToString:@"全新"]){
                    newOrOld = 1;
                }else if ([self.oldAndNew isEqualToString:@"九成新"]){
                    newOrOld = 0.9;
                }else if ([self.oldAndNew isEqualToString:@"七成新"]){
                    newOrOld = 0.7;
                }else if ([self.oldAndNew isEqualToString:@"五成新"]){
                    newOrOld = 0.5;
                }else{
                    newOrOld = 0.0;
                }
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }
    }else{
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.cellHight==0?100:self.cellHight;
    }else if (indexPath.section ==1) {
        if (indexPath.row==3) {
            return 100;
        }else{
            return 44;
        }
    }else {
        return 44;
    }
}

- (NSMutableArray *)chooseImgArr{
    if (!_chooseImgArr) {
        _chooseImgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _chooseImgArr;
}
@end
