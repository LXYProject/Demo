//
//  HouseRentCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "HouseRentCell.h"
#import "RentHouseModel.h"
#import "EYTagView.h"

@interface HouseRentCell ()<EYTagViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet EYTagView *tagView;

@property (nonatomic, strong) NSMutableArray *tagsSouses;
@property (nonatomic, copy) NSString *basicFacilities;
@property (nonatomic, copy) NSString *extendedFacilities;
@property (nonatomic, copy) NSString *rentLimit;

@property (nonatomic, copy) NSString *url;

@end
@implementation HouseRentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    

    
        
    //[_tagView addTags:_tagsSouses];
    
    
    
}

-(void)heightDidChangedTagView:(EYTagView *)tagView{
//    NSLog(@"heightDidChangedTagView");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 租房Model
- (void)setRentHouseModel:(RentHouseModel *)rentHouseModel{
    _rentHouseModel = rentHouseModel;
    for (NSDictionary *dic in rentHouseModel.housePicList) {
        NSString *imageUrl = [dic objectForKey:@"url"];
        //        NSLog(@"imageUrl==%@", imageUrl);
        self.url = imageUrl;
    }
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:self.url?self.url:@""] placeholderImage:[UIImage imageNamed:@"message_tabbar_default"]];
    _headTitle.text = rentHouseModel.houseType;
//    _detailsContent.text = rentHouseModel.houseType;
//    _placeLabel.text = rentHouseModel.address;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.0f/月",[rentHouseModel.rentPrice doubleValue]];
    _time.text = rentHouseModel.publishTime;

    
//    _tagView.translatesAutoresizingMaskIntoConstraints=YES;
    _tagView.delegate=self;
    
    _tagView.colorTag=COLORRGB(0xffffff);
    _tagView.colorTagBg=[UIColor yellowColor];
    _tagView.colorInput=COLORRGB(0x2ab44e);
    _tagView.colorInputBg=COLORRGB(0xffffff);
    _tagView.colorInputPlaceholder=COLORRGB(0x2ab44e);
    _tagView.backgroundColor=COLORRGB(0xffffff);
    _tagView.colorInputBoard=COLORRGB(0x2ab44e);
//    _tagView.viewMaxHeight=44;
    _tagView.type =  EYTagView_Type_Display;
    NSMutableArray *tagArrays = [NSMutableArray arrayWithCapacity:1];
    [tagArrays addObjectsFromArray:rentHouseModel.basicFacilities];
    [tagArrays addObjectsFromArray:rentHouseModel.extendedFacilities];
    [tagArrays addObjectsFromArray:rentHouseModel.rentLimit];
    [_tagView addTags:tagArrays];
//    [_tagView.tagButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIButton *btn = obj;
//        if (idx==0) {
//            
//            [btn setBackgroundColor:UIColorFromRGB(0xe64e51)];
//        }
//        else if (idx == 1) {
//            btn.backgroundColor = [UIColor colorWithRed:253.0/255 green:106.0/255 blue:214.0/255 alpha:1];
//        }
//        else if (idx ==2){
//            btn.backgroundColor = [UIColor yellowColor];
//        }
//        else {
//            btn.backgroundColor = [UIColor grayColor];
//        }
//    }];

    
    NSLog(@"rentHouseModel.basicFacilities==%@", rentHouseModel.basicFacilities);
}

- (NSMutableArray *)tagsSouses{
    if (!_tagsSouses) {
        _tagsSouses = [NSMutableArray arrayWithCapacity:1];
    }
    return _tagsSouses;
}
@end
