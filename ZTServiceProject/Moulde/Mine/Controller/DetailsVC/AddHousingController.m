//
//  AddHousingController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddHousingController.h"
#import "MineHttpManager.h"
#import "VillagesModel.h"
#import "BuildingListController.h"

@interface AddHousingController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//搜索到的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation AddHousingController
{
    UIView *_headView;
    UITextField *_searchBar;
    UIButton *_searchBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"添加房屋" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    [self createUIsearchBar];
    
    self.tableView.hidden = YES;
}
- (void)createUIsearchBar{
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 49)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    _searchBar = [[UITextField alloc] initWithFrame:CGRectMake(15, 9, SCREEN_WIDTH-30-75, 32)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"  输入小区名进行搜索";
    [_searchBar setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.cornerRadius = _searchBar.bounds.size.width * 0.01;
    _searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchBar.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [_headView addSubview:_searchBar];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = _searchBtn.bounds.size.width * 0.01;
    _searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _searchBtn.backgroundColor = UIColorFromRGB(0xe64e51);
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _searchBtn.frame = CGRectMake(SCREEN_WIDTH-15-75, 9, 75, 32);
    [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_searchBtn];
    
    [_searchBar addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    
    if (_searchBar.text.length>0){
        self.tableView.hidden = NO;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    else{
        self.tableView.hidden = YES;
        self.tableView.separatorColor = [UIColor darkGrayColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)searchBtnClick{
    
    [self searchCommunity];
    
    if (self.dataSource.count>0) {
        self.tableView.hidden = NO;
    }
}
// 关键字搜索小区
- (void)searchCommunity{
    @weakify(self);
    [MineHttpManager requestKeywords:_searchBar.text
                                city:@"510100"
                             success:^(NSArray* response) {
                                 @strongify(self);
                                 [self.dataSource removeAllObjects];
                                 
                                 [self.dataSource addObjectsFromArray:response];
                                 [self.tableView reloadData];
                             } failure:^(NSError *error, NSString *message) {
                                 
                             }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
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
    cell.textLabel.text = [self.dataSource[indexPath.row] zoneName];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        @weakify(self);
        [PushManager pushViewControllerWithName:@"BuildingListController" animated:YES block:^(BuildingListController* viewController) {
            @strongify(self);
            viewController.zoneId = [self.dataSource[indexPath.row] zoneId];
        }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
