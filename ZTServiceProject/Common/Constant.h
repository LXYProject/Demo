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

#define MR_Host_Test  @"192.168.1.96:8080/ZtscApp/Service"


#define MRRemote(A)             [NSString stringWithFormat:@"%@%@%@", MR_Http, MR_Host_Test, (A)]

// 首页轮播图
#define A_UrlA                   @"?service=adPhotoService&function=cityAdList"
// 物业轮播图
#define A_UrlB                  @"?service=adPhotoService&function=propertyAdList"
// 去帮忙
#define A_HelpUrl               @"?service=serviceService&function=searchAppeal"
// 找服务
#define A_FindUrl               @"?service=serviceService&function=searchService"

// 服务或求助类型列
#define A_Leixin                @"?service=serviceService&function=serviceOrAppealCategory"



#define A_URL @"http://192.168.1.96:8080/ZtscApp/Service?service=adPhotoService&function=propertyAdList"











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
