//
//  AddPhotosCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "AddPhotosCell.h"
#import "ACSelectMediaView.h"

@interface AddPhotosCell()
@property (weak, nonatomic) IBOutlet UIView *placeholdView;


@property (nonatomic,strong)NSArray *dataSource;
@end

@implementation AddPhotosCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (IBAction)btnClick:(id)sender {
    
    [[PushManager currentViewController].view endEditing:YES];
    [self.mediaView showSelectMediaView];
    
}

- (void)setImagesArray:(NSArray *)imagesArray {
    self.mediaView.hidden = NO;
    self.placeholdView.hidden = YES;
    [self.mediaView layoutCollectionImages:imagesArray];
}

//-(void)setMaxCount:(NSInteger)maxCount {
//    if (maxCount == _maxCount) {
//        return;
//    }
//    _maxCount = maxCount;
//    [self initViewMediaView];
//    self.mediaView.maxCount = maxCount;
//}

- (void)setImageMaxCount:(NSInteger)imageMaxCount imageArray:(NSArray *)imageArray {
    [self initViewMediaView];
    self.mediaView.maxCount = imageMaxCount;
    if (imageArray.count>0) {
        self.mediaView.hidden = NO;
        self.placeholdView.hidden = YES;
        [self.mediaView layoutCollectionImages:imageArray];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectPhoto {
    NSLog(@"hhhh");
    
 }

- (void)initViewMediaView {
    [_mediaView observeViewHeight:^(CGFloat value) {
    self.contentView.height = value;
    }];
    //4、随时获取已经选择的媒体文件
    __weak ACSelectMediaView *weakMediaView = _mediaView;
    [_mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        
        for (ACMediaModel *model in list) {
            NSLog(@"%@",model);
        
        }
        self.dataSource = list;
        if (list.count>0) {
            weakMediaView.hidden = NO;
            self.placeholdView.hidden = YES;
        }
        else {
            weakMediaView.hidden = YES;
            self.placeholdView.hidden = NO;
        }
        if (self.finishedBlock) {
            self.finishedBlock(list);
        }
    }];
    _mediaView.hidden = YES;
}

//- (nsa *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [NSMutableArray arrayWithCapacity:1];
//    }
//    return _dataSource;
//}
@end
