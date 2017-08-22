//
//  MessageCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/8.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "MessagePhotoCell.h"
#import "MessagePhotoModel.h"
@interface MessageCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewH;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MessagePhotoCell" bundle:nil] forCellWithReuseIdentifier:@"MessagePhotoCell"];
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString: @"contentSize"]) {
        NSLog(@"%@",change);
        CGSize size = [change[@"new"] CGSizeValue];
        self.imageViewH.constant = size.height;
    }
}

- (void)setModel:(MessageModel *)model {
    _userImageView.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = _userImageView.bounds.size.width * 0.5;
    _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;

    [_userImageView sd_setImageWithURL:[NSURL URLWithString:model.ownerImageUrl?model.ownerImageUrl:@""] placeholderImage:[UIImage imageNamed:@"Pic_blank_328px"]];
    
    _userNameLabel.text = model.ownerName;
    _timeLabel.text = model.createTime;
    _contentLabel.text = model.topicTitle;
    _addressLabel.text = model.address;

    _model = model;
    if (_model.topicSmallImageList.count==0) {
        self.imageViewH.constant = 0;
    }
    else {
        [self.collectionView reloadData];
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

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView
                          layout:( UICollectionViewLayout *)collectionViewLayout
          insetForSectionAtIndex:( NSInteger )section{
    
    return UIEdgeInsetsMake (0,15,0,15);
    
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
}


@end
