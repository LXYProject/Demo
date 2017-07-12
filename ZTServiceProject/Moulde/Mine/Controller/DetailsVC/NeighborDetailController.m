//
//  NeighborDetailController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/11.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborDetailController.h"
#import "HeaderCell.h"
#import "CommentPhotoCell.h"
#import "CommentBottomCell.h"
#import "CommentInfoCell.h"
#import "MessageModel.h"


@interface NeighborDetailController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//加载帖子数据相关
@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation NeighborDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"帖子详情" titleColor:[UIColor whiteColor]];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        if (self.dataSource.count==10) {
            //_topicId = cell.model.topicId;
        }
        cell.fd_isTemplateLayoutCell = YES;
        return cell;
    }
    else if (indexPath.row == 1) {
        CommentPhotoCell *cell = (CommentPhotoCell *)[self creatCell:tableView indenty:@"CommentPhotoCell"];
        //[cell smallImgs:[self.dataSource[indexPath.section] topicSmallImageList] normalImgs:[self.dataSource[indexPath.section] topicNormalImageList]];
        return cell;
    }
    else  if (indexPath.row ==2){
        CommentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentBottomCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        cell.fd_isTemplateLayoutCell = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //OK
        @weakify(self);
        cell.commentSuccessBlock = ^(MessageModel * obj) {
            @strongify(self);
            [self.dataSource replaceObjectAtIndex:indexPath.section withObject:obj];
            NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        };
        return cell;
    }
    else {
        CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
        //NSArray *commentList = [self.dataSource[indexPath.section] commentList];
        //cell.model = commentList[indexPath.row - 3];
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

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end
