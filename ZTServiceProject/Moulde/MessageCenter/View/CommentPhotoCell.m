//
//  CommentPhotoCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/25.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "CommentPhotoCell.h"
#import "MessageModel.h"
#import "MessagePhotoCell.h"
#import "MessagePhotoModel.h"
@interface CommentPhotoCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imgUrlArray;
@end

@implementation CommentPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MessagePhotoCell" bundle:nil] forCellWithReuseIdentifier:@"MessagePhotoCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    if (model) {
        if(model.topicSmallImageList.count>0) {
            [self.collectionView reloadData];
        }
        [model.topicNormalImageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MessagePhotoModel *model = obj;
            [self.imgUrlArray addObject:model.url];
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.topicSmallImageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessagePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessagePhotoCell" forIndexPath:indexPath];
    MessagePhotoModel *model = _model.topicSmallImageList[indexPath.row];
    cell.url = model.url;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth-15*4)/3, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [XLPhotoBrowser showPhotoBrowserWithImages:self.imgUrlArray currentImageIndex:indexPath.row];
}

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView
                          layout:( UICollectionViewLayout *)collectionViewLayout
          insetForSectionAtIndex:( NSInteger )section{
    
    return UIEdgeInsetsMake (0,15,0,15);
    
}

-(NSMutableArray *)imgUrlArray {
    if (!_imgUrlArray) {
        _imgUrlArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgUrlArray;
}

@end
