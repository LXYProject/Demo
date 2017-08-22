//
//  ServiceUnitController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ServiceUnitController.h"
#import "NearByHttpManager.h"
#import "NearByTitleModel.h"
#import "PublishServiceController.h"

@interface ServiceUnitController ()

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@property (nonatomic,strong)NSMutableArray *tagTitles;

@end

@implementation ServiceUnitController
{
    NSInteger queryType;
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"服务单位" titleColor:[UIColor whiteColor]];
    self.tableView.backgroundColor = RGB(247, 247, 247);
    self.tableView.tableFooterView = [[UIView alloc] init];
    queryType = 2;

    [self.tableView setHeaderRefreshBlock:^{
        [self requestQuerySystemDict];
    }];
    [self.tableView beginHeaderRefreshing];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.label.text = @"正在加载";

}

// 请求单位
- (void)requestTitleArrayData {
    @weakify(self);
    [NearByHttpManager rqeuestQueryType:queryType
                                success:^(NSArray * response) {
                                    @strongify(self);
                                    [self.tableView endRefreshing];
                                    [_hud hideAnimated:YES];
                                    
                                    [self.tagTitles removeAllObjects];
                                    [self.tagTitles addObjectsFromArray:response];
                                    [self.tableView reloadData];
                                } failure:^(NSError *error, NSString *message) {
                                    [self.tableView endRefreshing];
                                    _hud.label.text = message;
                                    [_hud hideAnimated:YES];
                                }];
}

- (void)requestQuerySystemDict{
    @weakify(self);
    [NearByHttpManager requestDictType:@"serviceUnit"
                          parentDictId:@""
                             machineId:@"0"
                           machineName:@"0"
                            clientType:@"0"
                               success:^(id response) {
                                   
                                   @strongify(self);
                                   [self.tableView endRefreshing];
                                   [_hud hideAnimated:YES];
                                   
                                   [self.tagTitles removeAllObjects];
                                   [self.tagTitles addObjectsFromArray:response];
                                   [self.tableView reloadData];
                                   
                               } failure:^(NSError *error, NSString *message) {
                                   [self.tableView endRefreshing];
                                   _hud.label.text = message;
                                   [_hud hideAnimated:YES];
                               }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagTitles.count;
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
    cell.textLabel.text = [self.tagTitles[indexPath.row] name];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [PushManager popViewControllerWithName:@"PublishServiceController" animated:YES block:^(PublishServiceController* viewController) {
        viewController.unitStr = [self.tagTitles[indexPath.row] name];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSMutableArray *)tagTitles {
    if (!_tagTitles) {
        _tagTitles = [NSMutableArray arrayWithCapacity:1];
    }
    return _tagTitles;
}


@end
