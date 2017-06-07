//
//  NearByViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NearByViewController.h"
#import "NearByCell.h"



@interface NearByViewController ()<UITableViewDelegate,UITableViewDataSource>

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





@end
