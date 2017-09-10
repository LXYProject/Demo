//
//  MyNeighborController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/7/7.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "NeighborCircleController.h"
#import "NeighborCircleCell.h"
#import "MineHttpManager.h"
#import "NeighborCircleModel.h"
#import "NeighborDetailController.h"
#import "NearByItemModel.h"

@interface NeighborCircleController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

// 发帖记录 的数据相关的
@property (nonatomic,strong)NSMutableArray *topicHisDataSource;//绑定的房屋
@property (nonatomic, strong)NSArray *listArray;

@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic, copy)NSArray *mouthsSection;

@end

@implementation NeighborCircleController
{
    NeighborCircleCell *neighborCircleCell;
    NeighborCircleModel *neighborCircleModel;
    MBProgressHUD *_hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NeighborCircleCell" bundle:nil] forCellReuseIdentifier:@"NeighborCircleCell"];
        NSArray *modelArray = [NeighborCircleModel mj_objectArrayWithKeyValuesArray:[self messageDataarray][@"topicList"]];
    self.listArray = (NSMutableArray *)modelArray;
    
    NSMutableArray  *yearArray = [NSMutableArray arrayWithCapacity:1];
    //取出年份 tableView的section 以年份+月份为分组条件   day为每组内容
    [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NeighborCircleModel *model = obj;
        if (![yearArray containsObject:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
            [yearArray addObject:[self yearAndMonth:[self dateformatter:model.createTime]]];
        }
    }];
    //这里将数组进行排序，防止服务器数据有问题
    NSArray *result = [yearArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj2 compare:obj1]; //降序
    }];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *year = obj;
        NSMutableArray *mothArr = [NSMutableArray arrayWithCapacity:1];
        [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NeighborCircleModel *model = obj;
            if ([year isEqualToString:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
                [mothArr addObject:model];
            }
        }];
        [self.topicHisDataSource addObject:mothArr];
        
    }];

//        [self.topicHisDataSource addObjectsFromArray:self.listArray];
//        [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
//    self.tableView.backgroundColor = RGB(247, 247, 247);
//    [self titleViewWithTitle:@"我的邻里圈" titleColor:[UIColor whiteColor]];
//    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.0001)];
////    self.tableView.tableFooterView = [[UIView alloc]init];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    
////    self.currentPage = 1;
//    [self.tableView setHeaderRefreshBlock:^{
//        self.currentPage = 1;
//        [self requestTopicHis];
//    }];
////    [self.tableView setFooterRefreshBlock:^{
////        self.currentPage++;
////        [self requestTopicHis];
////    }];
//    [self.tableView beginHeaderRefreshing];
    
<<<<<<< HEAD
//    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _hud.labelText = @"正在加载";
=======
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"正在加载";
>>>>>>> 483ee302b738dfd810067b6aefeffceac044f52e

    
}



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
                         @"topicSmallImageList": @[],
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


// 发帖记录
- (void)requestTopicHis{
    @weakify(self);
    [MineHttpManager requestTopicId:@"" success:^(NSArray* response) {
        @strongify(self);
        [self.tableView endRefreshing];
        [_hud hide:YES];
        
        self.listArray = (NSMutableArray *)response;
        
        NSMutableArray  *yearArray = [NSMutableArray arrayWithCapacity:1];
        //取出年份 tableView的section 以年份+月份为分组条件   day为每组内容
        [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NeighborCircleModel *model = obj;
            if (![yearArray containsObject:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
                [yearArray addObject:[self yearAndMonth:[self dateformatter:model.createTime]]];
            }
        }];
        //这里将数组进行排序，防止服务器数据有问题
        NSArray *result = [yearArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj2 compare:obj1]; //降序
        }];
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *year = obj;
            NSMutableArray *mothArr = [NSMutableArray arrayWithCapacity:1];
            [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NeighborCircleModel *model = obj;
                if ([year isEqualToString:[self yearAndMonth:[self dateformatter:model.createTime]]]) {
                    [mothArr addObject:model];
                }
            }];
            [self.topicHisDataSource addObject:mothArr];

            
        }];
        [self.tableView reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        [self.tableView endRefreshing];
        _hud.labelText = message;
        [_hud hide:YES];
    }];
}

- (NSString *)yearAndMonth:(NSDate *)formaterDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:formaterDate];
}


- (NSDate *)dateformatter :(NSString *)str {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formaterDate = [dateFormatter dateFromString:str];
    return formaterDate;
}

- (NSString *)newYearAndMonth:(NSDate *)formaterDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM月yyyy年"];
    return [formatter stringFromDate:formaterDate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//        return 2;
    return self.topicHisDataSource.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicHisDataSource.count>0?[self.topicHisDataSource[section] count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self sectionZeroWithTableView:tableView indexPath:indexPath];
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    
    NeighborCircleCell *cell = (NeighborCircleCell *)[self creatCell:tableView indenty:@"NeighborCircleCell"];
    cell.model = self.topicHisDataSource[indexPath.section][indexPath.row];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 30)];
    
//    if (section ==0){
//        lable.attributedText = [self attrText:@"07月2017年"];
        NeighborCircleModel *model = self.topicHisDataSource[section][0];
        lable.attributedText = [self attrText:[self newYearAndMonth:[self dateformatter:model.createTime]]];
    
//    }
//    else if (section ==1){
//        lable.attributedText = [self attrText:@"06月2017年"];
//    }
//    else{
//        lable.attributedText = nil;
//    }
    
    
    [view addSubview:lable];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [Tools cellRadio:tableView cell:cell indexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [PushManager pushViewControllerWithName:@"NeighborDetailController" animated:YES block:^(NeighborDetailController* viewController) {
        viewController.model = self.topicHisDataSource[indexPath.section][indexPath.row];
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NeighborCircleModel *model = self.topicHisDataSource[indexPath.section][indexPath.row];
    return model.topicSmallImageList.count==0?60:94;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSAttributedString *)attrText:(NSString *)text {
    if (text.length<8) {
        NSLog(@"文字的个数不足，需要添加更多的文字");
        return nil;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]init];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(0, 2)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(2, 1)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    NSAttributedString *attr5 = [[NSAttributedString alloc]initWithString:@" " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(3, 4)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0xE64E51)}];
    NSAttributedString *attr4 = [[NSAttributedString alloc]initWithString:[text substringWithRange:NSMakeRange(7, text.length-7)] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x4E4E4E)}];
    [attr appendAttributedString:attr1];
    [attr appendAttributedString:attr2];
    [attr appendAttributedString:attr5];
    [attr appendAttributedString:attr3];
    [attr appendAttributedString:attr4];
    
    return attr;
}

- (NSArray *)topicHisDataSource {
    if (!_topicHisDataSource) {
        _topicHisDataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _topicHisDataSource;
}
@end
