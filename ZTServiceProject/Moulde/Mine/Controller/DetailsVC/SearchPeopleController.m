//
//  SearchPeopleController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SearchPeopleController.h"

@interface SearchPeopleController ()
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

@implementation SearchPeopleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"搜索" titleColor:[UIColor whiteColor]];

}

- (IBAction)searchBtnClick {
}


@end
