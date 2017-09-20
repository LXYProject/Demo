//
//  Constant.h
//  weishi
//
//  Created by hongtao dong on 15/6/16.
//  Copyright (c) 2017年 ZT. All rights reserved.
//

#ifndef weishi_Constant_h
#define weishi_Constant_h

//注册保存
#define PhoneNumberKey         @"phoneNumber"
#define DeviceUUIDKey          @"deviceUUID"
#define DeviceModelKey         @"deviceModel"


#define BALANCE @"balance"


#define MR_Http                 @"http://"

#define MR_Https                @"https://"

//#define MR_Host_Test            @"10.168.1.103:8080/attendance-web"
//#define MR_Host_Test            @"10.168.1.118:8080/attendance-web"
//#define MR_Host_Test            @"10.168.1.120:8080/attendance-web"

//#define MR_Host_Test            @"182.92.67.88:8091/attendance-web"

//#define MR_Host_Test  @"192.168.1.109:8080/Service"
#define MR_Host_Test  @"192.168.1.96:8080/ZtscApp/Service"


#define MRRemote(A)             [NSString stringWithFormat:@"%@%@%@", MR_Http, MR_Host_Test, (A)]

//#define MRRemote(A)             [NSString stringWithFormat:@"http://appbi.aicailang.com/app/publicRequest/appAdvertRequestHandler%@",(A)]

//============================广告位服务===========================================

// 首页轮播图
#define A_UrlA                  @"?service=adPhotoService&function=cityAdList"
// 物业轮播图
#define A_UrlB                  @"?service=adPhotoService&function=propertyAdList"
// 去帮忙
#define A_HelpUrl               @"?service=serviceService&function=queryAppeal"
// 找服务//
#define A_FindUrl               @"?service=serviceService&function=searchService"
// 服务或求助类型列 //服务或求助类型列(0-服务,1-求助,2-单位)
#define A_Leixin                @"?service=serviceService&function=serviceOrAppealCategory"
// 上传坐标
#define A_upUserXY              @"?service=adPhotoService&function=upUserXY"
// 上传心跳
#define A_upUserOnline          @"?service=adPhotoService&function=upUserOnline"
// 小区物业电话
#define A_villagePropertyTel    @"?service=adPhotoService&function=villagePropertyTel"
// 查看区域的发布的服务数量
#define A_lookServiceNumByArea  @"?service=adPhotoService&function=lookServiceNumByArea"
// 查看区域的发布的求助数量
#define A_lookAppealNumByArea   @"?service=adPhotoService&function=lookAppealNumByArea"

// 根据类型获取系统字典
#define A_querySystemDict       @"?service=systemDict&function=querySystemDict"


//============================用户接口===========================================
// 注册发送验证码
#define A_registerUrl           @"?service=user&function=getCodeForRegister"
// 注册验证码核对
#define A_registerCheck         @"?service=user&function=checkZCCode"
// 登录发送验证码
#define A_loginUrl              @"?service=user&function=getCodeForLogin"
// 登录验证码核对
#define A_loginCheck            @"?service=user&function=checkLoginCode"
// 密码登录
#define A_phoneNumLogin         @"?service=user&function=phoneNumLogin"
// token登录
#define A_tokenLogin            @"?service=user&function=tokenLogin"
// 修改密码
#define A_updatePassWord        @"?service=user&function=updatePassWord"
// 修改个人信息
#define A_updateUser            @"?service=user&function=updateUser"
// 修改个人头像
#define A_updateHeadImage       @"?service=user&function=updateHeadImage"
// 上传个人图片
#define A_upUserPhoto           @"?service=user&function=upUserPhoto"
// 删除个人图片
#define A_delUserPhoto          @"?service=user&function=delUserPhoto"
// 通过id查询用户信息
#define A_findUserInfoById      @"?service=user&function=findUserInfoById"
// 通过手机号查询用户信息
#define A_findUserInfoByPhone   @"?service=user&function=findUserInfoByPhone"

//============================房屋接口===========================================
// 查看所有与我有关的房屋           
#define A_lookAllHouseWithMe    @"?service=userHouse&function=queryMyHouse"

// 新增绑定房屋
#define A_addBindHouse          @"?service=userHouse&function=addBindHouse"
// 添加房屋关注
#define A_addLikeHouse          @"?service=userHouse&function=addLikeHouse"
// 取消绑定，取消关注
#define A_unHouse               @"?service=userHouse&function=unHouse"


//============================小区接口===========================================
// 查看所有与我有关的小区 
#define A_lookAllVillageWithMe  @"?service=userVillage&function=queryMyVillage"

// 添加小区关注
#define A_addConcernVillage     @"?service=userVillage&function=addConcernVillage"
// 取消小区关注
#define A_unConcernVillage      @"?service=userVillage&function=unConcernVillage"


//============================共通接口===========================================
// 关键字搜索小区
#define A_searchVillagesByKeyWords  @"?service=common&function=searchVillagesByKeyWords"
// 小区id搜索楼
#define A_searchBuildingByVillage   @"?service=common&function=searchBuildingByVillage"
// 根据楼查询房屋表
#define A_searchHouses          @"?service=common&function=searchHouses"


//============================好友接口===========================================
// 添加好友关注
#define A_addFriend             @"?service=friendService&function=addFriend"
// 取消好友关注
#define A_deleteFriend          @"?service=friendService&function=deleteFriend"
// 查看我的好友列表
#define A_myFriends             @"?service=friendService&function=myFriends"
// 根据小区查看附近的人
#define A_lookPepoleByVillage   @"?service=friendService&function=lookPepoleByVillage"
// 查找最近登录的人
#define A_lookRecentLoginUser   @"?service=friendService&function=lookRecentLoginUser"
// 查看用户详细信息
#define A_lookUserAll           @"?service=friendService&function=lookUserAll"



//============================房屋服务===========================================
// 停止出租
#define A_stopRent        @"?service=house&function=stopRent"
// 收藏租房信息
#define A_keepRent        @"?service=house&function=keepRent"
// 租房查询
#define A_queryRent       @"?service=house&function=queryRent"
// 出租
#define A_rent            @"?service=house&function=rent"
// 租赁标签字典
#define A_rentTagDic      @"?service=house&function=rentTagDic"
// 基本信息字典
#define A_basicInfoDic    @"?service=house&function=basicInfoDic"
// 小区信息
#define A_villageInfo     @"?service=house&function=villageInfo"
// 房屋信息
#define A_houseInfo       @"?service=house&function=houseInfo"


//============================生活缴费服务===========================================
// 根据房屋及缴费类型获取公司
#define A_companyList     @"?service=lifeCostService&function=companyList"
// 获取缴费基本信息
#define A_costBaseList    @"?service=lifeCostService&function=costBaseList"
// 绑定缴费账号
#define A_bindAccount     @"?service=lifeCostService&function=bindAccount"
// 缴费
#define A_costing         @"?service=lifeCostService&function=costing"
// 获取缴费记录
#define A_costRecordList   @"?service=lifeCostService&function=costRecordList"
// 修改缴费账号
#define A_updateCostAccount  @"?service=lifeCostService&function=updateCostAccount"
// 删除缴费账号
#define A_delCostAccount     @"?service=lifeCostService&function=delCostAccount"


//============================物业接口===========================================
// 服务类型列表
#define A_serviceList         @"?service=propertyService&function=serviceList"
// 报事类型列表
#define A_affairCategoryList   @"?service=propertyService&function=affairCategoryList"
// 公告列表
#define A_bulletinList        @"?service=propertyService&function=bulletinList"
// 便民服务
#define A_convenience         @"?service=propertyService&function=convenience"

// 发送上门服务信息
#define A_visitService          @"?service=propertyService&function=visitService"
// 公共报事
#define A_publicAffair          @"?service=propertyService&function=publicAffair"
// 表扬
#define A_praise                @"?service=propertyService&function=praise"
// 投诉
#define A_complain              @"?service=propertyService&function=complain"
// 查看上门服务信息
#define A_lookvisitService      @"?service=propertyService&function=queryVisitService"
// 查看报事信息
#define A_publicAffairList      @"?service=propertyService&function=publicAffairList"
// 查看表扬信息
#define A_praiseList            @"?service=propertyService&function=praiseList"
// 查看投诉信息
#define A_complainList          @"?service=propertyService&function=complainList"

// 查看待缴费账单
#define A_billList              @"?service=propertyService&function=billList"
// 缴纳物业费
#define A_pay                   @"?service=propertyService&function=pay"
// 查询缴费记录
#define A_paymentList           @"?service=propertyService&function=paymentList"
// 查看小区全景
#define A_lookVillagePanorama   @"?service=propertyService&function=lookVillagePanorama"
// 上报小区全景
#define A_sendVillagePanorama   @"?service=propertyService&function=sendVillagePanorama"
// 小区设施类型列表
#define A_villageFeatureTypeList @"?service=propertyService&function=villageFeatureTypeList" 
// 获取物业费缴纳参数
#define A_getCostParam          @"?service=propertyService&function=getCostParam"
// 缴纳物业费成功后回执
#define A_costSuccess           @"?service=propertyService&function=costSuccess"



//============================二手物品===========================================
// 停止发布
#define A_stopPublish           @"?service=secondHand&function=stopPublish"
// 删除回复
#define A_seconddeleteReply     @"?service=secondHand&function=deleteReply"
// 对评论点赞
#define A_commentThumbsUp       @"?service=secondHand&function=commentThumbsUp"
// 收藏
#define A_keep                  @"?service=secondHand&function=keep"
// 评论
#define A_secondReply           @"?service=secondHand&function=reply"
// 对评论回复
#define A_replyComment          @"?service=secondHand&function=replyComment"
// 查询
#define A_query                 @"?service=secondHand&function=query"
// 发布
#define A_publish               @"?service=secondHand&function=publish"
// 分类
#define A_catalog               @"?service=secondHand&function=catalog"



//============================帖子服务===========================================
// 加载帖子//?service=topic&function=loadTopic
#define A_loadTopic            @"?service=topic&function=queryTopic"
// 发帖记录
#define A_topicHis             @"?service=topic&function=myTopic"
// 删除帖子
#define A_deleteTopic          @"?service=topic&function=deleteTopic"
// 删除回复
#define A_deleteReply          @"?service=topic&function=deleteReply"
// 点赞
#define A_thumbsUp             @"?service=topic&function=thumbsUp"
// 回复
#define A_reply                @"?service=topic&function=reply"
// 发布
#define A_newTopic             @"?service=topic&function=newTopic"



//============================服务接口===========================================
// 发布服务
#define A_releaseService        @"?service=serviceService&function=releaseService"
// 发布求助
#define A_releaseAppeal         @"?service=serviceService&function=releaseAppeal"
// 搜索发布的服务
#define A_searchService         @"?service=serviceService&function=searchService"
// 搜索发布的求助
#define A_searchAppeal          @"?service=serviceService&function=searchAppeal"
// 修改发布的服务状态
#define A_cancelReleaseService  @"?service=serviceService&function=cancelReleaseService"
// 修改求助状态
#define A_cancelReleaseAppeal   @"?service=serviceService&function=cancelReleaseAppeal"
// 接受服务订单或拒绝
#define A_dealServiceOrderForm  @"?service=serviceService&function=dealServiceOrderForm"
// 接受求助订单或拒绝
#define A_dealAppealOrderForm   @"?service=serviceService&function=dealAppealOrderForm"
// 购买服务
#define A_buyServiceOrderForm   @"?service=serviceService&function=buyServiceOrderForm"
// 购买求助
#define A_buyAppealOrderForm    @"?service=serviceService&function=buyAppealOrderForm"
// 对方接单前撤销购买服务
#define A_buyServiceCancelOrderAgo  @"?service=serviceService&function=buyServiceCancelOrderAgo"
// 对方接单前撤销下单的求助
#define A_appealCancelOrderAgo  @"?service=serviceService&function=appealCancelOrderAgo"



//============================订单接口===========================================
// 订单处理
#define A_orderDeal             @"?service=orderService&function=orderDeal"
// 原因列表
#define A_reasonList            @"?service=orderService&function=reasonList"
// 订单应答
#define A_orderService          @"?service=orderService&function=order"
// 订单完成后删除我的订单
#define A_deleteMyorder         @"?service=orderService&function=deleteMyorder"



//============================求助订单服务===========================================
// 求助类订单处理
#define A_appealOrderDeal       @"?service=appealOrderService&function=appealOrderDeal"
// 求助订单应答
#define A_order                 @"?service=appealOrderService&function=order"


//============================用户订单service===========================================
// 查看我出售的服务订单
#define A_lookSaleOrderForm     @"?service=userOrderForm&function=queryServiveOrderBySaler"
// 查看我购买的服务订单
#define A_lookBuyOrderForm      @"?service=userOrderForm&function=queryServiveOrderByBuyer"
// 查看我帮助的订单
#define A_lookHelpOrderForm     @"?service=userOrderForm&function=queryAppealOrderByHelper"
// 查看我求助的订单
#define A_lookMyAppealOrderForm @"?service=userOrderForm&function=queryAppealOrderByAppealer"


//============================用户消息接口===========================================
//获取系统消息
#define A_getUnreadMessage      @"?service=userMessageService&function=getUnreadMessage"

#endif
