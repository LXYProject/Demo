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

#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *tagAry;
@property (nonatomic,assign) float maxHeight;

@property (nonatomic,strong) NSMutableArray *dataSouse;
@property (nonatomic,strong) NSArray *groupTitleArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataSouse = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = RGB(247, 247, 247);

    self.groupTitleArray = @[@"历史记录", @"热门搜索"];
    
    SearchOneHeadCell *searchHead =   [[NSBundle mainBundle] loadNibNamed:@"SearchOneHeadCell" owner:nil
                                                     options:nil
                          ].lastObject;
    
    self.tableView.tableHeaderView =searchHead;
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    SearchItemCell *cell = (SearchItemCell *)[self creatCell:tableView indenty:@"SearchItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
//    SearchItemCell *cell = (SearchItemCell *)[self creatCell:tableView indenty:@"SearchItemCell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    return nil;

}
//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}


/*设置标题头的名称*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"历史记录";
    }
    else
        return @"热门搜索";
}

/*设置标题头的宽度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 44.f;
    }else{
        return 44.f;
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
//    view.backgroundColor = RGB(247, 247, 247);
//    return view;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footView = [[UIView alloc] init];
//    footView.backgroundColor = [UIColor clearColor];
//    return footView;
//}
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 132;
}
@end
