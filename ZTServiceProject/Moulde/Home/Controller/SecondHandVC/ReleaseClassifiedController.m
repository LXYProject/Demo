//
//  ReleaseClassifiedController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ReleaseClassifiedController.h"
#import "HomeHttpManager.h" 
#import "ItemsModel.h"

@interface ReleaseClassifiedController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *leftDataArr;
@property (nonatomic, strong) NSMutableArray *rightDataArr;

@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic, strong) NSMutableArray *ItemID;

@property (nonatomic, copy) NSString* cellOneID;
@property (nonatomic, copy) NSString* cellTWoID;


@end

@implementation ReleaseClassifiedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"选择分类" titleColor:[UIColor whiteColor]];
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 105, ScreenHeight) style:UITableViewStylePlain];
    self.leftTableView.tableFooterView = [[UIView alloc] init];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.bounces = NO;
    self.leftTableView.rowHeight = 45;
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(107, 0, ScreenWidth - 107, ScreenHeight) style:UITableViewStylePlain];
    self.rightTableView.tableFooterView = [[UIView alloc] init];
    self.rightTableView.bounces = NO;
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.rowHeight = 44;
    [self.view addSubview:self.rightTableView];
    self.leftTableView.backgroundColor = RGB(247, 247, 247);
    self.rightTableView.backgroundColor = RGB(247, 247, 247);

//    [self loadData];
    
    [self requestItemsId];
    
    

}

// 二手物品分类
- (void)requestItemsId{
    [HomeHttpManager requestItemsId:@""
                            success:^(id response) {
                                
                                for (NSDictionary *dic in response) {
                                    
                                    NSString *name = [dic objectForKey:@"name"];
                                    NSString *strID = [dic objectForKey:@"id"];
                                    NSLog(@"name==%@", name);

                                    [self.leftDataArr addObject:name];
                                    [self.ItemID addObject:strID];
                                    [self.leftTableView reloadData];
                                    
                                    NSArray *childList = [dic objectForKey:@"childList"];
                                    NSLog(@"childList==%@", childList);
                                    
                                    for (NSDictionary *dicTwo in childList) {
                                        NSString *strName = [dicTwo objectForKey:@"name"];
                                        
                                        [self.rightDataArr addObject:strName];
                                        [self.rightTableView reloadData];
                                    }

                                }
                            
                            } failure:^(NSError *error, NSString *message) {
                            
                            }];
}
- (void)loadData{
    self.leftDataArr = [NSMutableArray arrayWithArray:@[@"北京", @"上海",@"广州", @"深圳", @"虎口",@"这里",@"去吗",@"你才",@"发热",@"控件",@"认我",@"北京", @"上海",@"广州", @"深圳", @"虎口",@"这里",@"去吗",@"你才",@"发热",@"控件",@"认我"]];
    self.rightDataArr = [NSMutableArray arrayWithArray:@[@"其沃尔沃特",@"自行车 v 下",@"但是发生过",@"三个地方不能辜负",@"哦 i u 一天",@"形成 v 传播吗",@"热我国东北",@"形成 v",@"请问热风 v 发布的身体",@"只需擦到发不出",@"去玩儿天涯海角那边 v 次"]];
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];

    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }else{
//        return self.rightDataArr.count;
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftDataArr.count;
    }else{
        return self.rightDataArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }

//        cell.backgroundColor = [UIColor lightGrayColor];
//        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [self.leftDataArr objectAtIndex:indexPath.row];
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [self.rightDataArr objectAtIndex:indexPath.row];
        return cell;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) {
//        return 0;
//    }else{
//        return 40;
//    }
//}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) {
//        return nil;
//    }else{
//        return [self.rightDataArr objectAtIndex:section];
//    }
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.leftTableView) {

        self.cellOneID = self.ItemID[indexPath.row];
        NSLog(@"cellOneID==%@", self.cellOneID);

        
        
        //        self.indexPath = indexPath;
//        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.rightTableView)
//    {
//        //取出当前显示的最顶部的cell的indexpath
//        //当前tableview页面可见的分区属性 indexPathsForVisibleRows
//        NSIndexPath *topIndexPath = [[self.rightTableView indexPathsForVisibleRows]firstObject];
//        if (self.indexPath.row == topIndexPath.section) {
//            
//        }
//        NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:topIndexPath.section inSection:0];
//        //选中左边的cell
//        //            [self.leftTableView scrollToRowAtIndexPath:moveIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//        [self.leftTableView selectRowAtIndexPath:moveIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        
//    }else{
//        return;
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    if (self.rightTableView) {
//
//        //该方法是当scrollView滑动时触发，因为UITableView继承自UIScrollView因此在这里也可以调用
//        CGFloat header = 0;//这个header其实是section1 的header到顶部的距离
//        if (scrollView.contentOffset.y<=header&&scrollView.contentOffset.y>=0) {
//            //当视图滑动的距离小于header时
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        }else if(scrollView.contentOffset.y>header)
//        {
//            //当视图滑动的距离大于header时，这里就可以设置section1的header的位置啦，设置的时候要考虑到导航栏的透明对滚动视图的影响
//
////            [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
////            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
////            scrollView.contentInset = UIEdgeInsetsMake(header, 0, 0, 0);
////            row += 1;
//
//        }
//    }
//}


- (NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
        _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
}
- (NSMutableArray *)rightDataArr{
    if (!_rightDataArr) {
        _rightDataArr = [NSMutableArray array];
    }
    return _rightDataArr;
}

- (NSMutableArray *)ItemID{
    if (!_ItemID) {
        _ItemID = [NSMutableArray array];
    }
    return _ItemID;
}


@end
