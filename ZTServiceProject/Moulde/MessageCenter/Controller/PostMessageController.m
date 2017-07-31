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

//#define btnY 542
//#define labelY 530
//#define btnX 15
#define btnY 275
#define labelY 263
#define btnX 15
@interface PostMessageController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PostMessageController
{
    NSString *_affairDiscribe;
}

- (void)setLocationInfo:(NSString *)locationInfo{
    _locationInfo = locationInfo;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"新帖子" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    [self createUI];
}

- (void)rightBarClick
{
    NSLog(@"发布帖子");
    [MesssgeHttpManager requestContent:_affairDiscribe
                                photos:@""
                                cityId:@""
                            districtId:@""
                               address:@""
                                 resId:@""
                               resName:@""
                               success:^(id response) {
                               } failure:^(NSError *error, NSString *message) {
                                   
                               }];

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
        PostContentCell *cell = (PostContentCell *)[self creatCell:tableView indenty:@"PostContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textViewBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _affairDiscribe = obj;
        };
        return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (self.locationInfo.length>0) {
        cell.textLabel.text = self.locationInfo;
    }else{
        cell.textLabel.text = @"请选择位置信息";
    }
    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor = TEXT_COLOR;
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
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        [PushManager pushViewControllerWithName:@"LocationChoiceController" animated:YES block:^(LocationChoiceController* viewController) {
            viewController.currentController = 0;
        }];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==2) {
        return 49;
    }else{
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

@end
