//
//  NearByViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByViewController.h"
#import "NearByCell.h"

<<<<<<< HEAD
@interface NearByViewController ()
=======
@interface NearByViewController ()<UITableViewDelegate,UITableViewDataSource>
>>>>>>> 1a4461bbb709b1cbe2807c8113a4bc1358eada04
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataSourceArray.count;
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        NearByCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearByCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"NearByCell" owner:nil options:nil] lastObject];
        }
//        @weakify(self);
//        cell.btnClickBlock = ^(NSInteger value) {
//            @strongify(self);
//            [PushManager pushViewControllerWithName:self.dataSourceArray[indexPath.section][value][@"vcName"] animated:YES block:nil];
//        };
//        cell.titleAndImageDictArray = self.dataSourceArray[indexPath.section];
        return cell;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 119;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



@end
