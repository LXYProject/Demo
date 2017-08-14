//
//  LookingForViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "LookingForViewController.h"
#import "StaticlCell.h"
#import "StaticOneCell.h"
#import "BtnItemCell.h"
#import "AddPhotosCell.h"
#import "LookingDescriptionCell.h"
#import "DataPickerViewOneDemo.h"
#import "ReleaseClassifiedController.h"

@interface LookingForViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *oldAndNew;
@property (nonatomic, copy) NSString *price;

@end

@implementation LookingForViewController
{
    NSArray *_titleArray;
    NSArray *_detailsArr;
    NSArray *_contentArray;
    NSArray *_titleOneArray;
    NSArray *_contentOneArray;
    
    NSString *_content;

}

- (void)setBrandModels:(NSString *)brandModels{
    _brandModels = brandModels;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"求购" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    
    _titleArray = @[@"品牌型号：", @"新旧程度：", @"价格范围："];
    _detailsArr = @[@"请选择品牌型号", @"请选择新旧程度", @"请选择价格范围"];
    _contentArray = @[@"请输入物品的名称",
                      @"请输入品牌的型号"];
    _contentOneArray = @[@"八成新",
                         @"1000-2000"];
    self.tableView.backgroundColor = RGB(247, 247, 247);

}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 4;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self sectionZeroWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==1) {
        return [self sectionOneWithTableView:tableView indexPath:indexPath];
    }
    else if (indexPath.section ==2) {
        return [self sectionTwoTableView:tableView indexPath:indexPath];
    }
    else{
        return [self sectionThirdTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        StaticlCell *cell = (StaticlCell *)[self creatCell:tableView indenty:@"StaticlCell"];
        cell.title.text = @"名       称:";
        cell.content.placeholder = @"请输入物品的名称";
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.title.font = [UIFont systemFontOfSize:13];
            [cell.content setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        }else{
            cell.title.font = [UIFont systemFontOfSize:14];
            [cell.content setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        }
        cell.textFieldBlock = ^(id obj) {
            NSLog(@"obj==%@", obj);
//            _userPhoneNum = obj;
        };
        cell.title.textColor = TEXT_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        
        static NSString *ID = @"cell";
        // 根据标识去缓存池找cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        // 不写这句直接崩掉，找不到循环引用的cell
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        }
        cell.textLabel.text = _titleArray[indexPath.row-1];
        if (indexPath.row==1) {
            if (self.brandModels.length>0) {
                cell.detailTextLabel.text = self.brandModels;
            }else{
                cell.detailTextLabel.text = @"请选择品牌型号";
            }
        }else if (indexPath.row==2){
            if (self.oldAndNew.length>0) {
                cell.detailTextLabel.text = self.oldAndNew;
            }else{
                cell.detailTextLabel.text = @"请选择新旧程度";
            }
        }else{
            if (self.price.length>0) {
                cell.detailTextLabel.text = self.price;
            }else{
                cell.detailTextLabel.text = @"请选择价格范围";
            }
        }
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        }else{
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        }
        cell.textLabel.textColor = TEXT_COLOR;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

//        StaticOneCell *cell = (StaticOneCell *)[self creatCell:tableView indenty:@"StaticOneCell"];
//        cell.titleLabel.textColor = TEXT_COLOR;
//        cell.contentLabel.textColor = TEXT_COLOR;
//        cell.titleLabel.text = _titleOneArray[indexPath.row-2];
//        cell.contentLabel.text = _contentOneArray[indexPath.row-2];
//        if (IS_IPHONE_4 || IS_IPHONE_5) {
//            cell.titleLabel.font = [UIFont systemFontOfSize:13];
//            cell.contentLabel.font = [UIFont systemFontOfSize:11];
//        }else{
//            cell.titleLabel.font = [UIFont systemFontOfSize:14];
//            cell.contentLabel.font = [UIFont systemFontOfSize:12];
//        }
//        return cell;
    }
    
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    BtnItemCell *cell = (BtnItemCell *)[self creatCell:tableView indenty:@"BtnItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    
    AddPhotosCell *cell = (AddPhotosCell *)[self creatCell:tableView indenty:@"AddPhotosCell"];
    cell.finishedBlock = ^(NSArray *images) {
        NSLog(@"images==%@", images);
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath {
    
    LookingDescriptionCell *cell = (LookingDescriptionCell *)[self creatCell:tableView indenty:@"LookingDescriptionCell"];
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
            [PushManager pushViewControllerWithName:@"ReleaseClassifiedController" animated:YES block:^(ReleaseClassifiedController* viewController) {
                viewController.currentController = 1;
            }];
        }else if (indexPath.row==2){
            [[DataPickerViewOneDemo sharedPikerView]show];
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:@[@"无所谓", @"全新", @"九成新", @"七成新", @"五成新", @"旧货"]];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.oldAndNew = dateStr;
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }else{
            [[DataPickerViewOneDemo sharedPikerView]show];
            [[DataPickerViewOneDemo sharedPikerView] setDataSource:@[@"0~100", @"100~200", @"200~300", @"300~400", @"400~500", @"500以上"]];
            [DataPickerViewOneDemo sharedPikerView].pikerSelected = ^(NSString *dateStr) {
                NSLog(@"date:%@",dateStr);
                self.price = dateStr;
                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
        }
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
            return 44;
    }
    else if (indexPath.section ==1) {
        return 85;
    }
    else {
        return 100;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.f;
    }else{
        return 5.f;
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.0001;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 5;
//}

@end
