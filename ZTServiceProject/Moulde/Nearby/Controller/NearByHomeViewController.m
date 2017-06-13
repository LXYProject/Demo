//
//  NearByHomeViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByHomeViewController.h"
#import "NearByHttpManager.h"
#import "NearByTitleModel.h"
#import "NearByViewController.h"
@interface NearByHomeViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>
@property (nonatomic,strong)NSMutableArray *vcDataArray;
@property (nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic,strong)NSMutableArray *tagTitles;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,copy)NSString *keywords;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *district;

@end

@implementation NearByHomeViewController
{
    NSInteger queryType;
//    NSMutableArray *response;
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
    
    [self leftItemWithNormalName:@"noticeYellow" title:@"北京" titleColor:[UIColor whiteColor] selector:@selector(leftBarClick) target:self];
    [self rightBarButtomItemWithNormalName:@"noticeYellow@3x" highName:@"noticeYellow@3x" selector:@selector(rightBarClick) target:self];

    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"去帮忙",@"找服务"]];
    segment.width = 200;
    
    segment.layer.cornerRadius = 15.0f;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = [UIColor whiteColor].CGColor;
    segment.layer.masksToBounds = YES;
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    queryType = 1;
    [self requestTitleArrayData];
//    response = [NSMutableArray arrayWithArray:@[@"的观点",@"十大",@"第三方",@"奥术大师多"]];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        self.titleArray = response;
//        if (self.titleArray.count != self.viewControllers.count) {
//            [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self.tagTitles addObject:response[idx]];
//                if(self.viewControllers.count<response.count) {
//                    [self.viewControllers addObject:[[NearByViewController alloc]init]];
//                }
//            }];
//            NSInteger differencCount = self.viewControllers.count - response.count;
//            [self.viewControllers removeObjectsInRange:NSMakeRange(self.viewControllers.count - differencCount -1 , differencCount)];
//        }
//        [self reloadData];
//    });

    
}
- (void)leftBarClick
{
    NSLog(@"leftBarClick");
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

-(void)segmentClick:(UISegmentedControl *)segment{
    
    if (segment.selectedSegmentIndex==0) {
        queryType=1;
    }else{
        queryType=0;
    }
    [self requestTitleArrayData];
}

// 请求周边上面的滚动title
- (void)requestTitleArrayData {
    @weakify(self);
    [NearByHttpManager rqeuestQueryType:queryType success:^(NSArray * response) {
        @strongify(self);
        [self.tagTitles removeAllObjects];
//        [self.viewControllers removeAllObjects];
        self.titleArray = response;
        if (self.titleArray.count != self.viewControllers.count) {
            [response enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NearByTitleModel *model = obj;
                [self.tagTitles addObject:model.categoryName];
                if(self.viewControllers.count<response.count) {
                    [self.viewControllers addObject:[[NearByViewController alloc]init]];
                }
            }];
            NSInteger differencCount = self.viewControllers.count - response.count;
            [self.viewControllers removeObjectsInRange:NSMakeRange(self.viewControllers.count - differencCount -1 , differencCount)];
        }
        [self reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
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
    NearByViewController *vc  = self.viewControllers[index];
    vc.navigationItem.title = self.tagTitles[index];
    vc.isFindService = queryType==1?NO:YES;
    vc.keywords = self.keywords;
    vc.city = self.city;
    vc.district = self.district;
    vc.categoryId = [self.titleArray[index] categoryId];
    
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
