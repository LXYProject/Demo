//
//  ChatFriendsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ChatFriendsController.h"
#import "FTPopOverMenu.h"
#import "ChatCell.h"
#import "FriendsCell.h"

@interface ChatFriendsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatFriendsController
{
    NSInteger queryType;
    NSInteger selectedSegmentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self rightBarButtomItemWithNormalName:@"add_btn"
                                  highName:@"add_btn"
                                  selector:@selector(rightBarClick:)
                                    target:self];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"会话",@"好友"]];
    segment.width = 150;
    
    segment.layer.cornerRadius = 15.0f;
    segment.layer.borderWidth = 1;
    segment.layer.borderColor = [UIColor whiteColor].CGColor;
    segment.layer.masksToBounds = YES;
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    queryType = 0;

}
// 弹出自定义视图
- (void)rightBarClick:(id)sender{
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 44;
    configuration.menuWidth = 150;
    configuration.textColor = [UIColor darkGrayColor];
    configuration.textFont = [UIFont systemFontOfSize:14];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor redColor];
    configuration.borderWidth = 0.5;
    configuration.textAlignment = NSTextAlignmentLeft;
    //    configuration.ignoreImageOriginalColor = YES;// set 'ignoreImageOriginalColor' to YES, images color will be same as textColor
    [FTPopOverMenu showForSender:sender
                   withMenuArray:@[@"同小区的人", @"活跃的人", @"搜索"]
                      imageArray:@[@"", @"", @""]
                       doneBlock:^(NSInteger selectedIndex) {
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           if (selectedIndex==0) {
                               [PushManager pushViewControllerWithName:@"VillagePeopleController" animated:YES block:nil];
                           }else if (selectedIndex==1){
                               [PushManager pushViewControllerWithName:@"ActivePeopleController" animated:YES block:nil];
                           }else{
                               [PushManager pushViewControllerWithName:@"SearchPeopleController" animated:YES block:nil];
                           }
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                       }];
}
-(void)segmentClick:(UISegmentedControl *)segment{
    NSLog(@"segment.selectedSegmentIndex==%ld", segment.selectedSegmentIndex);
    
    if (segment.selectedSegmentIndex==0) {
        queryType=0;
    }else{
        queryType=1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];

}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (queryType==0) {
        ChatCell *cell = (ChatCell *)[self creatCell:tableView indenty:@"ChatCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        FriendsCell *cell = (FriendsCell *)[self creatCell:tableView indenty:@"FriendsCell"];
        return cell;
    }
}
//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}
@end
