//
//  MyNeighborController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MyNeighborController.h"
#import "CommunityBodyCell.h"
#import "MineHttpManager.h"
#import "MyNeighborModel.h"

@interface MyNeighborController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//查看所有与我有关的小区 的数据相关的
@property (nonatomic,strong)NSMutableArray *myZonesDataSource;//绑定的小区
@property (nonatomic,strong)NSMutableArray *attentionZonesDataSource;//关注的小区
@property (nonatomic,assign)NSInteger currentPage;


@end

@implementation MyNeighborController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"我的小区" titleColor:[UIColor whiteColor]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.currentPage = 1;
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
            [self requestLookAllVillageWithMe];
    }];
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
            [self requestLookAllVillageWithMe];
    }];
    [self.tableView beginHeaderRefreshing];

}

// 查看所有与我有关的小区
- (void)requestLookAllVillageWithMe{
    
    [MineHttpManager requesHouseAddVillage:Village
                                   success:^(NSDictionary *response) {
                                       
                                       NSArray *myZonesArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response[@"myZones"]];
                                       NSArray *attentionZonesArray = [MyNeighborModel mj_objectArrayWithKeyValuesArray:response[@"attentionZones"]];

                                       [self.tableView endRefreshing];
                                       if (self.currentPage==1){
                                           [self.myZonesDataSource removeAllObjects];
                                           [self.attentionZonesDataSource removeAllObjects];
                                       }
                                       [self.myZonesDataSource addObjectsFromArray:myZonesArray];
                                       [self.attentionZonesDataSource addObjectsFromArray:attentionZonesArray];
                                       if (response.count<10) {
                                           [self.tableView endRefreshingWithNoMoreData];
                                       }
                                       [self.tableView reloadData];
                                       
                                   } failure:^(NSError *error, NSString *message) {
                                       [self.tableView endRefreshing];
                                   }];
}
// 添加小区关注
- (void)requestAddVillage{
    
    [MineHttpManager requestAddToCancelVillage:AddVillage
                                   communityId:@""
                                       success:^(id response) {
                                           
                                       } failure:^(NSError *error, NSString *message) {
                                           
                                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.myZonesDataSource.count;
    }else{
        return self.attentionZonesDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {

    CommunityBodyCell *cell = (CommunityBodyCell *)[self creatCell:tableView indenty:@"CommunityBodyCell"];
    if (indexPath.section==0) {
        cell.model = self.myZonesDataSource[indexPath.row];
        cell.type = completion_Type;
        [cell.completionBtn setTitle:@"补全物业信息" forState:UIControlStateNormal];
    }else{
        cell.model = self.attentionZonesDataSource[indexPath.row];
        cell.type = CancelAttention_Type;
        [cell.completionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    if (section ==0){
        lable.attributedText = [self attrText:@"已绑定小区"];
    }
    else if (section ==1){
        lable.attributedText = [self attrText:@"已关注小区"];
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

- (NSArray *)myZonesDataSource {
    if (!_myZonesDataSource) {
        _myZonesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _myZonesDataSource;
}
- (NSArray *)attentionZonesDataSource {
    if (!_attentionZonesDataSource) {
        _attentionZonesDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _attentionZonesDataSource;
}
@end
