//
//  PostMessageController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/29.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PostMessageController.h"
#import "PostContentCell.h"
#import "AddPhotosCell.h"
#import "MesssgeHttpManager.h"
#import "LocationChoiceController.h"
#import "OldMainViewController.h"
#import "PlaceTextView.h"
#import "ACMediaModel.h"
#import "HttpAPIManager.h"

//#define btnY 542
//#define labelY 530
//#define btnX 15
#define btnY 275
#define labelY 263
#define btnX 15

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
// 是否为iOS8.4
#define isNotVersion84                  ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.4)


@interface PostMessageController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PlaceTextView * textView;
@property (nonatomic, strong) NSMutableArray *chooseImgArr;
@property (nonatomic, strong) NSMutableArray *imgDataArr;

@property (nonatomic, strong) UIView *sectionOneBg;
@property (nonatomic, strong) UIView *sectionTwoBg;
@property (nonatomic, strong) UIView *sectionThreeBg;
@property (nonatomic,strong)NSArray *imageModelArray;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation PostMessageController
{
    NSString *_affairDiscribe;
    UIImage *_chooseImage;
    NSString *_resourceId;
    MBProgressHUD *_hud;
    CGFloat _cellHeight;
}


- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)setPosition:(NSString *)position{
    _position = position;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    self.view.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"新帖子" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    
    self.textView.returnKeyType = UIReturnKeyDone;
//    [self createUI];
    
//    [self.view addSubview:self.sectionOneBg];
//    [self.sectionOneBg addSubview:self.textView];
//    [self.view addSubview:self.sectionTwoBg];
//    self.sectionTwoBg = [self headerView];
    
    _cellHeight = 100;
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bagTap)];
    tapGesturRecognizer.numberOfTouchesRequired =1;
    tapGesturRecognizer.numberOfTapsRequired = 1;
    tapGesturRecognizer.delegate = self;
    [self.tableView addGestureRecognizer:tapGesturRecognizer];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){
        
        return NO;
        
    }
    
    return YES;
    
    
    
}

- (void)bagTap{
    [self.view endEditing:YES];
}

- (void)rightBarClick
{
    NSLog(@"发布帖子");
    
    if (self.textView.text.length>0) {
        
        @weakify(self);
        [MesssgeHttpManager requestContent:self.textView.text
                                    photos:_resourceId
                                    cityId:@""
                                districtId:@""
                                   address:self.locationInfo
                                     resId:@""
                                   resName:@""
                                         x:@""
                                         y:@""
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
                                                   [PushManager popToRootViewControllerAnimated:YES];
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
    label.text = @"发布位置";
    label.textColor = TEXT_COLOR;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        label.font = [UIFont systemFontOfSize:11];
    }else{
        label.font = [UIFont systemFontOfSize:12];
    }
    [self.tableView addSubview:label];
}


- (void)styleBtnClick:(UIButton *)button{
    button.selected = !button.selected;
}

#pragma mark - UITextViewDelegate

-(PlaceTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceTextView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"分享新鲜事...";
    }
    
    return _textView;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (void)sendFeedBack{
    
    NSLog(@"=======%@",self.textView.text);
    
}

- (UIView *)headerView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 110, ScreenWidth, 100)];
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:self.tableView indenty:@"AddPhotosCell"];
    cell.maxCount = 9;
    cell.frame = view.bounds;
    [cell.mediaView observeViewHeight:^(CGFloat mediaHeight) {
        view.frame = CGRectMake(0, 0, ScreenWidth, mediaHeight);
        cell.frame = view.bounds;
        self.tableView.tableHeaderView=view;
    }];
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
    [view addSubview:cell];
    return view;
}

- (UIView *)sectionOneBg{
    if (!_sectionOneBg) {
        _sectionOneBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _sectionOneBg;
}

- (UIView *)sectionTwoBg{
    if (!_sectionTwoBg) {
        _sectionTwoBg = [[UIView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 100)];
    }
    return _sectionTwoBg;
}

- (UIView *)sectionThreeBg{
    if (!_sectionThreeBg) {
        _sectionThreeBg = [[UIView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 100)];
    }
    return _sectionThreeBg;

}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }else{
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
    if (![cell.contentView.subviews containsObject:self.textView]) {
        [cell.contentView addSubview:self.textView];
    }
    return cell;
    
    //    PostContentCell *cell = (PostContentCell *)[self creatCell:tableView indenty:@"PostContentCell"];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.textViewBlock = ^(id obj) {
    //        NSLog(@"obj==%@", obj);
    //        _affairDiscribe = obj;
    //    };
    //    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:self.tableView indenty:@"AddPhotosCell"];

    [cell setImageMaxCount:9 imageArray:self.imageModelArray];
    [cell.mediaView observeViewHeight:^(CGFloat mediaHeight) {
        NSLog(@"%f", mediaHeight);
        _cellHeight = mediaHeight;

    }];
    cell.finishedBlock = ^(NSArray *images) {
        if(images.count==0) {
            return;
        }
        self.imageModelArray = images;
        NSLog(@"images==%@", images);
        if (self.chooseImgArr.count>0) {
            [self.chooseImgArr removeAllObjects];
        }
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ACMediaModel *model = obj;
            [self.chooseImgArr addObject:model.image];
            
            _chooseImage = model.image;
        }];
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
       
        
        // 多表单上传图片
        [self upImageArr];
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (void)upImage{
    NSMutableArray *imageDatas = [NSMutableArray arrayWithCapacity:1];
    for (int i=0; i<self.chooseImgArr.count; i++) {
        
        for (id value in self.chooseImgArr) {
            
            NSData *imageData = UIImageJPEGRepresentation(value, 0.5);
            
            [imageDatas addObject:imageData];
        }
    }
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [[HttpAPIManager sharedHttpAPIManager] uploadDataArrayWithUrl:@"?service=file&function=upload" fileData:imageDatas type:@"image/png" name:@"file" mimeType:@"file.png" paramter:nil progressBlock:^(CGFloat progress) {
        _hud.progress = progress;
    } success:^(id response) {
        [_hud hide:YES];
        
        NSDictionary *dictResult = response[@"result"];
        
        _resourceId = [dictResult objectForKey:@"resourceId"];
        
        NSLog(@"resourceId==%@", _resourceId);
        
    } failure:^(NSArray *failure) {
        NSLog(@"failure==%@", failure);
        [_hud hide:YES];
    }];
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
        
        //    NSString*size=@"1000";
        //
        //    NSData *data = [size dataUsingEncoding:NSUTF8StringEncoding];
        //
        //
        //    [formData appendPartWithFormData:data name:@"size"];
        
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

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (self.position.length>0) {
        //cell.textLabel.text = self.locationInfo;
        cell.textLabel.text = self.position;
        
        self.deleteBtn.hidden = NO;
        if (![cell.contentView.subviews containsObject:self.deleteBtn]) {
            [cell.contentView addSubview:self.deleteBtn];
        }
        
        
    }else{
        cell.textLabel.text = @"请选择位置信息";
        self.deleteBtn.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:@"dw"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    return cell;
}

- (void)deleteBtnClick{
    self.position = @"";
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];

}

//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section==2){
        if (isNotVersion84) {
            [PushManager pushViewControllerWithName:@"OldMainViewController" animated:YES block:^(LocationChoiceController* viewController) {
                viewController.currentController = 0;
            }];
        }else{
            [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:^(OldMainViewController* viewController) {
                viewController.currentController = 0;
            }];
            
        }
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==2) {
        return 49;
    }else if (indexPath.section ==1){
        return _cellHeight;
    }
    else {
        return 100;
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

- (NSMutableArray *)chooseImgArr{
    if (!_chooseImgArr) {
        _chooseImgArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _chooseImgArr;
}

- (NSMutableArray *)imgDataArr{
    if (!_imgDataArr) {
        _imgDataArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgDataArr;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(SCREEN_WIDTH-50, 14, 20, 20);
        _deleteBtn.backgroundColor = [UIColor redColor];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}


@end
