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
#import "CommentUserModel.h"
#import "CommentTextCell.h"
@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *keyBoardToolsView;
@property (nonatomic,strong)UIButton *senderBtn;
@property (weak, nonatomic) IBOutlet BaseTableView *tableView;
@property (nonatomic,strong)UITextField *commentTextField;

//加载帖子数据相关
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,copy)NSString *selectTopicId;
@property (nonatomic,copy)NSString *currentTopicId;


@end

@implementation MessageCenterViewController
{
    BOOL ReplyComment;
    MBProgressHUD *_hud;
    NSString *_currentTargetUserId;
    BOOL _isShowKeyBoard;
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
    self.currentPage = 1;
    [self rightBarButtomItemWithNormalName:@"add_btn"
                                  highName:@"add_btn"
                                  selector:@selector(rightBarClick)
                                    target:self];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeaderCell" bundle:nil] forCellReuseIdentifier:@"HeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentBottomCell" bundle:nil] forCellReuseIdentifier:@"CommentBottomCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentInfoCell" bundle:nil] forCellReuseIdentifier:@"CommentInfoCell"];
    NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:[self messageDataarray][@"topicList"]];
    [self.dataSource addObjectsFromArray:modelArray];
    [self.tableView reloadData];
    
//    [self.tableView setHeaderRefreshBlock:^{
//        self.currentTopicId = @"";
//        [self requestMessageData:self.currentTopicId];
//    }];
//    [self.tableView setFooterRefreshBlock:^{
//        if (self.dataSource.count>0&&[[self.dataSource lastObject] topicId])
//            self.currentTopicId = [[self.dataSource lastObject] topicId];
//        [self requestMessageData:self.currentTopicId];
//    }];
//    [self.tableView beginHeaderRefreshing];
//    
//    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _hud.label.text = @"正在加载";
}

- (void)commentTableViewTouchInSide{
    [self.view endEditing:YES] ;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (![self.view.subviews containsObject:self.keyBoardToolsView]) {
        [self.view addSubview:self.keyBoardToolsView];
    }
}

- (void)keyboardWillShow:(NSNotification *)noti {
    // 获取通知的信息字典
    NSDictionary *userInfo = [noti userInfo];
    _isShowKeyBoard = YES;
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
        self.keyBoardToolsView.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height-64);
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)noti {
    _isShowKeyBoard = NO;
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


//    NSArray *modelArray = [MessageModel mj_objectArrayWithKeyValuesArray:[self messageDataarray][@"topicList"]];
//    [self.dataSource addObjectsFromArray:modelArray];
//    [self.tableView reloadData];

- (NSDictionary *)messageDataarray {
    return @{
             
             @"topicList": @[
                     @{
                         @"topicNormalImageList": @[@{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                        },
                                                    
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                        },
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                        },@{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                        },@{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                        }],
                         @"topicSmallImageList": @[@{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                       },
                                                   
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                       },
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                       },@{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                       },@{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                       }],
                         @"topicId": @"t20170622163932",
                         @"topicTitle": @"我想要租房子\n我能接受的租金价格为:1577元至8968元/月\n我想要的户型为:3室0厅0卫\n我想要我的房子门口朝向:无所谓了\n我想合租\n我可以接受的房屋来源为：房东\n另外我想说的是：一诺孙女\n标签要求：有天然气, 三人以下合租, 生活便利",
                         @"createTime": @"2017-06-22 16:39:32",
                         @"topicStatus": @1,
                         @"likeList": @[],
                         @"zoneId": @"1",
                         @"ownerId": @"005600",
                         @"commentList": @[@{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"王珊",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"阿斯兰的加拉空间的",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               },
                                           @{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"王珊",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"卢达克里斯就断开连接",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               },
                                           @{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"王珊",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"阿来得及啊快来升级的垃圾死了的空间阿拉斯加的脸孔甲氨蝶呤数据库拉斯建档立卡时间到了就拉上看到家里卡建档立卡数据来看",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               },
                                           @{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"爱迪生珊",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"阿萨德安达市多",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               },
                                           @{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"阿萨德",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"奥术大师多卡拉斯科多了；奥凯电缆；卡速度快；卡萨丁；拉开的；卡萨丁；卡；历史地看；拉克丝多了；卡；两点开始；了",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               },
                                           @{
                                               @"commentType":@"",
                                               @"userId":@"",
                                               @"userName":@"LXY",
                                               @"userImageUrl":@"",
                                               @"targetUserId":@"",
                                               @"targetUserName":@"sda 阿萨德",
                                               @"targetUserImageUrl":@"",
                                               @"comment":@"按时打卡机安徽省电话卡进度款哈空间的黄金卡回答还是看见好看手机壳",
                                               @"commentTime":@"2010-04-09 20:23:21"
                                               }
                                           ],
                         @"ownerName": @"其实我很帅",
                         @"ownerImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                         @"zoneName": @"1",
                         @"commentCount": @0,
                         @"delTime": @"",
                         @"y": @0,
                         @"x": @0,
                         @"address": @""
                         },@{
                         @"topicNormalImageList": @[@{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                        },
                                                    
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                        },
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                        }],
                         @"topicSmallImageList": @[@{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                       },
                                                   
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                       },
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                       }],
                         @"topicId": @"t20170622163932",
                         @"topicTitle": @"我想要租房子\n我能接受的租金价格为:1577元至8968元/月\n我想要的户型为:3室0厅0卫\n我想要我的房子门口朝向:无所谓了\n我想合租\n我可以接受的房屋来源为：房东\n另外我想说的是：一诺孙女\n标签要求：有天然气, 三人以下合租, 生活便利",
                         @"createTime": @"2017-06-22 16:39:32",
                         @"topicStatus": @1,
                         @"likeList": @[@{
                                            @"userImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                                            @"likeId": @"tup20170622144423",
                                            @"userId": @"005600",
                                            @"userName": @"其实我很帅"
                                            },@{
                                            @"userImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                                            @"likeId": @"tup20170622144423",
                                            @"userId": @"005600",
                                            @"userName": @"其实我很帅"
                                            },@{
                                            @"userImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                                            @"likeId": @"tup20170622144423",
                                            @"userId": @"005600",
                                            @"userName": @"其实我很帅"
                                            },@{
                                            @"userImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                                            @"likeId": @"tup20170622144423",
                                            @"userId": @"005600",
                                            @"userName": @"其实我很帅"
                                            }],
                         @"zoneId": @"1",
                         @"ownerId": @"005600",
                         @"commentList": @[],
                         @"ownerName": @"其实我很帅",
                         @"ownerImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                         @"zoneName": @"1",
                         @"commentCount": @0,
                         @"delTime": @"",
                         @"y": @0,
                         @"x": @0,
                         @"address": @""
                         },@{
                         @"topicNormalImageList": @[@{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                        },
                                                    
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                        },
                                                    @{
                                                        @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                        }],
                         @"topicSmallImageList": @[@{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                       },
                                                   
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                       },
                                                   @{
                                                       @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                       }],
                         @"topicId": @"t20170622163932",
                         @"topicTitle": @"我想要租房子\n我能接受的租金价格为:1577元至8968元/月\n我想要的户型为:3室0厅0卫\n我想要我的房子门口朝向:无所谓了\n我想合租\n我可以接受的房屋来源为：房东\n另外我想说的是：一诺孙女\n标签要求：有天然气, 三人以下合租, 生活便利",
                         @"createTime": @"2017-06-22 16:39:32",
                         @"topicStatus": @1,
                         @"likeList": @[],
                         @"zoneId": @"1",
                         @"ownerId": @"005600",
                         @"commentList": @[],
                         @"ownerName": @"其实我很帅",
                         @"ownerImageUrl": @"http://192.168.1.96:8080/ZtscApp/file/headImage/005600-20170527151108.png",
                         @"zoneName": @"1",
                         @"commentCount": @0,
                         @"delTime": @"",
                         @"y": @0,
                         @"x": @0,
                         @"address": @""
                         }                          ]
             
             };
}


- (void)rightBarClick
{
    NSLog(@"rightBarClick");
    [PushManager pushViewControllerWithName:@"PostMessageController" animated:YES block:nil];


}

//请求帖子
- (void)requestMessageData:(NSString *)topicid{
    @weakify(self);
    [MesssgeHttpManager requestFilter:@""
                              topicId:topicid
                                  pos:@""
                                 page:self.currentPage
                              success:^(NSArray *response) {
                                  @strongify(self);
                                  [self.tableView endRefreshing];
                                  [_hud hideAnimated:YES];
                                  
                                  if (topicid.length==0){
                                      [self.dataSource removeAllObjects];
                                  }
                                  [self.dataSource addObjectsFromArray:response];
                                  if (response.count==0) {
                                      [self.tableView endRefreshingWithNoMoreData];
                                  }
                                  [self.tableView reloadData];
                              } failure:^(NSError *error, NSString *message) {
                                  [self.tableView endRefreshing];
                                  _hud.label.text = message;
                                  [_hud hideAnimated:YES];
                              }];
}


/**
 回复评论

 @param topicId 评论的帖子
 @param text 内容
 @param targetUserId 指定评论的人
 */
- (void)requestReplyData:(NSString *)topicId
                    text:(NSString *)text
            targetUserId:(NSString *)targetUserId{
    [MesssgeHttpManager requestTopicId:self.selectTopicId
                               comment:text
                           commentType:@"1"
                          targetUserId:targetUserId
                               success:^(id response) {
                                   [self.tableView reloadData];
                               } failure:^(NSError *error, NSString *message) {
                                   
                               }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3+[[self.dataSource[section] commentList] count]+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentSectionCommentListCount = [self.dataSource[indexPath.section] commentList].count;
    if (indexPath.row ==0) {
        HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        cell.fd_isTemplateLayoutCell = YES;
        return cell;
    }
    else if (indexPath.row == 1) {
        CommentPhotoCell *cell = (CommentPhotoCell *)[self creatCell:tableView indenty:@"CommentPhotoCell"];
        [cell smallImgs:[self.dataSource[indexPath.section] topicSmallImageList] normalImgs:[self.dataSource[indexPath.section] topicNormalImageList]];
        return cell;
    }
    else  if (indexPath.row ==2){
        CommentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentBottomCell" forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section];
        cell.fd_isTemplateLayoutCell = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        if ((currentSectionCommentListCount+3>indexPath.row)&&currentSectionCommentListCount>0) {
            NSArray *commentList = [self.dataSource[indexPath.section] commentList];
            CommentInfoCell *cell = (CommentInfoCell *)[self creatCell:tableView indenty:@"CommentInfoCell"];
            cell.model = commentList[indexPath.row - 3];
            return cell;
        }
        else {
            CommentTextCell *textCell  = (CommentTextCell *)[self creatCell:tableView indenty:@"CommentTextCell"];
            return textCell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentSectionCommentListCount = [self.dataSource[indexPath.section] commentList].count;
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
    else {
        if((currentSectionCommentListCount+3>indexPath.row)&&currentSectionCommentListCount>0){
            NSArray *commentList = [self.dataSource[indexPath.section] commentList];
            return [tableView fd_heightForCellWithIdentifier:@"CommentInfoCell" cacheByIndexPath:indexPath configuration:^(CommentInfoCell* cell) {
                
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row>=3) {
        //给帖子进行评论
        [IQKeyboardManager sharedManager].enable = NO;
        self.keyBoardToolsView.hidden = NO;
        self.selectTopicId = [self.dataSource[indexPath.section] topicId];

        if ((3+[[self.dataSource[indexPath.section] commentList] count])>indexPath.row) {
            
            
            NSArray *commentList = [self.dataSource[indexPath.section] commentList];
            CommentUserModel *model = commentList[indexPath.row - 3];
            self.commentTextField.placeholder = [NSString stringWithFormat:@"回复:%@",model.userName];
            
            _currentTargetUserId = model.userId;
        }
        //评论某个人
        else{
            self.selectTopicId = [self.dataSource[indexPath.section] topicId];
            _currentTargetUserId =[self.dataSource[indexPath.section] ownerId];
            self.commentTextField.placeholder = @"评论:";
        }
        if (!_isShowKeyBoard) {
            [self.commentTextField becomeFirstResponder];
        }
        
        
        
        
    }
}




- (void)sendBtnClick {
    [self.commentTextField endEditing:YES];
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    if ([self.commentTextField.text stringByTrimmingCharactersInSet:set].length>0) {
        NSLog(@"没有空格");
        [self requestReplyData:self.selectTopicId text:self.commentTextField.text targetUserId:_currentTargetUserId];
    }
    
}




- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
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

- (UIView *)keyBoardToolsView {
    if (!_keyBoardToolsView) {
        _keyBoardToolsView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height, ScreenWidth, 44)];
        _keyBoardToolsView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_keyBoardToolsView addSubview:self.commentTextField];
        [_keyBoardToolsView addSubview:self.senderBtn];
        _keyBoardToolsView.hidden = YES;
    }
    return _keyBoardToolsView;
}
- (UIButton *)senderBtn {
    if(!_senderBtn) {
        _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _senderBtn.layer.masksToBounds = YES;
        _senderBtn.layer.cornerRadius = 3;
        _senderBtn.frame = CGRectMake(ScreenWidth - 60, 7, 50, 30);
        [_senderBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _senderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _senderBtn.backgroundColor = UIColorFromRGB(0xE64E51);
        [_senderBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _senderBtn;
}
@end
