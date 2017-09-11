//
//  NeighborDetailController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborDetailController.h"
#import "MessageCell.h"
#import "NearByItemModel.h"
#import "MesssgeHttpManager.h"
#import "MessageModel.h"
#import "CommentPhotoCell.h"
#import "NeighborDetailCell.h"
#import "HeaderCell.h"
#import "CommentInfoCell.h"
#import "NeighborCircleModel.h"
#import "CommentTextCell.h"

@interface NeighborDetailController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)UITextField *commentTextField;

//加载帖子数据相关
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,copy)NSString *selectTopicId;
@property (nonatomic,copy)NSString *currentTopicId;
@property (nonatomic,strong)MessageModel *currentModel;
@property (nonatomic,strong)NSIndexPath *currentIndexPath;
@property (nonatomic,strong)NSArray *currentTopticDataArray;


@end

@implementation NeighborDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = RGB(247, 247, 247);
    [self titleViewWithTitle:@"帖子详情" titleColor:[UIColor whiteColor]];

    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:@"HeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NeighborDetailCell" bundle:nil] forCellReuseIdentifier:@"NeighborDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentInfoCell" bundle:nil] forCellReuseIdentifier:@"CommentInfoCell"];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3+self.model.commentList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSInteger currentSectionCommentListCount = [self.dataSource[indexPath.section] commentList].count;
    NSInteger currentSectionCommentListCount = self.model.commentList.count;

    if (indexPath.row ==0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.neighborCircleModel = self.model;
        cell.fd_isTemplateLayoutCell = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1) {
        CommentPhotoCell *cell = (CommentPhotoCell *)[self creatCell:tableView indenty:@"CommentPhotoCell"];
        [cell smallImgs:self.model.topicSmallImageList normalImgs:self.model.topicNormalImageList];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else  if (indexPath.row == 2){
        NeighborDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeighborDetailCell" forIndexPath:indexPath];
        cell.model = self.model;
        cell.fd_isTemplateLayoutCell = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //OK
//        @weakify(self);
//        cell.commentSuccessBlock = ^(MessageModel * obj) {
//            @strongify(self);
//            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:obj];
//            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
//            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
//        };
        return cell;
    }
    else {
        if ((currentSectionCommentListCount+3>indexPath.row)&&currentSectionCommentListCount>0) {
            //NSArray *commentList = [self.dataSource[indexPath.section] commentList];
            NSArray *commentList = self.model.commentList;
            CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
            cell.model = commentList[indexPath.row - 3];
            return cell;
        }
        else {
            CommentTextCell *textCell  = (CommentTextCell *)[self creatCell:tableView indenty:@"CommentTextCell"];
            textCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return textCell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return  [tableView fd_heightForCellWithIdentifier:@"HeaderCell" cacheByIndexPath:indexPath configuration:^(HeaderCell* cell) {
            cell.neighborCircleModel = self.model;
        }];
    }
    else if (indexPath.row ==1){
        NSArray *smallImgs = self.model.topicSmallImageList;
        if (smallImgs.count>0) {
            NSInteger count = smallImgs.count%3>0?((smallImgs.count/3)+1):smallImgs.count/3;
            return count *((ScreenWidth - 30 )- 2*3)/3+(count-1)*15;
        }
        return 0;
    }
    else if (indexPath.row == 2){
        return  [tableView fd_heightForCellWithIdentifier:@"NeighborDetailCell" cacheByIndexPath:indexPath configuration:^(NeighborDetailCell* cell) {
            cell.model = self.model;
        }];
    }
    else{
        NSInteger currentSectionCommentListCount = self.model.commentList.count;
        if ((currentSectionCommentListCount+3>indexPath.row)&&currentSectionCommentListCount>0) {
            return  [tableView fd_heightForCellWithIdentifier:@"CommentInfoCell" cacheByIndexPath:indexPath configuration:^(CommentInfoCell* cell) {
                NSArray *commentList = self.model.commentList;
                cell.model = commentList[indexPath.row - 3];
            }];
        }
        return 49;
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

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
