//
//  SecondHandViewController.m
//  ZTServiceProject
//
//  Created by ZT on 2017/6/15.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "SecondHandViewController.h"
#import "SearchHeadCell.h"
#import "ItemBtnCell.h"
#import "ImageCell.h"
#import "secondHandCell.h"
#import "MessageCell.h"
#import "NearByItemModel.h"
#import "HomeHttpManager.h"
#import "ItemMoreViewController.h"
#import "SecondMessageCell.h"   
#import "CommentPhotoCell.h"
#import "SecondAddressCell.h"
#import "SecondHandModel.h"
#import "SecondDetailsController.h"

@interface SecondHandViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *itemDataSourceArray;
//collectView 的数据相关的
@property (nonatomic,strong)NSArray *secondCellDataSource;
@property (nonatomic,assign)NSInteger secondCellCurrentPage;

@end

@implementation SecondHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self titleViewWithTitle:@"二手物品" titleColor:[UIColor whiteColor]];
    [self rightItemWithNormalName:@"" title:@"发布" titleColor:[UIColor whiteColor] selector:@selector(rightBarClick) target:self];

    [self.tableView registerNib:[UINib nibWithNibName:@"SecondMessageCell" bundle:nil] forCellReuseIdentifier:@"SecondMessageCell"];
    self.secondCellCurrentPage = 1;

    [self requestDataSecondCellData];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
//
    
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    //创建数据源
    NSDictionary *dict = @{
                           @"secondHandList" : @[
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[@{
                                                             @"commentType":@"",
                                                             @"userId":@"",
                                                             @"userName":@"LXY",
                                                             @"userImageUrl":@"",
                                                             @"targetUserId":@"1",
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
                                                             @"targetUserId":@"1",
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
                                                             @"targetUserId":@"1",
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
                                                             @"targetUserId":@"2",
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
                                                             @"targetUserId":@"2",
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
                                                             @"targetUserId":@"2",
                                                             @"targetUserName":@"sda 阿萨德",
                                                             @"targetUserImageUrl":@"",
                                                             @"comment":@"按时打卡机安徽省电话卡进度款哈空间的黄金卡回答还是看见好看手机壳",
                                                             @"commentTime":@"2010-04-09 20:23:21"
                                                             }
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       },
                                   @{
                                       
                                       @"address" : @"",
                                       @"classId" : @"SCB014",
                                       @"commentCount" : @"1",
                                       @"commentList" :
                                           @[
                                               @{
                                                   @"comment" : @"好手机",
                                                   @"commentCount" : @"0",
                                                   @"commentId" : @"sr2017051015141",
                                                   @"commentTime" : @"2017-05-10 15:14:14",
                                                   @"isLiked" : @"0",
                                                   @"likeCount" :@"0",
                                                   @"subCommentList" :
                                                       @[
                                                           ],
                                                   @"userId" : @"1890918872220170322150921",
                                                   @"userImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                                   @"userName" : @"王磊",
                                                   }
                                               ],
                                       @"createTime" : @"2017-05-10 15:13:55",
                                       @"delTime" : @"",
                                       @"delivery" : @"1",
                                       @"keepList" :
                                           @[
                                               ],
                                       @"newOrOld" : @"0",
                                       @"onwerName" : @"王磊",
                                       @"oriPrice" : @"0",
                                       @"ownerHuanxinId" :@"201705231745429",
                                       @"ownerId" : @"1890918872220170322150921",
                                       @"ownerImageUrl" : @"http://192.168.1.96:8080/ZtscApp/file/headImage/1890918872220170322150921-20170608125616.png",
                                       @"postStatus" : @"1",
                                       @"secPrice" : @"1288",
                                       @"secondHandContent" : @"99新红米手机，只要998，需要的亲快快联系我哦",
                                       @"secondHandId": @"s20170510151355",
                                       @"secondHandNormalImageList" :
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   
                                                   },
                                               
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   
                                                   },
                                               
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   
                                                   }
                                               ],
                                       
                                       @"secondHandSmallImageList":
                                           @[
                                               @{
                                                   
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191484&di=825a258a6ea411fa06b271bc5fe8e22b&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1210%2F23%2Fc1%2F14589948_1350977796661.jpg"
                                                   },
                                               
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=0e38b9e0a509fb1c3332de6df992e08e&imgtype=0&src=http%3A%2F%2Fpic28.nipic.com%2F20130408%2F668573_161129668175_2.jpg"
                                                   },
                                               @{
                                                   @"url":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498377191483&di=02b02a29c17f73a2c2d9c4102c9a881f&imgtype=0&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0619%2Fxin%2F02%2F07.jpg"
                                                   }
                                               ],
                                       @"secondHandTitle" : @"红米手机出手啦",
                                       @"x" :@" 1",
                                       @"y" : @"1",
                                       @"zoneId" : @"",
                                       @"zoneName" : @"",
                                       }
                                   ]
                           };
    
//        NSArray *modelArray = [SecondHandModel mj_objectArrayWithKeyValuesArray:dict[@"secondHandList"]];
//        self.secondCellDataSource = modelArray;
//        [self.tableView reloadData];
    

}


- (void)rightBarClick
{
    [PushManager pushViewControllerWithName:@"ReleaseViewController" animated:YES block:nil];
}


//请求collectView的数据
- (void)requestDataSecondCellData {
    @weakify(self);
    [HomeHttpManager requestQueryType:2
                         secondInfoId:@""
                             keywords:@""
                              classId:@""
                                resId:@""
                               cityId:@""
                           districtId:@""
                             minPrice:@""
                             maxPrice:@""
                             newOrOld:@""
                             delivery:@"1"
                                 sort:@"0"
                              pageNum:self.secondCellCurrentPage
                              success:^(id response) {
                                  @strongify(self);
                                  self.secondCellDataSource = response;
                                  [self.tableView reloadData];
                              } failure:^(NSError *error, NSString *message) {
                              }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0) {
        return 2;
    }else if(section ==1){
        return 1;
    }else if(section ==2){
        return 1;
    }
    else{
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3+self.secondCellDataSource.count;
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
    else {
        return [self sectionThirdrdTableView:tableView indexPath:indexPath];
    }
}

//第0组
- (UITableViewCell *)sectionZeroWithTableView:(UITableView *)tableView
                                    indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchHeadCell *cell = (SearchHeadCell *)[self creatCell:tableView indenty:@"SearchHeadCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        ItemBtnCell *cell = (ItemBtnCell *)[self creatCell:tableView indenty:@"ItemBtnCell"];
        @weakify(self);
        cell.btnClickBlock = ^(NSInteger value) {
            @strongify(self);
            
            
            if ([self.itemDataSourceArray[value][@"vcName"] isEqualToString:@"MoreClassificationController"]){
                [PushManager pushViewControllerWithName:@"MoreClassificationController" animated:YES block:nil];
            }else{
                [PushManager pushViewControllerWithName:self.itemDataSourceArray[value][@"vcName"] animated:YES block:^(ItemMoreViewController* viewController) {
                    
                    viewController.itemTitle = self.itemDataSourceArray[value][@"title"];
                }];
            }
        };
        cell.titleAndImageDictArray = self.itemDataSourceArray;
        return cell;
    }
}

//第1组
- (UITableViewCell *)sectionOneWithTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[self creatCell:tableView indenty:@"ImageCell"];
    return cell;
}

//第2组
- (UITableViewCell *)sectionTwoTableView:(UITableView *)tableView
                                 indexPath:(NSIndexPath *)indexPath {
    secondHandCell *cell = (secondHandCell *)[self creatCell:tableView indenty:@"secondHandCell"];
    cell.model = self.secondCellDataSource;
    return cell;
}

//第3组
- (UITableViewCell *)sectionThirdrdTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        SecondMessageCell *cell = (SecondMessageCell *)[self creatCell:tableView indenty:@"SecondMessageCell"];
        cell.model = self.secondCellDataSource[indexPath.section -3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row ==1){
        SecondHandModel *model =  self.secondCellDataSource[indexPath.section -3];
        CommentPhotoCell *cell = (CommentPhotoCell *)[self creatCell:tableView indenty:@"CommentPhotoCell"];
        [cell smallImgs:model.secondHandSmallImageList normalImgs:model.secondHandNormalImageList];
        cell.collectionView.userInteractionEnabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        SecondAddressCell *cell = (SecondAddressCell *)[self creatCell:tableView indenty:@"SecondAddressCell"];
        cell.model = self.secondCellDataSource[indexPath.section -3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

    if (indexPath.section>2) {
       
        [PushManager pushViewControllerWithName:@"SecondDetailsController" animated:YES block:^(SecondDetailsController* viewController) {
            viewController.model = self.secondCellDataSource[indexPath.section-3];

            //viewController.secondHandId = [self.secondCellDataSource[indexPath.section] secondHandId];
        }];
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if(indexPath.row ==0){
            return 45;
        }
        ItemBtnCell *cell = (ItemBtnCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }
    else if (indexPath.section ==1) {
        return 150;
    }
    else if (indexPath.section ==2) {
        return 175;
    }
    else {
        if (indexPath.row==0) {
            return [tableView fd_heightForCellWithIdentifier:@"SecondMessageCell" configuration:^(SecondMessageCell* cell) {
                cell.model = self.secondCellDataSource[indexPath.section - 3];
            }];
        }
        else if (indexPath.row == 1){
            NSArray *smallImgs = [self.secondCellDataSource[indexPath.section - 3] secondHandSmallImageList];
            if (smallImgs.count>0) {
                NSInteger count = smallImgs.count%3>0?((smallImgs.count/3)+1):smallImgs.count/3;
                return count *100+(count-1)*15;
            }
            return 0;

        }
        return 44;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSArray *)itemDataSourceArray {
    if(!_itemDataSourceArray) {
        _itemDataSourceArray = @[
                                 @{@"title":@"数码"
                                   ,@"icon":@"home_eswp_smcp"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"服饰"
                                   ,@"icon":@"home_eswp_fzxm"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"出行"
                                   ,@"icon":@"home_eswp_jtgj"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"母婴"
                                   ,@"icon":@"home_eswp_myyp"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"家具"
                                   ,@"icon":@"home_eswp_jj"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"影音"
                                   ,@"icon":@"home_eswp_tsyx"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"收藏"
                                   ,@"icon":@"home_eswp_yssc"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"网游"
                                   ,@"icon":@"home_eswp_wyxn"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"美容"
                                   ,@"icon":@"home_eswp_mrbj"
                                   ,@"vcName":@"ItemMoreViewController"},
                                 @{@"title":@"更多"
                                   ,@"icon":@"home_eswp_gd"
                                   ,@"vcName":@"MoreClassificationController"},

                                 ];
    }
    return _itemDataSourceArray;
}



@end
