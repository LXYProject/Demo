//
//  ApplyLeaveController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/10/12.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ApplyLeaveController.h"
#import "ApplyLeaveCell.h"
#import "ApplyLeaveTextCell.h"
#import "ZJBLStoreShopTypeAlert.h"
#import "UICustomDatePicker.h"
#import "PlaceTextView.h"
#define btnY 350
@interface ApplyLeaveController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *sectionTitle;
@property (strong, nonatomic) NSArray *leaveTypeArr;
@end

@implementation ApplyLeaveController
{
    NSString *_discribeText;    //请假原因
    NSString *_leaveTypeText;   //请假类型
    NSString *_startingTimeText;//起始时间
    NSString *_endTimeText;         //终止时间
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"请假申请" titleColor:[UIColor whiteColor]];
    self.sectionTitle = @[@"启始时间", @"终止时间", @"请假时长"];
    self.leaveTypeArr = @[@"病假", @"其它", @"事假"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ApplyLeaveTextCell" bundle:nil] forCellReuseIdentifier:@"ApplyLeaveTextCell"];
    self.tableView.tableFooterView = [self createBtn];
    self.tableView.estimatedRowHeight = 100;
}

- (UIView *)createBtn
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 89)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, 20, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    [submitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:submitBtn];
    return view;
}

- (void)submitClick{
    NSLog(@"提交申请");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }else{
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    ApplyLeaveCell *cell = (ApplyLeaveCell *)[self creatCell:tableView indenty:@"ApplyLeaveCell"];
    cell.titleLabel.text = @"请假类型";
    if (_leaveTypeText.length>0) {
        cell.detailsLabel.text = _leaveTypeText;
    }else{
        cell.detailsLabel.text = @"病假";
    }
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        ApplyLeaveCell *cell = (ApplyLeaveCell *)[self creatCell:tableView indenty:@"ApplyLeaveCell"];
        cell.titleLabel.text = @"请假事由";
        cell.detailsLabel.text = @"";
        return cell;

    }else{
        //ApplyLeaveTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyLeaveTextCell" forIndexPath:indexPath];
        ApplyLeaveTextCell *cell = (ApplyLeaveTextCell *)[self creatCell:tableView indenty:@"ApplyLeaveTextCell"];
        cell.fd_isTemplateLayoutCell = YES;
        cell.textViewBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _discribeText = obj;
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    ApplyLeaveCell *cell = (ApplyLeaveCell *)[self creatCell:tableView indenty:@"ApplyLeaveCell"];
    cell.titleLabel.text = self.sectionTitle[indexPath.row];
    if (indexPath.row==0) {
        if (_startingTimeText.length>0) {
            cell.detailsLabel.text = _startingTimeText;
        }else{
            cell.detailsLabel.text = @"请选择";
        }
    }else if (indexPath.row==1){
        if (_endTimeText.length>0) {
            cell.detailsLabel.text = _endTimeText;
        }else{
            cell.detailsLabel.text = @"请选择";
        }
    }else{
        cell.detailsLabel.text = @"1天";
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
    if (indexPath.section==0) {
        [ZJBLStoreShopTypeAlert showWithTitle:@"选择请假类型" titles:self.leaveTypeArr selectIndex:^(NSInteger selectIndex) {
            NSLog(@"选择了第%ld个",selectIndex);
        } selectValue:^(NSString *selectValue) {
            NSLog(@"选择的值为%@",selectValue);
            _leaveTypeText = selectValue;
            [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

        } showCloseButton:NO];
    }else if (indexPath.section==1){
        
    }else{
        if (indexPath.row==0) {
            // 弹出时间选择器
            [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
                NSLog(@"current Date:%@",date);
                //用于格式化NSDate对象
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //设置格式：zzz表示时区
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                //NSDate转NSString
                _startingTimeText = [dateFormatter stringFromDate:date];
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
            } cancelBlock:^{
                
            }];

        }else if (indexPath.row==1){
            // 弹出时间选择器
            [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSDate *date) {
                NSLog(@"current Date:%@",date);
                //用于格式化NSDate对象
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //设置格式：zzz表示时区
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                //NSDate转NSString
                _endTimeText = [dateFormatter stringFromDate:date];
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
            } cancelBlock:^{
                
            }];

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


@end
