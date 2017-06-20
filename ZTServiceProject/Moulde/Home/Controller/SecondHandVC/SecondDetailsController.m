//
//  SecondDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondDetailsController.h"
#import "SecondBannerCell.h"
#import "SecondDetailsCell.h"
#import "SecondBtnItemCell.h"
#import "SecondUserCell.h"  
#import "SecondAddressCell.h"

@interface SecondDetailsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SecondDetailsController
{
    NSArray *imageNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                   ];
    
    [self titleViewWithTitle:@"手游" titleColor:[UIColor whiteColor]];
   [self rightItemWithNormalName:@"" title:@"搜索" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];    self.tableView.backgroundColor = RGB(247, 247, 247);
    
    Model *model = [[Model alloc] initWithTitle:@"hahahh" content:@"撒大声地聚聚不不不好好好好回家多大的呜呜呜进给速度密码是什么忙项目明细内心世界你打我电话我那还好一头热撒大声地聚聚不不不好好好好回家多大的呜呜呜进给速度密码是什么忙项目明细内心世界你打我电话我那还好一头热"];
    [self.dataArray addObject:model];

    Model *mode2 = [[Model alloc] initWithTitle:@"hahahh" content:@"撒大声地聚聚不不不好好好好回家多大的呜呜呜进给速度密码是什么忙项目明细内心世界你打我电话我那还好一头热撒大声地聚聚不不不好好好好回家多大的呜呜呜进给速度密码是什么忙项目明细内心世界你打我电话我那还好一头热"];
    [self.dataArray addObject:mode2];
    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 1;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
//    else if (indexPath.section==2){
//        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
//    }else if (indexPath.section==3){
//        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
//    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SecondBannerCell *cell = (SecondBannerCell *)[self creatCell:tableView indenty:@"SecondBannerCell"];
        cell.secondModelArray = imageNames;
//        cell.modelArray = self.imageURLArray;
        return cell;
    }else if (indexPath.row==1){
        SecondDetailsCell *cell = (SecondDetailsCell *)[self creatCell:tableView indenty:@"SecondDetailsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else if (indexPath.row==2){
        SecondUserCell *cell = (SecondUserCell *)[self creatCell:tableView indenty:@"SecondUserCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        SecondAddressCell *cell = (SecondAddressCell *)[self creatCell:tableView indenty:@"SecondAddressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    SecondBtnItemCell *cell = (SecondBtnItemCell *)[self creatCell:tableView indenty:@"SecondBtnItemCell"];
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
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 270;
        }else if (indexPath.row==1){
            Model *model = self.dataArray[indexPath.row];
            return model.cellHeight;
        }
        else{
            return 44;
        }
    }else if (indexPath.section==1){
        return 44;
    }
    else{
        return 0;
    }
}

-(NSMutableArray *)dataArray{
    
    
    if (!_dataArray) {
        
        
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

@end
