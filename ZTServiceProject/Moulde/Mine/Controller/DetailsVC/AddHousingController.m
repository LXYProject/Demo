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

@interface AddHousingController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//搜索到的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation AddHousingController
{
    UIView *_headView;
    VillagesModel *_model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.tableView.backgroundColor = RGB(247, 247, 247);
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"添加房屋" titleColor:[UIColor whiteColor]];
    [self createUIsearchBar];
    
    [self searchCommunity];
}
- (void)createUIsearchBar{
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 49)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    
    UITextField *searchBar = [[UITextField alloc] initWithFrame:CGRectMake(15, 9, SCREEN_WIDTH-30-75, 32)];
    searchBar.delegate = self;
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = searchBar.bounds.size.width * 0.01;
    searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBar.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [_headView addSubview:searchBar];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = searchBtn.bounds.size.width * 0.01;
    searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    searchBtn.backgroundColor = UIColorFromRGB(0xe64e51);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(SCREEN_WIDTH-15-75, 9, 75, 32);
    [_headView addSubview:searchBtn];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChnage:) name:UITextFieldTextDidChangeNotification object:searchBar];
    
}


// 关键字搜索小区
- (void)searchCommunity{
    [MineHttpManager requestKeywords:@"西华"
                                city:@"510100"
                             success:^(NSArray* response) {
                                 
                                 [self.dataSource addObjectsFromArray:response];
                                 [self.tableView reloadData];
                             } failure:^(NSError *error, NSString *message) {
                                 
                             }];
}

// 小区id搜索楼
- (void)searchStoriedBuilding{
    [MineHttpManager requestZoneId:@""
                           success:^(id response) {
                           
                           } failure:^(NSError *error, NSString *message) {
                           
                           }];
}

// 根据楼查询房屋表
- (void)searchHouse{
    [MineHttpManager requestZoneId:@""
                        buildingId:@""
                           success:^(id response) {
                           
                           } failure:^(NSError *error, NSString *message) {
                           
                           }];
}

//监听输入框文字变化
- (void)textChnage:(NSNotification *)noti {
    UITextField *textField = [noti object];
    textField.text =[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
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
    cell.textLabel.text = _model.zoneAddress;
    return cell;

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
