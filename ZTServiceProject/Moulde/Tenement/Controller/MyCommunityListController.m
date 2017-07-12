//
//  MyCommunityListController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/21.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyCommunityListController.h"

@interface MyCommunityListController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyCommunityListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"我的小区"
                  titleColor:[UIColor whiteColor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"我的小区";
    
  
//    if ([self.delegate respondsToSelector:@selector(passTrendValues:)]) {
//        [self.delegate passTrendValues:cell.textLabel.text];
//
//    }
    // 代理执行方法必须写在pop之前
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(passTrendValues:)]) {
        [self.delegate passTrendValues:@"我的小区"];
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
