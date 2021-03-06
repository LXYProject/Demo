//
//  NearByHomeViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "VillageSlidingController.h"
#import "TenementHttpManager.h"
#import "VillagePanoramaModel.h"
#import "VillagePanoramaController.h"

@interface VillageSlidingController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>
@property (nonatomic,strong)NSMutableArray *vcDataArray;
@property (nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic,strong)NSMutableArray *tagTitles;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *district;

@end

@implementation VillageSlidingController
{
    NSInteger queryType;
    NSMutableArray *response;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    self.fixTabWidth = NO;
    self.padding = 10;
    self.leadingPadding = 10;
    self.trailingPadding = 10;
    self.defaultDisplayPageIndex = 0;
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
    self.indicatorColor = [UIColor colorWithRed:255.0/255.0 green:205.0 / 255.0 blue:0.0 alpha:1.0];
    
    [self rightBarButtomItemWithNormalName:@"selech_icon"
                                  highName:@"selech_icon"
                                  selector:@selector(rightBarClick)
                                    target:self];
    
    [self requestTitleArrayData];
    
    
    response = [NSMutableArray arrayWithArray:@[@"的观点",@"十大",@"第三方",@"奥术大师多"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.titleArray = response;
        if (self.titleArray.count != self.viewControllers.count) {
            [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.tagTitles addObject:response[idx]];
                if(self.viewControllers.count<response.count) {
                    [self.viewControllers addObject:[[VillagePanoramaController alloc]init]];
                }
            }];
            NSInteger differencCount = self.viewControllers.count - response.count;
            [self.viewControllers removeObjectsInRange:NSMakeRange(self.viewControllers.count - differencCount -1 , differencCount)];
        }
        [self reloadData];
    });

    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

// 请求周边上面的滚动title
- (void)requestTitleArrayData {
    
//    [TenementHttpManager requestListOrPanorama:VillagePanorama
//                                        zoneId:@"510018177815"
//                                       success:^(NSArray* response) {
//                                           
//                                           [self.tagTitles removeAllObjects];
//                                           //        [self.viewControllers removeAllObjects];
//                                           self.titleArray = response;
//                                           if (self.titleArray.count != self.viewControllers.count) {
//                                               [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                                                   VillagePanoramaModel *model = obj;
//                                                   [self.tagTitles addObject:model.featureCategory];
//                                                   if(self.viewControllers.count<response.count) {
//                                                       [self.viewControllers addObject:[[VillagePanoramaController alloc]init]];
//                                                   }
//                                               }];
//                                               NSInteger differencCount = self.viewControllers.count - response.count;
//                                               [self.viewControllers removeObjectsInRange:NSMakeRange(self.viewControllers.count - differencCount -1 , differencCount)];
//                                           }
//                                           [self reloadData];
//
//                                           
//                                           
//                                       } failure:^(NSError *error, NSString *message) {
//                                           
//                                       }];
}

#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}



- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
    if (self.viewControllers.count==0) {
        return;
    }
    VillagePanoramaController *vc  = self.viewControllers[index];
    vc.navigationItem.title = self.tagTitles[index];
//    vc.isFindService = queryType==1?NO:YES;
//    vc.keywords = self.keywords;
//    vc.city = self.city;
//    vc.district = self.district;
    vc.featureCategory = [self.titleArray[index] featureCategory];
    vc.featureId = [self.titleArray[index] featureId];
    
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0 - (0.5 * progress)];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5 + (0.5 * progress)];
}

- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
    return prototypeLabel.intrinsicContentSize.width;
}


-(NSMutableArray *)tagTitles {
    if (!_tagTitles) {
        _tagTitles = [NSMutableArray arrayWithCapacity:1];
    }
    return _tagTitles;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray arrayWithCapacity:1];
    }
    return _viewControllers;
}

-(NSMutableArray *)vcDataArray {
    if (!_vcDataArray) {
        _vcDataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _vcDataArray;
}

@end
