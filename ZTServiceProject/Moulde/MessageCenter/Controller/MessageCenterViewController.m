//
//  MessageCenterViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/4.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCell.h"
#import "NearByItemModel.h"
#import "MesssgeHttpManager.h"  
#import "MessageModel.h"
#import "CommentPhotoCell.h"
#import "CommentBottomCell.h"
#import "HeaderCell.h"
#import "CommentInfoCell.h"

@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

//加载帖子数据相关
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic,copy)NSString *replyContent;

@property (nonatomic,copy)NSString *selectTopicId;


@end

@implementation MessageCenterViewController
{
    BOOL ReplyComment;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;

    
    [self rightBarButtomItemWithNormalName:@"add_btn" highName:@"add_btn" selector:@selector(rightBarClick) target:self];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:@"HeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentBottomCell" bundle:nil] forCellReuseIdentifier:@"CommentBottomCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentInfoCell" bundle:nil] forCellReuseIdentifier:@"CommentInfoCell"];
//    NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:[self messageDataarray][@"topicList"]];
//    [self.dataSource addObjectsFromArray:modelArray];
//    [self.tableView reloadData];
    
    [self.tableView setHeaderRefreshBlock:^{
        self.currentPage = 1;
        [self requestMessageData];
    }];
    [self.tableView setFooterRefreshBlock:^{
        self.currentPage++;
        [self requestMessageData];
    }];
    [self.tableView beginHeaderRefreshing];
   
    
    
    
//    if (ReplyComment==YES) {
//        _commentType = 0;//话题评论
//        [self requestReplyData];
//    }else{
//        _commentType = 1;//回复评论
//        [self requestReplyData];
//    }
    

    
//    [self requestMessageData];
}
- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    [PushManager pushViewControllerWithName:@"PostMessageController" animated:YES block:nil];

}

//请求帖子
- (void)requestMessageData {
    @weakify(self);
    [MesssgeHttpManager requestFilter:@"" topicId:_topicId pos:@"" page:self.currentPage success:^(NSArray *response) {
        @strongify(self);
        [self.tableView endRefreshing];
        if (self.currentPage==1){
            [self.dataSource removeAllObjects];
        }
        [self.dataSource addObjectsFromArray:response];
        if (response.count<10) {
            [self.tableView endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];

    }];
}

//回复
- (void)requestReplyData
{
    [MesssgeHttpManager requestTopicId:self.selectTopicId comment:@"" commentType:_commentType targetUserId:@"" success:^(id response) {
        
    } failure:^(NSError *error, NSString *message) {
        
    }];
}
- (void)setTopicId:(NSString *)topicId
{
    _topicId = topicId;
    [self requestMessageData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3+[[self.dataSource[section] commentList] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        if (self.dataSource.count==10) {
            _topicId = cell.model.topicId;
        }
        cell.fd_isTemplateLayoutCell = YES;
        return cell;
    }
    else if (indexPath.row == 1) {
        CommentPhotoCell *cell = (CommentPhotoCell *)[self creatCell:tableView indenty:@"CommentPhotoCell"];
        cell.model = self.dataSource[indexPath.section];
        return cell;
    }
    else  if (indexPath.row ==2){
        CommentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentBottomCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        cell.fd_isTemplateLayoutCell = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //OK
        @weakify(self);
        cell.commentSuccessBlock = ^{
            @strongify(self);
            [self requestMessageData];
        };
        return cell;
    }
    else {
        CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
        NSArray *commentList = [self.dataSource[indexPath.section] commentList];
        cell.model = commentList[indexPath.row - 3];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
       return  [tableView fd_heightForCellWithIdentifier:@"HeaderCell" cacheByIndexPath:indexPath configuration:^(HeaderCell* cell) {
            cell.model = self.dataSource[indexPath.section];
        }];
    }
    else if (indexPath.row ==1){
        NSArray *smallImgs = [self.dataSource[indexPath.section] topicSmallImageList];
        if (smallImgs.count>0) {
            NSInteger count = smallImgs.count%3>0?((smallImgs.count/3)+1):smallImgs.count/3;
            return count *100+(count-1)*15;
        }
        return 0;
    }
    else if (indexPath.row ==2){
        return  [tableView fd_heightForCellWithIdentifier:@"CommentBottomCell" cacheByIndexPath:indexPath configuration:^(CommentBottomCell* cell) {
            cell.model = self.dataSource[indexPath.section];
        }];
    }
    else{
        return  [tableView fd_heightForCellWithIdentifier:@"CommentInfoCell" cacheByIndexPath:indexPath configuration:^(CommentInfoCell* cell) {
            NSArray *commentList = [self.dataSource[indexPath.section] commentList];
            cell.model = commentList[indexPath.row - 3];
        }];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)creatCell:(UITableView *)tableView indenty:(NSString *)indenty {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indenty];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:indenty owner:nil options:nil] lastObject];
    }
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.selectTopicId = [self.dataSource[indexPath.row] topicId];
//}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
