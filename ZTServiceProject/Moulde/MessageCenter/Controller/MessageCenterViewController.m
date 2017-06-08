//
//  MessageCenterViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageHeaderCell.h"
#import "MessageCell.h"

@interface MessageCenterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==0 ){
        MessageHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageHeaderCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageHeaderCell" owner:nil options:nil] lastObject];
        }
//        cell.titleHeader = _titleHeader[indexPath.section];
        return cell;
    }
    else {
        
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];
        }
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
        if (indexPath.row ==0) {
            return 49;
        }
        return 182;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
