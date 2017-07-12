//
//  MyReleaseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyReleaseViewController.h"

@interface MyReleaseViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyReleaseViewController
{
    NSArray *_sectionOneTitle;
    NSArray *_sectionTwoTitle;
    NSArray *_sectionOneImg;
    NSArray *_sectionTwoImg;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我的发布" titleColor:[UIColor whiteColor]];
    
    _sectionOneTitle = @[@"我的闲置",
                         @"我发布的出租屋"];
    _sectionTwoTitle = @[@"我发布的服务",
                         @"我发布的求助"];
    _sectionOneImg = @[@"message_tabbar_selected",
                       @"message_tabbar_selected"];
    _sectionTwoImg= @[@"message_tabbar_selected",
                      @"message_tabbar_selected"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.section==0) {
        cell.textLabel.text = _sectionOneTitle[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_sectionOneImg[indexPath.row]];
    }else{
        cell.textLabel.text = _sectionTwoTitle[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_sectionTwoImg[indexPath.row]];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"MySpareViewController" animated:YES block:nil];
        }else{
            [PushManager pushViewControllerWithName:@"MyReleasedHouseController" animated:YES block:nil];
        }
    }else{
        if (indexPath.row==0) {
            [PushManager pushViewControllerWithName:@"MyServiceController" animated:YES block:nil];
        }else{
            [PushManager pushViewControllerWithName:@"MyPostedHelpController" animated:YES block:nil];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
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
