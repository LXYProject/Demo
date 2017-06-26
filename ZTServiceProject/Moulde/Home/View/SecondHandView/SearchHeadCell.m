//
//  SearchHeadCell.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SearchHeadCell.h"
#import "SearchViewController.h"    

@interface SearchHeadCell ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end
@implementation SearchHeadCell
{
    BOOL jump;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    jump = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.contentView endEditing:YES];
    [PushManager pushViewControllerWithName:@"SearchViewController" animated:YES block:nil];
}


////searchBar 响应键盘
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    
//    NSLog(@"跳转");
//    //    if (_historyArray.count != 0) {
//    //        //        _historyViewController.historyRecords = _historyArray;
//    //        //        [self showTheHistoryRecords];
//    //        [self.searchBar becomeFirstResponder];
//    //    }
//    [self showTheHistoryRecords];
//    [self.searchBar becomeFirstResponder];
//
//    if (jump) {
//       
//        jump = NO;
//    }
//}

#pragma  mark- history records
- (void)showTheHistoryRecords
{
    
}
@end
