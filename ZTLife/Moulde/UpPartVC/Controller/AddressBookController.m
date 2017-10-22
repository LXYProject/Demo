//
//  AddressBookController.m
//  ZTLife
//
//  Created by ZT on 2017/10/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddressBookController.h"
#import "ZYPinYinSearch.h"
#import "UpPartHttpManager.h"
#import "AddressBookCell.h"

@interface AddressBookController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSArray *searchDataSource;/**<搜索结果数据源*/
@end

@implementation AddressBookController
{
    NSInteger queryType;
    UISegmentedControl *_segment;
    NSInteger currentIndex;
    MBProgressHUD *_hud;
    NSString *_keywords;
}

// 禁止侧滑手势
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rt_disableInteractivePop = YES;
    //self.navigationItem.hidesBackButton = YES;
    //self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.rt_disableInteractivePop = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    queryType = 0;
    
    self.searchBar.hidden = YES;
    self.tableView.hidden = YES;

    [self createSegment];
    
    //_dataSource = [[NSMutableArray alloc]initWithArray: @[@"九寨沟",@"鼓浪屿",@"香格里拉",@"千岛湖",@"西双版纳",@"嫦娥1号",@"1314Love",@"故宫",@"上海科技馆",@"东方明珠",@"外滩",@"HK香港",@"CapeTown",@"The Grand Canyon",@"4567.com",@"-你me"]];

    _searchDataSource = [NSMutableArray new];

    
    [self requestColleaguesList];

}

- (void)createSegment{
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"会话",@"同事"]];
    _segment.width = 150;
    
    _segment.layer.cornerRadius = 15.0f;
    _segment.layer.borderWidth = 1;
    _segment.layer.borderColor = [UIColor whiteColor].CGColor;
    _segment.layer.masksToBounds = YES;
    _segment.tintColor = [UIColor whiteColor];
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segment;
    self.tableView.tableFooterView = [[UIView alloc]init];
}


-(void)segmentClick:(UISegmentedControl *)segment{
    
    currentIndex = _segment. selectedSegmentIndex;
    
    if (_segment.selectedSegmentIndex==0) {
        self.searchBar.hidden = YES;
        self.tableView.hidden = YES;
    }else{
        self.searchBar.hidden = NO;
        self.tableView.hidden = NO;
    }
    
    [self.tableView reloadData];
    NSLog(@"_segment==%ld", currentIndex);
    
}

// 获取同事列表
- (void)requestColleaguesList{
    @weakify(self);
    [UpPartHttpManager requestMachineId:[getUUID getUUID]
                            machineName:[Tools deviceVersion]
                             clientType:@"0"
                                  orgId:@"2"
                                 deptId:@""
                                success:^(id response) {
                                    @strongify(self);
                                    [self.tableView endRefreshing];
                                    [_hud hide:YES];
                                    [self.dataSource removeAllObjects];
                                    [self.dataSource addObjectsFromArray:response];
                                    [self.tableView reloadData];
                                } failure:^(NSError *error, NSString *message) {
                                
                                }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchDataSource =  [ZYPinYinSearch searchWithOriginalArray:self.dataSource andSearchText:searchText andSearchByPropertyName:@"propertyUserName"];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchBar.text.length==0) {
        return _dataSource.count;
    }else {
        return _searchDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    }
    AddressBookCell *cell = (AddressBookCell *)[self creatCell:tableView indenty:@"AddressBookCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.searchBar.text.length==0) {
        //cell.textLabel.text = _dataSource[indexPath.row];
        cell.model = _dataSource[indexPath.row];
    }else{
        //cell.textLabel.text = _searchDataSource[indexPath.row];
        cell.model = _searchDataSource[indexPath.row];
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


#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (!self.searchController.active) {
//        self.block(_dataSource[indexPath.row]);
//    }else{
//        self.block(_searchDataSource[indexPath.row]);
//    }
//    self.searchController.active = NO;
//    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 67;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual: self.tableView]) {
        if (self.tableView.contentOffset.y > 44) {
            // 上滑
            [self.view endEditing:YES];
        }
        else{
            // 下滑
            [self.view endEditing:YES];
        }
    }
}
#pragma mark - UISearchDelegate


#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
