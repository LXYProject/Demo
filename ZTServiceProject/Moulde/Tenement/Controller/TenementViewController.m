//
//  TenementViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/6.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "TenementViewController.h"
#import "MacroDefinition.h"
#import "ItemBtnCell.h"
#import "ItemBtnCell.h"
#import "HomeHttpManager.h"
#import "TenemnetHeaderCell.h"
#import "BannerHeaderCell.h"
@interface TenementViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSourceArray;
@property (nonatomic,strong)NSArray *imageURLArray;
@property (nonatomic,strong)NSArray *titleHeader;
@property (nonatomic, strong)NSMutableArray *imageUrlArr;
@property (nonatomic, strong)NSMutableArray *imageNames;

@end

@implementation TenementViewController
{
//    NSArray *imageNames;
    NSInteger _times;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    imageNames = @[
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   @"timg.jpeg",
//                   ];
    _imageUrlArr = [[NSMutableArray alloc] init];
    [self requestB];
//    [self requestBanner];
}

//请求广告图
- (void)requestBanner {
    @weakify(self);
    [HomeHttpManager requestzoneId:@"510029841228" success:^(NSArray * response) {
        @strongify(self);
        self.imageURLArray = response;
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } failure:^(NSError *error, NSString *message) {
        
    }];
}
- (void)requestB
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{
                                 @"userId":@"1",
                                 @"token":@"1",
                                 @"city":@"510100",
                                 @"zoneId":@"510029841228"
                                 };
    NSString *path = MRRemote(A_UrlB);
    [sessionManager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"post success:%@",responseObject);
        
        NSDictionary *dictResult = responseObject[@"result"];
        NSLog(@"dictResult==%@", dictResult);
        NSArray *adList = [dictResult objectForKey:@"adList"];
        NSLog(@"adList==%@", adList);
        for (NSDictionary *dic in adList) {
            NSLog(@"dic==%@", dic);
            NSString *imageUrl = [dic objectForKey:@"imageUrl"];

            [_imageUrlArr addObject:imageUrl];
            NSLog(@"_imageUrlArr==%@", _imageUrlArr);
        }
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post failure:%@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BannerHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerHeaderCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"BannerHeaderCell" owner:nil options:nil] lastObject];
        }
//        cell.modelArray = imageNames;
//        cell.modelArray = self.imageURLArray;

//        UIImageView *imageView;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlArr[indexPath.row]]
//                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//
        cell.modelArray = _imageUrlArr;
        return cell;
    }
    
    else {
        if (indexPath.row ==0 ){
            TenemnetHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TenemnetHeaderCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"TenemnetHeaderCell" owner:nil options:nil] lastObject];
            }
            cell.titleHeader.text = self.titleHeader[indexPath.section-1];
            return cell;
        }
        else {
        
        ItemBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemBtnCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ItemBtnCell" owner:nil options:nil] lastObject];
        }
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            [PushManager pushViewControllerWithName:self.dataSourceArray[indexPath.section][value][@"vcName"] animated:YES block:nil];
        };
        cell.titleAndImageDictArray = self.dataSourceArray[indexPath.section];
        return cell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    }
    else {
        if (indexPath.row ==0) {
            return 49;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)titleHeader
{
    if (!_titleHeader) {
        _titleHeader = @[
                         @"小区信息",
                         @"物业服务",
                         @"小区安保",
                         @"缴费"
                         ];
    }
    return _titleHeader;
}

- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[
                             @[@{@"imgUrl":@""},
                               @{@"imgUrl":@""}],
                             @[
                                 @{@"title":@"小区公告",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"小区全景",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"NearByViewController"},
                                 
                                 @{@"title":@"便民信息",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"小区主页",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 ],
                             @[
                                 @{@"title":@"上门服务",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"公共报事",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"表扬",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"投诉",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 ],
                             @[
                                 @{@"title":@"呼叫保安",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"保安团队",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 
                                 @{@"title":@"设施设备",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"}
                                 ],
                             @[
                                 @{@"title":@"物业费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"},
                                 @{@"title":@"生活缴费",
                                   @"icon":@"my_tabbar_selected",
                                   @"vcName":@"HomeViewController"}
                                 ],
                             ];
    }
    return _dataSourceArray;
}

@end
