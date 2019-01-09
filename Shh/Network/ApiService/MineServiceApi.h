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
#import "FreeListReq.h"
#import "FreeListRes.h"
#import "OrderRes.h"
#import "CollectionRes.h"
#import "FollowRes.h"
#import "TodayListRes.h"
#import "IntegralRes.h"
#import "MineMedalRes.h"

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
///修改个人信息
-(void)changeMemberInfoWithParam:(MemberInfoRes *) req response:(responseModel) responseModel;
///消息列表
-(void)getMessageListWithParam:(LoginReq *) req response:(responseModel) responseModel;
///帮助列表
-(void)getHelpListWithParam:(LoginReq *) req response:(responseModel) responseModel;
///申请入驻提交审核
-(void)applyForWithParam:(ApplyForReq *) req response:(responseModel) responseModel;
///历史记录
-(void)getHistoryListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我的购买
-(void)getOrderListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我的收藏
-(void)getCollectListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我的关注
-(void)getFollowListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///加入思和会/研习社/总裁班
-(void)joinInWithParam:(ApplyForReq *) req response:(responseModel) responseModel;
///我关注的授课师
-(void)getTeacherInfoWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我关注的授课师的文章
-(void)getTeacherArticleWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我关注的授课师的课程
-(void)getTeacherCourseWithParam:(FreeListReq *) req response:(responseModel) responseModel;

///积分明细
-(void)getIntegralDetailWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///积分排行
-(void)getIntegralRankWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///勋章
-(void)getmMineMedalWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///我的任务
-(void)getmMineTaskWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///签到
-(void)getSignInWithParam:(FreeListReq *) req response:(responseModel) responseModel;


@end

NS_ASSUME_NONNULL_END
