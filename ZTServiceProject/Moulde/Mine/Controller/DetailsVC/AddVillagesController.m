//
//  AddVillagesController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/14.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddVillagesController.h"
#import "MineHttpManager.h"
#import "VillagesModel.h"

@interface AddVillagesController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

//搜索到的数据
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation AddVillagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"添加小区" titleColor:[UIColor whiteColor]];
    self.tableView.tableFooterView = [[UIView alloc]init];

    self.searchBar.layer.cornerRadius = _searchBar.bounds.size.width * 0.01;
    self.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBar.backgroundColor = UIColorFromRGB(0xE8E8E8);
    self.searchBar.placeholder = @"  输入小区名进行搜索";
    [self.searchBar setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = _searchBtn.bounds.size.width * 0.01;
    self.searchBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBtn.backgroundColor = UIColorFromRGB(0xe64e51);
    [self.searchBar addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];


    self.tableView.hidden = YES;

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
- (IBAction)searchBtnClick {
    
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
    cell.textLabel.text = [self.dataSource[indexPath.row] zoneAddress];;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //选择行，添加小区关注
    @weakify(self);
    [MineHttpManager requestAddToCancelVillage:AddVillage
                                   communityId:[self.dataSource[indexPath.row] zoneId]
                                       success:^(id response) {
                                           //操作失败的原因
                                           @strongify(self);
                                           NSString *information = [response objectForKey:@"information"];
                                           //状态码
                                           NSString *status = [response objectForKey:@"status"];
                                           
                                           if ([status integerValue]==0) {
                                               
                                               [self createAlertView];
                                               
                                           }else{
                                               [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                           }

                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           
                                       }];
}

- (void)createAlertView{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:(UIAlertControllerStyleAlert)];
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        //[self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
