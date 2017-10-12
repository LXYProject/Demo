//
//  AddressBookController.m
//  ZTLife
//
//  Created by ZT on 2017/10/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddressBookController.h"
#import "ZYPinYinSearch.h"

@interface AddressBookController ()<UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@end

@implementation AddressBookController
{
    NSInteger queryType;
    UISegmentedControl *_segment;
    NSInteger currentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rightBarButtomItemWithNormalName:@"add_btn"
                                  highName:@"add_btn"
                                  selector:@selector(rightBarClick)
                                    target:self];
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"会话",@"好友"]];
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
    queryType = 0;
    
    _searchDataSource = [NSMutableArray new];
    [self.tableView setTableHeaderView:self.searchController.searchBar];


}

- (void)rightBarClick{
    
}

-(void)segmentClick:(UISegmentedControl *)segment{
    
    currentIndex = _segment. selectedSegmentIndex;
    [self.tableView reloadData];
    NSLog(@"_segment==%ld", currentIndex);
    
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _dataSource.count;
    }else {
        return _searchDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (!self.searchController.active) {
        cell.textLabel.text = _dataSource[indexPath.row];
    }else{
        cell.textLabel.text = _searchDataSource[indexPath.row];
    }
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchController.active) {
        self.block(_dataSource[indexPath.row]);
    }else{
        self.block(_searchDataSource[indexPath.row]);
    }
    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [NSArray new];
    ary = [ZYPinYinSearch searchWithOriginalArray:_dataSource andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:_dataSource];
    }else {
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
//    
//}
//
////第0组
//- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
//                                    indexPath:(NSIndexPath *)indexPath {
////    if (_segment.selectedSegmentIndex==0) {
////        ChatCell *cell = (ChatCell *)[self creatCell:tableView indenty:@"ChatCell"];
////        return cell;
////    }else{
////        FriendsCell *cell = (FriendsCell *)[self creatCell:tableView indenty:@"FriendsCell"];
////        return cell;
////    }
//}
////公共创建cell的方法
//- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
//    }
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (_segment.selectedSegmentIndex==0) {
//        
//        
//    }else{
//        [PushManager pushViewControllerWithName:@"PersonalDataController" animated:YES block:nil];
//    }
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 67;
//}


@end
