//
//  MoreClassificationController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/28.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MoreClassificationController.h"
#import "HomeHttpManager.h"
#import "SecondHanditemCell.h"
#import "CollectionHeadCell.h"


@interface MoreClassificationController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;

@property (nonatomic, strong) NSMutableArray *leftDataArr;
@property (nonatomic, strong) NSArray *rightDataArr;
@property (nonatomic, copy) NSString *name;
@end

@implementation MoreClassificationController

- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 105, ScreenHeight-64) style:UITableViewStylePlain];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.bounces = NO;
        _leftTableView.rowHeight = 45;
        _leftTableView.backgroundColor = RGB(247, 247, 247);

    }
    return _leftTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    self.rightCollectionView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"更多分类" titleColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightCollectionView];
    
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"CollectionHeadCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadCell"];
    [self.rightCollectionView registerNib:[UINib nibWithNibName:@"SecondHanditemCell" bundle:nil] forCellWithReuseIdentifier:@"SecondHanditemCell"];

    self.name = @"手机";
    [self requestItemsId:@""];

}

// 二手物品分类
- (void)requestItemsId:(NSString *)itemId{
    [HomeHttpManager requestItemsId:itemId
                            success:^(id response) {
                                for (NSDictionary *dic in response) {
                                    [self.leftDataArr addObject:dic];
                                }
                                if (self.leftDataArr.count>0) {
                                    self.rightDataArr  =self.leftDataArr[0][@"childList"];
                                }
                                [self.leftTableView reloadData];
                                [self.rightCollectionView reloadData];
                                
                            } failure:^(NSError *error, NSString *message) {
                                
                            }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [self.leftDataArr objectAtIndex:indexPath.row][@"name"];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.leftTableView) {
        
        self.rightDataArr  = self.leftDataArr[indexPath.row][@"childList"];
        self.name = self.leftDataArr[indexPath.row][@"name"];
        [self.rightCollectionView reloadData];
    }
    else{
        
    }
}

#pragma mark -- UICollectionViewDataSource

//返回section 的数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回对应section的item 的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rightDataArr.count;
}

//创建和复用cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //重用cell
    SecondHanditemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecondHanditemCell" forIndexPath:indexPath];
    
    //赋值给cell
    cell.title = [self.rightDataArr objectAtIndex:indexPath.row][@"name"];
    
    return cell;
}

//返回头headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(ScreenWidth, 45);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionHeadCell *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadCell" forIndexPath:indexPath];
        headerView.text = self.name;
        return headerView;
    }
    return nil;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth-127)/3, 44);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1,0 , 0, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", indexPath.row);
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSMutableArray *)leftDataArr{
    if (!_leftDataArr) {
        _leftDataArr = [NSMutableArray array];
    }
    return _leftDataArr;
}


@end
