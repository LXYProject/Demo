//
//  SaleOrderDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SaleOrderDetailsController.h"
#import "OrderHeadCell.h"
#import "OrderBodyCell.h"
#import "ServiceBodyCell.h"
#import "OrderSelectCell.h"

#define btnY 552
#define labelY 540
#define btnX 15
@interface SaleOrderDetailsController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SaleOrderDetailsController
{
    NSArray *_sectionTitle;
    NSArray *_sectionTwoTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);

    [self titleViewWithTitle:@"出售订单详情" titleColor:[UIColor whiteColor]];
    
    _sectionTitle = @[@"名称电话",
                      @"地址",
                      @"2017年07月05日 12:12:12",
                      @"留言"];
    _sectionTwoTitle = @[@"创建时间",
                         @"订单"];
    
    [self createUI];
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
    label.text = @"《正图生活平台服务者入住协议》";
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
    [submitBtn setTitle:@"评价" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];
    
}
- (void)submitCLick
{
    NSLog(@"评价");
}
- (void)styleBtnClick:(UIButton *)button{
    button.selected = !button.selected;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 6;
    }else if(section==1){
        return 2;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
        
    }
    else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        OrderHeadCell *cell = (OrderHeadCell *)[self creatCell:tableView indenty:@"OrderHeadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==1){
        OrderBodyCell *cell = (OrderBodyCell *)[self creatCell:tableView indenty:@"OrderBodyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else{
        static NSString *ID = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        cell.textLabel.text = _sectionTitle[indexPath.row-2];
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        return cell;
    }

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        ServiceBodyCell *cell = (ServiceBodyCell *)[self creatCell:tableView indenty:@"ServiceBodyCell"];
        cell.model = self.model;
        return cell;
    }else{
        OrderSelectCell *cell = (OrderSelectCell *)[self creatCell:tableView indenty:@"OrderSelectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                     indexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.text = _sectionTwoTitle[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 66;
        }else{
            return 44;
        }
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            return 94;
        }else{
            return 49;
        }
    }else{
        return 44;
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
