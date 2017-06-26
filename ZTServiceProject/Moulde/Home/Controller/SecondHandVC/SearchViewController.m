//
//  SearchViewController.m
//  SearchTable
//
//  Created by 张圆圆 on 17/6/20.
//  Copyright © 2017年 张圆圆. All rights reserved.
//

#import "SearchViewController.h" 
#import "SearchOneHeadCell.h"
#import "SearchItemCell.h"
#import "SecondHandSearchHeaderView.h"
#import "SecondHanditemCell.h"
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HistoryKey @"HistoryKey"
#define HistoryMaxCount 20

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (nonatomic,strong)NSArray *historyArray;
@property (nonatomic,strong)NSArray *hotArry;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChnage:) name:UITextFieldTextDidChangeNotification object:self.searchBar];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SecondHandSearchHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SecondHandSearchHeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SecondHanditemCell" bundle:nil] forCellWithReuseIdentifier:@"SecondHanditemCell"];
    self.hotArry = @[@"男鞋",@"电动车",@"男鞋",@"电动车",@"男鞋",@"男鞋",@"电动车",@"男鞋",@"电动车",@"男鞋",@"电动车",@"男鞋",@"电动车",@"男鞋",@"电动车",];
}

//坚挺输入框文字变化
- (void)textChnage:(NSNotification *)noti {
    UITextField *textField = [noti object];
    textField.text =[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

//搜索按钮点击
- (IBAction)searchBtnClick:(id)sender {
    NSString *currentText = self.searchBar.text;
    [self saveHistoryKeywordsWithText:currentText];
    self.historyArray = GetValueForKey(HistoryKey);
    [self.collectionView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.historyArray.count>0&&self.hotArry.count>0) {
        return 2;
    }
    else if(self.historyArray.count==0&&self.hotArry.count==0){
        return 0;
    }
    else {
        return 1;
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section==0) {
        return self.historyArray.count>0?self.historyArray.count:self.hotArry.count;
    }
    else {
        return self.hotArry.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondHanditemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecondHanditemCell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        cell.title = self.historyArray.count>0?self.historyArray[indexPath.row]:self.hotArry[indexPath.row];
    }
    else {
        cell.title = self.hotArry[indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SecondHandSearchHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SecondHandSearchHeaderView" forIndexPath:indexPath];
        if (indexPath.section ==0) {
            headerView.text = self.historyArray.count>0?@"历史记录":@"热门搜索";
        }
        else {
            headerView.text = @"热门搜索";
        }
        return headerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
   return  CGSizeMake(ScreenWidth, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth-2)/3, 44);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1,0 , 1, 0);
}

- (void)saveHistoryKeywordsWithText:(NSString *)currentText {
    NSArray *keyWords = GetValueForKey(HistoryKey);
    NSMutableArray *array = [NSMutableArray arrayWithArray:keyWords];
    if (array) {
        if (array.count>0) {
            if ([array containsObject:currentText]) {
                [array removeObject:currentText];
                [array insertObject:currentText atIndex:0];
            }
            else {
                if (array.count<HistoryMaxCount) {
                    [array insertObject:currentText atIndex:0];
                }
                else {
                    array.count==HistoryMaxCount?[array removeLastObject]:[array removeObjectsInRange:NSMakeRange(18, array.count-19)];
                    [array insertObject:currentText atIndex:0];
                }
            }
        }
        else {
            [array addObject:currentText];
        }
    }
    else {
        array = [NSMutableArray arrayWithCapacity:1];
        [array addObject:currentText];
    }
    DefaultSaveKeyValue(HistoryKey, array);
}
@end
