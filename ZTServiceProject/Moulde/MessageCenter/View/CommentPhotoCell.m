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

@property (nonatomic,strong)NSMutableArray *imgUrlArray;
@end

@implementation CommentPhotoCell
{
    NSArray *_smallModes;
    ZTKeyBoardManager *_keyBoardManager;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _keyBoardManager = [ZTKeyBoardManager sharedZTKeyBoardManager];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MessagePhotoCell" bundle:nil] forCellWithReuseIdentifier:@"MessagePhotoCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)smallImgs:(NSArray *)smallImgs normalImgs:(NSArray *)normalImg {
    _smallModes = smallImgs;
    [self.imgUrlArray removeAllObjects];
    if (normalImg) {
        if(normalImg.count>0) {
            [self.collectionView reloadData];
        }
        [normalImg enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MessagePhotoModel *model = obj;
            [self.imgUrlArray addObject:model.url];
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _smallModes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MessagePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MessagePhotoCell" forIndexPath:indexPath];
    MessagePhotoModel *model = _smallModes[indexPath.row];
    @weakify(self);
    cell.clickPhoto = ^(id obj) {
        @strongify(self);
        if (_keyBoardManager.keyBoardIsShowing) {
            [[PushManager currentViewController].view endEditing:YES];
            return;
        }
        [XLPhotoBrowser showPhotoBrowserWithImages:self.imgUrlArray currentImageIndex:indexPath.row];
    };
    cell.url = model.url;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(((ScreenWidth - 30 )- 2*3)/3, ((ScreenWidth - 30 )- 2*3)/3);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end
