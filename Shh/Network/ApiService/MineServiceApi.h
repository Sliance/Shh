//
//  MineServiceApi.h
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "LoginReq.h"
#import "MemberInfoRes.h"
#import "HelpRes.h"
#import "MessageRes.h"
#import "ApplyForReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineServiceApi : BaseApi
+ (instancetype)share;

///登录
-(void)loginWithParam:(LoginReq *) req response:(responseModel) responseModel;
///注册发送验证码
-(void)sendCodeWithParam:(LoginReq *) req response:(responseModel) responseModel;
///注册
-(void)registerWithParam:(LoginReq *) req response:(responseModel) responseModel;
///忘记密码发送验证码
-(void)forgetSendCodeWithParam:(LoginReq *) req response:(responseModel) responseModel;
///忘记密码
-(void)forgetPasswordWithParam:(LoginReq *) req response:(responseModel) responseModel;
///获取会员基本信息
-(void)getMenberInfoWithParam:(LoginReq *) req response:(responseModel) responseModel;
///消息列表
-(void)getMessageListWithParam:(LoginReq *) req response:(responseModel) responseModel;
///帮助列表
-(void)getHelpListWithParam:(LoginReq *) req response:(responseModel) responseModel;
///申请入驻提交审核
-(void)applyForWithParam:(ApplyForReq *) req response:(responseModel) responseModel;
@end

NS_ASSUME_NONNULL_END
