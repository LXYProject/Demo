//
//  ReleaseClassifiedController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseClassifiedController.h"
#import "ReleaseViewController.h"
#import "LookingForViewController.h"
#import "HomeHttpManager.h"
#import "ItemsModel.h"

@interface ReleaseClassifiedController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *leftDataArr;
@property (nonatomic, strong) NSArray *rightDataArr;

@end

@implementation ReleaseClassifiedController

- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 105, ScreenHeight-64) style:UITableViewStylePlain];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.bounces = NO;
        _leftTableView.rowHeight = 45;
        _leftTableView.backgroundColor = RGB(247, 247, 247);
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(107, 0, ScreenWidth - 107, ScreenHeight-64) style:UITableViewStylePlain];
        _rightTableView.tableFooterView = [[UIView alloc] init];
        _rightTableView.bounces = NO;
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 44;
        self.rightTableView.backgroundColor = RGB(247, 247, 247);
    }
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"选择分类" titleColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self requestItemsId:@""];

}

// 二手物品分类
- (void)requestItemsId:(NSString *)itemId{
    [HomeHttpManager requestItemsId:itemId
                            success:^(id response) {
                                for (NSDictionary *dic in response) {
                                    [self.leftDataArr addObject:dic];
                                }
                                if (self.leftDataArr.count>0) {
                                    self.rightDataArr  =self.leftDataArr[0][@"childList"];
                                }
                                [self.leftTableView reloadData];
                                [self.rightTableView reloadData];
                            
                            } failure:^(NSError *error, NSString *message) {
                            
                            }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftDataArr.count;
    }else{
        return self.rightDataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }

//        cell.backgroundColor = [UIColor lightGrayColor];
//        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [self.leftDataArr objectAtIndex:indexPath.row][@"name"];
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [self.rightDataArr objectAtIndex:indexPath.row][@"name"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.leftTableView) {

        self.rightDataArr  =self.leftDataArr[indexPath.row][@"childList"];
        [self.rightTableView reloadData];
    }
    else{
        if (self.currentController==0) {
            [PushManager popViewControllerWithName:@"ReleaseViewController" animated:YES block:^(ReleaseViewController* viewController) {
                viewController.otherClass = self.rightDataArr[indexPath.row][@"name"];
            }];
        }else{
            [PushManager popViewControllerWithName:@"LookingForViewController" animated:YES block:^(LookingForViewController* viewController) {
                viewController.brandModels = self.rightDataArr[indexPath.row][@"name"];
            }];

        }
    }
}

- (NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
        _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
}

@end
