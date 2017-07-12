//
//  MineViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MineViewController.h"
#import "HeadBackCell.h"
#import "HeadOtherCell.h"
#import "MineBtnCell.h"
#import "GroupNumberCell.h"
#import "RegisterFourController.h"

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MineViewController
{
    NSArray *_sectionOneTitle;
    NSArray *_sectionTwoTitle;
    NSArray *_sectionOneImg;
    NSArray *_sectionTwoImg;
   
    NSString *_token;
    BOOL login;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(247, 247, 247);

    self.navigationItem.title = nil;
    self.navigationBarBackGroudColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [Tools createImageWithColor:[UIColor clearColor]];
    
    _sectionOneTitle = @[@"我的消息",
                         @"我的邻里圈",
                         @"我的发布"];
    _sectionTwoTitle = @[@"我的房屋",
                         @"我的小区",
                         @"我的物业"];
    _sectionOneImg = @[@"message_tabbar_selected",
                       @"message_tabbar_selected",
                       @"message_tabbar_selected"];
    _sectionTwoImg= @[@"message_tabbar_selected",
                      @"message_tabbar_selected",
                      @"message_tabbar_selected"];
    
    _token = GetValueForKey(TokenKey);
    login = YES;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (login) {
        if (section==0) {
            return 2;
        }else if (section==1 || section==4){
            return 1;
        }else{
            return 3;
        }
    }else{
        if (section==0) {
            return 2;
        }else if (section==1){
            return 3;
        }else if (section==2){
            return 3;
        }else
            return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (login) {
        return 5;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
        
    }else{
        if (login) {
            if (indexPath.section==1) {
                MineBtnCell *cell = (MineBtnCell *)[self creatCell:tableView indenty:@"MineBtnCell"];
                return cell;
            }else{
                static NSString *ID = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
                }
                if (indexPath.section==2) {
                    cell.textLabel.text = _sectionOneTitle[indexPath.row];
                    cell.imageView.image = [UIImage imageNamed:_sectionOneImg[indexPath.row]];
                }else if (indexPath.section==3){
                    cell.textLabel.text = _sectionTwoTitle[indexPath.row];
                    cell.imageView.image = [UIImage imageNamed:_sectionTwoImg[indexPath.row]];
                }else{
                    cell.textLabel.text = @"设置";
                    cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
                }
                if (IS_IPHONE_6){
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                }else if (IS_IPHONE_6p){
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                }else{
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
                }
                
                return cell;

            }
        }else{
            static NSString *ID = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
            }
            if (indexPath.section==1){
                cell.textLabel.text = _sectionOneTitle[indexPath.row];
                cell.imageView.image = [UIImage imageNamed:_sectionOneImg[indexPath.row]];
            }else if (indexPath.section==2){
                cell.textLabel.text = _sectionTwoTitle[indexPath.row];
                cell.imageView.image = [UIImage imageNamed:_sectionTwoImg[indexPath.row]];
            }else{
                cell.textLabel.text = @"设置";
                cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
            }
            if (IS_IPHONE_6){
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }else if (IS_IPHONE_6p){
                cell.textLabel.font = [UIFont systemFontOfSize:14];
            }else{
                cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            }
            
            return cell;
        }

    }

}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (login) {
        if (indexPath.row==0) {
            HeadOtherCell *cell = (HeadOtherCell *)[self creatCell:tableView indenty:@"HeadOtherCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
 
        }else{
            GroupNumberCell *cell = (GroupNumberCell *)[self creatCell:tableView indenty:@"GroupNumberCell"];
            return cell;
        }
    }else{
        if (indexPath.row==0) {
            HeadBackCell *cell = (HeadBackCell *)[self creatCell:tableView indenty:@"HeadBackCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            MineBtnCell *cell = (MineBtnCell *)[self creatCell:tableView indenty:@"MineBtnCell"];
            return cell;

        }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (login) {
        if (indexPath.section==0) {
            if (indexPath.row ==0) {
                [PushManager pushViewControllerWithName:@"RegisterFourController" animated:YES block:^(RegisterFourController* viewController) {
                    viewController.experience = 1;
                }];
            }

        }else if (indexPath.section==2){
            if (indexPath.row==0) {
                [PushManager pushViewControllerWithName:@"MyNewsViewController" animated:YES block:nil];
            }else if (indexPath.row==1){
                [PushManager pushViewControllerWithName:@"NeighborCircleController" animated:YES block:nil];
            }else{
                [PushManager pushViewControllerWithName:@"MyReleaseViewController" animated:YES block:nil];
            }
        }else if (indexPath.section==3){
            if (indexPath.row==0) {
                [PushManager pushViewControllerWithName:@"MyHouseViewController" animated:YES block:nil];
            }else if(indexPath.row==1){
                [PushManager pushViewControllerWithName:@"MyNeighborController" animated:YES block:nil];
            }else{
                [PushManager pushViewControllerWithName:@"PropertyViewController" animated:YES block:nil];
            }
        }else if (indexPath.section==4){
            [PushManager pushViewControllerWithName:@"SettingViewController" animated:YES block:nil];
        }else{
            return;
        }
    }else{
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                [PushManager pushViewControllerWithName:@"MyNewsViewController" animated:YES block:nil];
            }else if (indexPath.row==1){
                [PushManager pushViewControllerWithName:@"NeighborCircleController" animated:YES block:nil];
            }else{
                [PushManager pushViewControllerWithName:@"MyReleaseViewController" animated:YES block:nil];
            }
        }else if (indexPath.section==2) {
            if (indexPath.row==0) {
                [PushManager pushViewControllerWithName:@"MyHouseViewController" animated:YES block:nil];
            }else if(indexPath.row==1){
                [PushManager pushViewControllerWithName:@"MyNeighborController" animated:YES block:nil];
            }else{
                [PushManager pushViewControllerWithName:@"PropertyViewController" animated:YES block:nil];
            }
        }else if (indexPath.section==3){
                [PushManager pushViewControllerWithName:@"SettingViewController" animated:YES block:nil];
        }else{
            return;
        }
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (login) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 118;
            }else{
                return 72;
            }
        }else if (indexPath.section==1){
            return 72;
        }else{
            return 44;
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 150;
            }else{
                return 72;
            }
        }else{
            return 44;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 10.f;
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
