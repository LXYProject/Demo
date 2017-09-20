//
//  SecondDetailsController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/20.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondDetailsController.h"
#import "SecondBannerCell.h"
#import "SecondDetailsCell.h"
#import "SecondBtnItemCell.h"
#import "SecondUserCell.h"  
#import "SecondAddressCell.h"
#import "CommentsHeadCell.h"
#import "CommentContentCell.h"
#import "SecondHandModel.h"
#import "CommentInfoCell.h"
#import "HomeHttpManager.h"

@interface SecondDetailsController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong)UIView *keyBoardToolsView;
@property (nonatomic,strong)UITextField *commentTextField;
@property (nonatomic,strong)UIButton *senderBtn;


@end

@implementation SecondDetailsController
{
    NSArray *imageNames;
    NSString *_secondHandId;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"二手物品详情" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"搜索" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];
    self.tableView.backgroundColor = RGB(247, 247, 247);
    
    imageNames = @[
                   @"timg.jpeg",
                   @"timg.jpeg",
                   @"timg.jpeg",
                   ];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondDetailsCell" bundle:nil] forCellReuseIdentifier:@"SecondDetailsCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentInfoCell" bundle:nil] forCellReuseIdentifier:@"CommentInfoCell"];
    
    [self.view addSubview:self.keyBoardToolsView];

    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
    
    
    //注册键盘出现NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    
    //注册键盘隐藏NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    // 二手物品Id
    _secondHandId = self.model.secondHandId;
}

- (void)rightBarClick
{
    NSLog(@"rightBarClick");
}

- (void)commentTableViewTouchInSide{
    [self.view endEditing:YES] ;
}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    if (![self.view.subviews containsObject:self.keyBoardToolsView]) {
//        [self.view addSubview:self.keyBoardToolsView];
//    }
//}

- (void)keyboardWillShow:(NSNotification *)noti {
    // 获取通知的信息字典
    NSDictionary *userInfo = [noti userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height, 0.0);
    self.tableView.scrollEnabled = YES;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    //    CGRect aRect = self.view.frame;
    //    aRect.size.height -= keyboardRect.size.height;
    //    if (!CGRectContainsPoint(aRect, activeField.superview.superview.frame.origin) ) {
    //        CGPoint scrollPoint = CGPointMake(0.0, activeField.superview.superview.frame.origin.y-aRect.size.height+44);
    //        [displayTable setContentOffset:scrollPoint animated:YES];
    //    }
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.keyBoardToolsView.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height-44);
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)noti {
    // 获取通知信息字典
    NSDictionary* userInfo = [noti userInfo];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        self.keyBoardToolsView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else if (section==1){
        return 1;
    }else{
        return 2+self.model.commentList.count;
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
    }
//    else if (indexPath.section==3){
//        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
//    }
    return nil;
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        SecondBannerCell *cell = (SecondBannerCell *)[self creatCell:tableView indenty:@"SecondBannerCell"];
        //cell.secondModelArray = self.model.secondHandNormalImageList;
        NSArray *array = [self.model.imageUrlList componentsSeparatedByString:@","];
        if (array.count>0) {
            cell.secondModelArray = array;
        }
        return cell;
    }else if (indexPath.row==1){
        SecondDetailsCell *cell = (SecondDetailsCell *)[self creatCell:tableView indenty:@"SecondDetailsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if (indexPath.row==2){
        SecondUserCell *cell = (SecondUserCell *)[self creatCell:tableView indenty:@"SecondUserCell"];
        cell.model = self.model;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        SecondAddressCell *cell = (SecondAddressCell *)[self creatCell:tableView indenty:@"SecondAddressCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    SecondBtnItemCell *cell = (SecondBtnItemCell *)[self creatCell:tableView indenty:@"SecondBtnItemCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {

    if (indexPath.row==0) {
        CommentsHeadCell *cell = (CommentsHeadCell *)[self creatCell:tableView indenty:@"CommentsHeadCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==1){
        CommentContentCell *cell = (CommentContentCell *)[self creatCell:tableView indenty:@"CommentContentCell"];
        cell.model = self.model;
       // @weakify(self);
        cell.commentSuccessBlock = ^(id obj) {
            //@strongify(self);
            //操作失败的原因
           // NSString *information = [obj objectForKey:@"information"];
            //状态码
            NSString *status = [obj objectForKey:@"status"];
            
            if ([status integerValue]==0) {
                
                //[AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
            }else{
                //[AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
            }

        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
        NSArray *commentList = self.model.commentList;
        cell.secondModel = commentList[indexPath.row-2];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

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
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 270;
        }else if (indexPath.row==1){
                return [tableView fd_heightForCellWithIdentifier:@"SecondDetailsCell" configuration:^(SecondDetailsCell* cell) {
                    cell.model = self.model;
                }];
        }
        else{
            return 44;
        }
    }else if (indexPath.section==1){
        return 44;
    }
    else{
        if (indexPath.row==0) {
            return 44;
        }else if(indexPath.row==1){
            return 65;
        }else{
            return  [tableView fd_heightForCellWithIdentifier:@"CommentInfoCell" cacheByIndexPath:indexPath configuration:^(CommentInfoCell* cell) {
                NSArray *commentList = self.model.commentList;
                cell.secondModel = commentList[indexPath.row-2];
            }];
            return 0;

        }
    }
}

//收藏
- (IBAction)collectionBtnClick {
    @weakify(self);
    [HomeHttpManager requestSecondHandId:_secondHandId
                                 success:^(id response) {
                                     @strongify(self);
                                     //操作失败的原因
                                     NSString *information = [response objectForKey:@"information"];
                                     //状态码
                                     NSString *status = [response objectForKey:@"status"];
                                     
                                     if ([status integerValue]==0) {
                                         
                                         [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                     }else{
                                         [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                     }
                                     [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                 } failure:^(NSError *error, NSString *message) {
                                 
                                 }];
}

//评论
- (IBAction)commentsBtn {
    
    self.keyBoardToolsView.hidden = NO;
    self.commentTextField.placeholder = @"评论";
    [self.commentTextField becomeFirstResponder];
    
}

//我想要
- (IBAction)wantToBtnClick {
}

- (UIView *)keyBoardToolsView {
    if (!_keyBoardToolsView) {
        _keyBoardToolsView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-64, ScreenWidth, 44)];
        _keyBoardToolsView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        _keyBoardToolsView.layer.borderWidth = 0.5;
//        _keyBoardToolsView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [_keyBoardToolsView addSubview:self.commentTextField];
        [_keyBoardToolsView addSubview:self.senderBtn];
        _keyBoardToolsView.hidden = YES;
    }
    return _keyBoardToolsView;
}

- (UITextField *)commentTextField {
    if (!_commentTextField) {
        _commentTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth-80, 30)];
        _commentTextField.borderStyle = UITextBorderStyleRoundedRect;
        //_commentTextField.backgroundColor = [UIColor darkGrayColor];
        _commentTextField.font = [UIFont systemFontOfSize:14];
    }
    return _commentTextField;
}


- (UIButton *)senderBtn {
    if(!_senderBtn) {
        _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _senderBtn.layer.masksToBounds = YES;
        _senderBtn.layer.cornerRadius = 3;
        _senderBtn.frame = CGRectMake(ScreenWidth - 60, 7, 50, 30);
        [_senderBtn setTitle:@"留言" forState:UIControlStateNormal];
        [_senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _senderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _senderBtn.backgroundColor = UIColorFromRGB(0xE64E51);
        [_senderBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _senderBtn;
}

//留言
- (void)sendBtnClick {
    [self.commentTextField endEditing:YES];
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([self.commentTextField.text stringByTrimmingCharactersInSet:set].length>0) {
        NSLog(@"没有空格");
        //[self requestReplyData:_currentCommentModel text:self.commentTextField.text];
        [self requestSecondHandId:_secondHandId comment:self.commentTextField.text];
    }
    
}


//点赞
- (void)requestThumbsUp{
    [HomeHttpManager requestSecondHandId:@""
                               commentId:@""
     
                                 success:^(id response) {
                                     
                                 } failure:^(NSError *error, NSString *message) {
                                     
                                 }];
}

//评论
- (void)requestSecondHandId:(NSString *)secondHandId comment:(NSString *)comment{
    @weakify(self);
    [HomeHttpManager requestSecondHandId:secondHandId
                                 comment:comment
     
                                 success:^(id response) {
                                     NSLog(@"response==%@", response);
                                     
                                     @strongify(self);
                                     //操作失败的原因
                                     NSString *information = [response objectForKey:@"information"];
                                     //状态码
                                     NSString *status = [response objectForKey:@"status"];
                                     
                                     if ([status integerValue]==0) {
                                         
                                         [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                     }else{
                                         [AlertViewController alertControllerWithTitle:@"提示" message:information preferredStyle:UIAlertControllerStyleAlert controller:self];
                                     }
                                     [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
                                     
                                 } failure:^(NSError *error, NSString *message) {
                                     
                                 }];
}

@end
