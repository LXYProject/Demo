//
//  PayAccountInfoController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PayAccountInfoController.h"

#define LabelY 180
@interface PayAccountInfoController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PayAccountInfoController
{
    NSArray *_titleOneArr;
    NSArray *_titleTwoArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"缴费账户信息" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"帮助"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self createLabel];
    
    _titleOneArr = @[@"水费", @"缴费房屋"];
    _titleTwoArr = @[@"缴费单位", @"客户编号"];
}

- (void)rightBarClick{
    
}

- (void)createLabel{
    
    
    UILabel *detaiLabel = [[UILabel alloc] init];
    detaiLabel.frame = CGRectMake(15, LabelY, 250, 40);
    detaiLabel.text = @"发票请到国网电力营业厅索取";
    detaiLabel.font = [UIFont systemFontOfSize:12];
    detaiLabel.textColor = UIColorFromRGB(0xb2b2b2);
    [self.tableView addSubview:detaiLabel];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, LabelY+30, 250, 40);
    label.text = @"同意《正图生活平台服务者入住协议》";
    label.textColor = UIColorFromRGB(0xe64e51);
    label.font = [UIFont systemFontOfSize:12];
    [self.tableView addSubview:label];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(20, LabelY+80, SCREEN_WIDTH-40, 49);
    submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255 green:72.0/255 blue:77.0/255 alpha:1];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.bounds.size.width * 0.01;
    submitBtn.layer.borderColor = [UIColor clearColor].CGColor;
    [submitBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:submitBtn];

}

- (void)submitClick{
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    if (indexPath.section==0) {
        cell.textLabel.text = _titleOneArr[indexPath.row];
        if (indexPath.row==0) {
            cell.imageView.image = [UIImage imageNamed:@"message_tabbar_selected"];
        }else{
            cell.detailTextLabel.text = @"中关村东路";
        }
    }else{
        cell.textLabel.text = _titleTwoArr[indexPath.row];
        if (indexPath.row==0) {
            cell.detailTextLabel.text = @"请选择缴费单位";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 3, 200, 44)];
            textField.placeholder = @"请输入客户编号";
            [textField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
            [cell.contentView addSubview:textField];
        }
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.textColor  = TEXT_COLOR;
    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

@end
