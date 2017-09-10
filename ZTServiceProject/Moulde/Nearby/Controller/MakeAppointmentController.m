//
//  MakeAppointmentController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/17.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MakeAppointmentController.h"
#import "MakeAppointmentCell.h"
#import "MakeAppointDescripCell.h"
#import "ServiceModel.h"

@interface MakeAppointmentController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *phoneNumberStr;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//当前数量
@property (nonatomic,assign)NSInteger currentNumber;
@end

@implementation MakeAppointmentController
{
    CGFloat floatString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"立即预约" titleColor:[UIColor whiteColor]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.priceLabel.text = [self.model price];
    NSLog(@"price==%@", [self.model price]);
    
    floatString = [[self.model price] floatValue];
}
- (IBAction)confirmAppointBtnClick {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else{
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==1) {
        MakeAppointmentCell *cell = (MakeAppointmentCell *)[self creatCell:tableView indenty:@"MakeAppointmentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        cell.selectFinishedBlock = ^(NSInteger value) {
            @strongify(self);
            self.currentNumber = value;
            //self.priceLabel.text = [NSString stringWithFormat:@"合计：%.2f",10.0*self.currentNumber];
            self.priceLabel.text = [NSString stringWithFormat:@"合计：%.2f",floatString*self.currentNumber];
            
            
        };
        cell.currentNum = self.currentNumber;
        cell.model = self.model;
        return cell;
    }else{
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if (indexPath.row==0) {
            //cell.textLabel.text = self.titleStr;
            cell.textLabel.text = [self.model title];
        }else{
            cell.textLabel.text = @"联系方式:";
            cell.detailTextLabel.text = self.phoneNumberStr;
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
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.text = @"服务时间";
        cell.detailTextLabel.text = @"期望何时开始服务";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        return cell;
        
    }else{
        MakeAppointDescripCell *cell = (MakeAppointDescripCell *)[self creatCell:tableView indenty:@"MakeAppointDescripCell"];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 50;
    }else{
        if (indexPath.row==0) {
            return 50;
        }else{
            return 100;
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
