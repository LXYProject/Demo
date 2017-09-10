//
//  SolicitingViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitingViewController.h"
#import "SolicitingHeadCell.h"
#import "SolicitBtnItemCell.h"
#import "SolicitBtnItemOneCell.h"
#import "SolicitItemCell.h"
#import "AddPhotosCell.h"
#import "SolicitDescriptionCell.h"
#import "DataPickerViewOneDemo.h"
#import "DataPickerViewTwoDemo.h"
#import "ACMediaModel.h"
#import "SolicitOneRowCell.h"
#import "HomeHttpManager.h" 

@interface SolicitingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *toward;
@property (nonatomic, strong) NSMutableArray *chooseImgArr;

@property (nonatomic,strong)NSArray *imageModelArray;

@property (nonatomic,assign)CGFloat cellHight;

@end

@implementation SolicitingViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSArray *_rightArray;
    
    NSString *_content;
    NSString *_resourceId;
    NSString *_textStr1;
    NSString *_textStr2;
    NSString *_houseType; //户型
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"求租" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    _titleArray = @[@"租金:",
                    @"户型:",
                    @"朝向:"];
    _contentArray = @[@"请选择户型", @"请选择朝向"];
    _rightArray = @[@"",
                    @"选择",
                    @"南"];
    


    [self.tableView reloadData];
    
}

- (void)rightBarClick
{
    NSLog(@"发布");
    @weakify(self);
    [HomeHttpManager requestHouseId:@"510002004020" houseNumber:@"1单元 1层 1室" buildingId:@"" buildingName:@"" villageId:@"" villageName:@"" isMaisonette:@"" houseType:@"" heatingMode:@"" elevatorRatio:@"" hasElevator:0 houseFloor:0 floorAll:0 rentArea:20.00 direction:@"" isBasement:0 houseFitment:@"" houseUseful:@"" housePics:@"" cityId:@"" cityName:@"" districtId:@"" districtName:@"" provinceId:@"" provinceName:0.0 x:0.0 y:0.0 roadName:@"" address:@"北京市 海淀区" rentPrice:1500.00 partOrTotal:0 basicFacilities:@"" extendedFacilities:@"" rentLimit:@"" description:@"" success:^(id response) {
        
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
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    else if (section==1){
        return 2;
    }
    else{
        return 1;
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
    }else if (indexPath.section==4){
        return [self sectionFourTableView:tableView indexPath:indexPath];
    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        SolicitOneRowCell *cell = (SolicitOneRowCell *)[self creatCell:tableView indenty:@"SolicitOneRowCell"];
        cell.textField1.text = _textStr1;
        cell.textField2.text = _textStr2;
        if (cell.textField1) {
            cell.textFieldBlock = ^(UITextField *textField, NSInteger index) {
                if (index ==1) {
                    _textStr1 = textField.text;
                }
                else {
                    _textStr2 = textField.text;
                }
            };
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==1){
        cell.textLabel.text = @"户型:";
        if (_houseType.length>0) {
            cell.detailTextLabel.text = _houseType;
        }else{
            cell.detailTextLabel.text = @"请选择户型";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text = @"朝向:";
        if (self.toward.length>0) {
            cell.detailTextLabel.text = self.toward;
        }else{
            cell.detailTextLabel.text = @"请选择朝向";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    return cell;

//    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
//    if (indexPath.row==0) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    if (indexPath.row==2) {
//        [cell.content removeFromSuperview];
//    }
//    cell.title.text = [NSString stringWithFormat:@"%@:", _titleArray[indexPath.row]];
//    cell.content.placeholder = _contentArray[indexPath.row];
//    cell.rightContent.text = _rightArray[indexPath.row];
//    if (IS_IPHONE_4 || IS_IPHONE_5) {
//        cell.title.font = [UIFont systemFontOfSize:13];
//        cell.rightContent.font = [UIFont systemFontOfSize:13];
//        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
//    }else{
//        cell.title.font = [UIFont systemFontOfSize:14];
//        cell.rightContent.font = [UIFont systemFontOfSize:14];
//        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//    }
//    cell.title.textColor = TEXT_COLOR;
//    cell.rightContent.textColor = TEXT_COLOR;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        SolicitBtnItemCell *cell = (SolicitBtnItemCell *)[self creatCell:tableView indenty:@"SolicitBtnItemCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        SolicitBtnItemOneCell *cell = (SolicitBtnItemOneCell *)[self creatCell:tableView indenty:@"SolicitBtnItemOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    SolicitItemCell *cell = (SolicitItemCell *)[self creatCell:tableView indenty:@"SolicitItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
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
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:3];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;}

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

//第4组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    
    SolicitDescriptionCell *cell = (SolicitDescriptionCell *)[self creatCell:tableView indenty:@"SolicitDescriptionCell"];
    cell.textViewBlock = ^(id obj) {
        NSLog(@"obj==%@", obj);
        _content = obj;
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            [[DataPickerViewTwoDemo sharedPikerView]show];
            [DataPickerViewTwoDemo sharedPikerView].pikerSelected = ^(NSString *dateStr, NSString *timeStr, NSString *threeStr) {
                NSLog(@"date:%@%@%@",dateStr, timeStr, threeStr);
                
                _houseType = [NSString stringWithFormat:@"%@%@%@", dateStr, timeStr, threeStr];
                
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }else{
            [[DataPickerViewOneDemo sharedPikerView]show];
            [DataPickerViewOneDemo sharedPikerView].title = @"选择房屋朝向";
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:@[@"无所谓了", @"东", @"西", @"南", @"北", @"东南", @"西南", @"西北", @"东北"]];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.toward = dateStr;
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            };

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section==1) {
        return 44;
    }
    else if (indexPath.section ==2) {
        return 110;
    }
    else {
        return self.cellHight==0?100:self.cellHight;
    }
}

- (NSMutableArray *)chooseImgArr{
    if (!_chooseImgArr) {
        _chooseImgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _chooseImgArr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
