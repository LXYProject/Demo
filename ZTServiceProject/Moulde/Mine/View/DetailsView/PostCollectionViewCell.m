//
//  PostCollectionViewCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/8/1.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "PostCollectionViewCell.h"
#import "PostImageCollectionCell.h"

@interface PostCollectionViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation PostCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PostImageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"PostImageCollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setModel:(NSArray *)model {
//    _model = model;
//    [self.collectionView reloadData];
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostImageCollectionCell" forIndexPath:indexPath];
    //cell.model = _model[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 75);
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
