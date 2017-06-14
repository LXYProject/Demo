//
//  secondHandCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "secondHandCell.h"
#import "ProductCollecttionCell.h"
#import "HomeHttpManager.h"

@interface secondHandCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation secondHandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.currentPage =1;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ProductCollecttionCell" bundle:nil] forCellWithReuseIdentifier:@"ProductCollecttionCell"];
    
    [self requestData];
}

- (void)requestData
{
    
    [HomeHttpManager requestQueryType:2 secondInfoId:@"" keywords:@"" classId:@"" resId:@"" cityId:@"" districtId:@"" minPrice:@"" maxPrice:@"" newOrOld:@"" delivery:@"" sort:@"" pageNum:self.currentPage success:^(id response) {
        [self.dataSource addObjectsFromArray:response];

    } failure:^(NSError *error, NSString *message) {
    }];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)setModel:(NSArray *)model {
    _model = model;
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollecttionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollecttionCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(105, 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView
                          layout:( UICollectionViewLayout *)collectionViewLayout
          insetForSectionAtIndex:( NSInteger )section{
    
    return UIEdgeInsetsMake (0,15,0,15);
    
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
