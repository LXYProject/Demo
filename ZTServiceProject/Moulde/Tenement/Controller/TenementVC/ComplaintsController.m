//
//  ComplaintsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/18.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ComplaintsController.h"
#import "StaticlCell.h"
#import "AddPhotosCell.h"
#import "ComplaintsCell.h"
#import "TenementHttpManager.h"

@interface ComplaintsController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ComplaintsController
{
    NSArray *_titleArray;
    NSArray *_contentArray;
    NSString *_affairTitle;
    NSString *_userRealName;
    NSString *_userPhoneNum;
    NSString *_affairDiscribe;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"投诉"
                  titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@""
                            title:@"提交"
                       titleColor:[UIColor whiteColor]
                         selector:@selector(rightBarClick)
                           target:self];

    _titleArray = @[@"投诉人:",
                    @"联系电话:"];
    _contentArray = @[@"输入您的姓名",
                      @"输入您的电话"];

}

- (void)rightBarClick
{
    NSLog(@"提交");
    // 投诉
    [TenementHttpManager requestPraiseOrComplaint:complaints
                                           zoneId:self.zoneId
                                      affairTitle:_affairTitle
                                   affairDiscribe:_affairDiscribe
                                   affairCategory:@"1"
                                      userAddress:@"北京市 海淀区 财智大厦 c305室"
                                     userRealName:_userRealName
                                     userPhoneNum:_userPhoneNum
                                           images:[UIImage imageNamed:@""]
                                          success:^(id response) {

                                              //操作失败的原因
                                              NSString *information = [response objectForKey:@"information"];
                                              //状态码
                                              NSString *status = [response objectForKey:@"status"];
                                              
                                              if ([status integerValue]==0) {
                                                    [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                                  
                                              }else{
                                                  [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                              }

                                          } failure:^(NSError *error, NSString *message) {

                                          }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }else{
        return nil;
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.textColor = TEXT_COLOR;
        cell.title.text = @"标题:";
        cell.content.placeholder = @"请输入标题";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
            [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
            [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        }
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj) ;
            _affairTitle = obj;
        };

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ComplaintsCell *cell = (ComplaintsCell *)[self creatCell:tableView indenty:@"ComplaintsCell"];
        cell.textViewBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _affairDiscribe = obj;
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    
    
    StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
    cell.title.textColor = TEXT_COLOR;
    cell.title.text = _titleArray[indexPath.row];
    cell.content.placeholder = _contentArray[indexPath.row];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        cell.title.font = [UIFont systemFontOfSize:13];
        [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    }else{
        cell.title.font = [UIFont systemFontOfSize:14];
        [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    if (indexPath.row==0) {
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userRealName = obj;
        };
    }else{
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
            _userPhoneNum = obj;
        };
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            return 44;
        }else{
            return 100;
        }
    }else if (indexPath.section ==1) {
        return 100;
    }else {
        return 44;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}

//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 5;
//}

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


@end
