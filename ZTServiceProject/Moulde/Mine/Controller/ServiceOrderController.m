//
//  ServiceOrderController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/2.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceOrderController.h"
#import "ServiceOrderCell.h"
#import "ServiceHeadCell.h"
#import "ServiceBodyCell.h"
#import "BtnSelectCell.h"
@interface ServiceOrderController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation ServiceOrderController
{
    UIButton *_selectedBtn;
    //0  代表我的购买 1、我的出售
    NSInteger _selectIndexNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"服务订单" titleColor:[UIColor whiteColor]];
    [self headerBtnClick:self.buyBtn];
}

- (IBAction)headerBtnClick:(UIButton *)sender {
    _selectedBtn.selected  = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    _selectIndexNum = sender == self.buyBtn?0:1;
    
//    [self requestData];
    
    //测试的用的
    [self.tableView reloadData];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
       self.lineView.transform = CGAffineTransformMakeTranslation(sender==self.buyBtn?0:ScreenWidth/2, 0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectIndexNum ==0?2:3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
     if (indexPath.row==0){
        ServiceHeadCell *cell = (ServiceHeadCell *)[self creatCell:tableView indenty:@"ServiceHeadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.row ==1){
        ServiceBodyCell *cell = (ServiceBodyCell *)[self creatCell:tableView indenty:@"ServiceBodyCell"];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        BtnSelectCell *cell = (BtnSelectCell *)[self creatCell:tableView indenty:@"BtnSelectCell"];
        //购买和出售 0、购买 1、出售
        @weakify(self);
        cell.btnClickIndex = ^(NSInteger value) {
            @strongify(self);
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
    if (_selectIndexNum==0) {
        [PushManager pushViewControllerWithName:@"OrderDetailsController" animated:YES block:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        return 94;
    }
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
