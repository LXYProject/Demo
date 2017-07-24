//
//  MyHouseViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyHouseViewController.h"
#import "HouseBodyCell.h"
#import "MineHttpManager.h"
#import "MyHouseModel.h"

@interface MyHouseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//查看所有与我有关的房屋 的数据相关的
@property (nonatomic,strong)NSMutableArray *bindHousesDataSource;//绑定的房屋
@property (nonatomic,strong)NSMutableArray *attentionHousesDataSource;//关注的房屋
@property (nonatomic,assign)NSInteger currentPage;
@end

@implementation MyHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"我的房屋" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"添加房屋"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.currentPage = 1;
    [self.tableView setHeaderRefreshBlock:^{
//        self.currentPage = 1;
        [self requestLookAllHouseWithMe];
    }];
//    [self.tableView setFooterRefreshBlock:^{
//        self.currentPage++;
//        [self requestLookAllHouseWithMe];
//    }];
    [self.tableView beginHeaderRefreshing];
}

- (void)rightBarClick{
    NSLog(@"添加房屋");
    [PushManager pushViewControllerWithName:@"AddHousingController" animated:YES block:nil];
}

// 查看所有与我有关的房屋
- (void)requestLookAllHouseWithMe{
    @weakify(self);
    [MineHttpManager requesHouseAddVillage:House
                                   success:^(NSDictionary* response) {
                                       @strongify(self);
                                       [self.tableView endRefreshing];

                                       
                                       NSMutableArray *bindHouseArray = [MyHouseModel mj_objectArrayWithKeyValuesArray:response[@"bindHouses"]];
                                       NSMutableArray *attentionHousesArray = [MyHouseModel mj_objectArrayWithKeyValuesArray:response[@"attentionHouses"]];
                                       
//                                       if (self.currentPage==1){
                                           [self.bindHousesDataSource removeAllObjects];
                                           [self.attentionHousesDataSource removeAllObjects];
//                                       }
                                       [self.bindHousesDataSource addObjectsFromArray:bindHouseArray];
                                       [self.attentionHousesDataSource addObjectsFromArray:attentionHousesArray];
//                                       if (response.count<10) {
//                                           [self.tableView endRefreshingWithNoMoreData];
//                                       }
                                       [self.tableView reloadData];

                                   } failure:^(NSError *error, NSString *message) {
                                       [self.tableView endRefreshing];
                                   }];
}
// 新增绑定房屋
- (void)requestAddBindHouse{
    [MineHttpManager requestAddToCancelHouse:addBindHouse
                                     houseId:@""
                                     success:^(id response) {
                                         
                                     } failure:^(NSError *error, NSString *message) {
                                         
                                     }];
}

// 取消绑定，取消关注
- (void)requestunHouse:(NSString *)houseId{
    @weakify(self);
    [MineHttpManager requestAddToCancelHouse:unHouse
                                     houseId:houseId
                                     success:^(id response) {
                                         @strongify(self);
                                         //操作失败的原因
                                         NSString *information = [response objectForKey:@"information"];
                                         //状态码
                                         NSString *status = [response objectForKey:@"status"];
                                         
                                         if ([status integerValue]==0) {
                                             
                                             [self requestLookAllHouseWithMe];
                                             [AlertViewController alertControllerWithTitle:@"提示" message:@"取消绑定成功" preferredStyle:UIAlertControllerStyleAlert controller:self];
                                         }else{
                                             [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                         }
 
                                     } failure:^(NSError *error, NSString *message) {
                                     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.bindHousesDataSource.count;
    }else{
        return self.attentionHousesDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}


//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    HouseBodyCell *cell = (HouseBodyCell *)[self creatCell:tableView indenty:@"HouseBodyCell"];
    if (indexPath.section==0) {
        cell.model = self.bindHousesDataSource[indexPath.row];
        cell.btnClickBlock = ^(UIButton *sender) {
            // 取消绑定，取消关注
            [self requestunHouse:[self.bindHousesDataSource[indexPath.row] buildingId]];
        };
    }else{
        cell.model = self.attentionHousesDataSource[indexPath.row];
        @weakify(self);
        cell.btnClickBlock = ^(UIButton *sender) {
            @strongify(self);
            // 取消绑定，取消关注
            [self requestunHouse:[self.attentionHousesDataSource[indexPath.row] buildingId]];
        };
    }
    return cell;
    
}

- (void)createAlertView{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消成功" preferredStyle:(UIAlertControllerStyleAlert)];
    // 创建按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    if (section ==0){
        lable.attributedText = [self attrText:@"已绑定房屋"];
    }
    else if (section ==1){
        lable.attributedText = [self attrText:@"已关注房屋"];
    }
    else{
        lable.attributedText = nil;
    }
    [view addSubview:lable];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [Tools cellRadio:tableView cell:cell indexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 94;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSAttributedString *)attrText:(NSString *)text {
    if (text.length<4) {
        NSLog(@"文字的个数不足，需要添加更多的文字");
        return nil;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(0, 1)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(1, 2)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(3, text.length-3)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    [attr appendAttributedString:attr1];
    [attr appendAttributedString:attr2];
    [attr appendAttributedString:attr3];
    return attr;
}
- (NSArray *)bindHousesDataSource {
    if (!_bindHousesDataSource) {
        _bindHousesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _bindHousesDataSource;
}
- (NSArray *)attentionHousesDataSource {
    if (!_attentionHousesDataSource) {
        _attentionHousesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _attentionHousesDataSource;
}

@end
