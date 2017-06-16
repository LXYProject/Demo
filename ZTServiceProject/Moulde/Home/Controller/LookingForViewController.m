//
//  LookingForViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LookingForViewController.h"
#import "StaticlCell.h"
#import "BtnItemCell.h"
#import "AddPhotosCell.h"
#import "BabyDescriptionCell.h"

@interface LookingForViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,assign)NSInteger section;

@end

@implementation LookingForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleArray = @[
                   @"物品名称：",
                   @"品牌型号：",
                   @"新旧程度：",
                   @"价格范围：",
                   ];
    
//    if (self.section==0) {
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    }else{
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 4;
    }else if(section ==1){
        return 1;
    }
    else if(section ==2){
        return 1;
    }
    else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }
    else{
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    BtnItemCell *cell = (BtnItemCell *)[self creatCell:tableView indenty:@"BtnItemCell"];
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    BabyDescriptionCell *cell = (BabyDescriptionCell *)[self creatCell:tableView indenty:@"BabyDescriptionCell"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
            return 44;
    }
    else if (indexPath.section ==1) {
        return 85;
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

@end
