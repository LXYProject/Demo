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
//#import "SecondDetailsController.h" 

@interface secondHandCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
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
}

- (void)setModel:(NSArray *)model {
    _model = model;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollecttionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollecttionCell" forIndexPath:indexPath];
    cell.model = _model[indexPath.row];
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

//点击Cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"indexPath.row==%ld", (long)indexPath.row);
    [PushManager pushViewControllerWithName:@"SecondDetailsController" animated:YES block:nil];
}
@end
