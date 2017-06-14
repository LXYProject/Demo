//
//  Constant.h
//  weishi
//
//  Created by hongtao dong on 15/6/16.
//  Copyright (c) 2015年 信帧. All rights reserved.
//

#ifndef weishi_Constant_h
#define weishi_Constant_h


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
#define A_HelpUrl               @"?service=serviceService&function=searchAppeal"
// 找服务
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
#define A_lookAllHouseWithMe    @"?service=userHouse&function=lookAllHouseWithMe"
// 新增绑定房屋
#define A_addBindHouse          @"?service=userHouse&function=addBindHouse"
// 添加房屋关注
#define A_addLikeHouse          @"?service=userHouse&function=addLikeHouse"
// 取消绑定，取消关注
#define A_unHouse               @"?service=userHouse&function=unHouse"


//============================二手物品===========================================
// 查询
#define A_query                 @"?service=secondHand&function=query"


//============================房屋服务===========================================
// 租房查询
#define A_queryRent                 @"?service=house&function=queryRent"























// 发送验证码
#define A_getcode                       @"services/common/sendCode"
// 登录
#define A_login                         @"services/user/phoneLogin"
// 忘记密码
#define A_forgotPasswd                  @"services/user/forgotPasswd"
// 查询部门接口
#define A_allDept                       @"services/dept/allDept"
// 修改密码
#define A_changeUserPassword            @"UserAdministration/user/changeUserPassword"

// 更新ClientID
#define A_ClientId                      @"UsersManageController/user/updateClientId"

// 查询当天打卡的所有记录
#define A_details                     @"services/attendance/dianji"

// •	查询用户个人信息
#define A_getUser                    @"UserAdministration/user/getUser"

// •	查询所有用户
#define A_getdepartment                    @"UserAdministration/department/getdepartment"

// 用户提交意见
#define A_opinion                        @"UserAdministration/Opinion/setOpinion"


// 外勤人员统计
#define A_attendanceOutStatistics        @"services/attendance/attendanceOutStatistics"


// 用户修改自己的头像
#define A_modifyHeadImg        @"UserAdministration/department/setuserportrait"

// 查询通知最后下班人
#define A_findRemindHomeMsgById       @"services/msgManager/findRemindHomeMsgById"

// Hr推送消息
#define A_slectWebMsgById      @"services/msgManager/selectWebMsgById"

// 查询公司通知
#define A_findCompanyMsgById      @"services/msgManager/findCompanyMsgById"

// 查询消息列表
#define A_findPersonMsgByPage      @"services/msgManager/findPersonMsgByPage"

// 获取验证码
#define A_getCodeTwo                  @"services/user/getCode"

// 根据手机号和验证码登录
#define A_getloginuser                @"services/user/getloginuser"

// 移动端用户token验证
#define A_loginUserANDtoken           @"services/user/loginUserANDtoken"


// 加班申请填写
#define A_addApplyfor           @"services/UserWorkOvertimeApplyfor/addApplyfor"
// 修改手机发送验证码
#define A_updatePhoneSendCode           @"services/user/updatePhoneSendCode"

// 修改手机
#define A_updatePhone          @"services/user/updatePhone"
// 返回指定用户考勤打卡次数
#define A_workOvertimePunchCardCount           @"services/workOvertime/workOvertimePunchCardCount"

// 移动端个人考勤信息接口
#define A_selectUserWorkAttendance          @"services/workAttendance/selectUserWorkAttendance"

// 修改移动端的个人信息查看与否
#define A_updateMsgNewOrOldStautsById        @"services/msgManager/updateMsgNewOrOldStautsOrById"




// 用户打卡上传(上班)
#define A_goToWork                       @"services/attendance/goToWork"
// 用户打卡上传(下班)
#define A_goOffWork                       @"services/attendance/goOffWork"

// 打卡记录
#define A_attendanceStatistics                       @"services/attendance/attendanceStatistics"

// 打卡违纪记录
#define A_attendanceLateStatistics                       @"services/attendance/attendanceLateStatistics"

#endif
