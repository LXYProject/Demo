//
//  SolicitingViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/16.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SolicitingViewController.h"
#import "SolicitingHeadCell.h"
#import "SolicitBtnItemCell.h"
#import "SolicitBtnItemOneCell.h"
#import "SolicitItemCell.h"
#import "AddPhotosCell.h"
#import "SolicitDescriptionCell.h"
#import "DataPickerViewOneDemo.h"

@interface SolicitingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *toward;
@end

@implementation SolicitingViewController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSArray *_rightArray;
    
    NSString *_content;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"求租" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    _titleArray = @[@"租金:",
                    @"户型:",
                    @"朝向:"];
    _contentArray = @[@"请选择户型", @"请选择朝向"];
    _rightArray = @[@"",
                    @"选择",
                    @"南"];
    


    [self.tableView reloadData];
    
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    else if (section==1){
        return 2;
    }
    else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==1){
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section==2){
        return [self sectionTwoWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==3){
        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
    }else if (indexPath.section==4){
        return [self sectionFourTableView:tableView indexPath:indexPath];
    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = TEXT_COLOR;
    if (indexPath.row==0) {
        
    }else if (indexPath.row==1){
        cell.detailTextLabel.text = @"请选择户型";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        if (self.toward.length>0) {
            cell.detailTextLabel.text = self.toward;
        }else{
            cell.detailTextLabel.text = @"请选择朝向";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;

//    SolicitingHeadCell *cell = (SolicitingHeadCell *)[self creatCell:tableView indenty:@"SolicitingHeadCell"];
//    if (indexPath.row==0) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    if (indexPath.row==2) {
//        [cell.content removeFromSuperview];
//    }
//    cell.title.text = [NSString stringWithFormat:@"%@:", _titleArray[indexPath.row]];
//    cell.content.placeholder = _contentArray[indexPath.row];
//    cell.rightContent.text = _rightArray[indexPath.row];
//    if (IS_IPHONE_4 || IS_IPHONE_5) {
//        cell.title.font = [UIFont systemFontOfSize:13];
//        cell.rightContent.font = [UIFont systemFontOfSize:13];
//        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
//    }else{
//        cell.title.font = [UIFont systemFontOfSize:14];
//        cell.rightContent.font = [UIFont systemFontOfSize:14];
//        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//    }
//    cell.title.textColor = TEXT_COLOR;
//    cell.rightContent.textColor = TEXT_COLOR;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        SolicitBtnItemCell *cell = (SolicitBtnItemCell *)[self creatCell:tableView indenty:@"SolicitBtnItemCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        SolicitBtnItemOneCell *cell = (SolicitBtnItemOneCell *)[self creatCell:tableView indenty:@"SolicitBtnItemOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    SolicitItemCell *cell = (SolicitItemCell *)[self creatCell:tableView indenty:@"SolicitItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第4组
- (UITableViewCell *)sectionFourTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    
    SolicitDescriptionCell *cell = (SolicitDescriptionCell *)[self creatCell:tableView indenty:@"SolicitDescriptionCell"];
    cell.textViewBlock = ^(id obj) {
        NSLog(@"obj==%@", obj);
        _content = obj;
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//公共创建cell的方法
- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
        }else if (indexPath.row==1){
            
        }else{
            [[DataPickerViewOneDemo sharedPikerView]show];
            [DataPickerViewOneDemo sharedPikerView].title = @"选择房屋朝向";
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:@[@"无所谓了", @"东", @"西", @"南", @"北", @"东南", @"西南", @"西北", @"东北"]];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.toward = dateStr;
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            };

        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 5.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(247, 247, 247);
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || indexPath.section==1) {
        return 44;
    }
    else if (indexPath.section ==2) {
        return 110;
    }
    else {
        return 100;
    }
}

@end
