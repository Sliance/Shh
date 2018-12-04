//
//  BaseApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSAPIProxy.h"
#import "UserCacheBean.h"
#import "ZSConfig.h"

///获取显示免费课程列表
#define banner_list          @"/sihehui/banner/desktop/v1/list"
///获取显示免费课程列表
#define free_course_list          @"/sihehui/course/desktop/v1/limit/free/list"
///获取热门课程列表
#define hot_course_list          @"/sihehui/course/desktop/v1/hot/list"
///热门搜索列表
#define hot_search_list          @"/sihehui/course/desktop/v1/hotSearch"
///搜索课程
#define search_course          @"/sihehui/course/desktop/v1/search"
///获取单条课程
#define single_course           @"/sihehui/course/desktop/v1/find"
///获取单条课程目录
#define single_course_directory   @"/sihehui/course/list/desktop/v1/find"
///获取单条文章
#define single_article    @"/sihehui/article/desktop/v1/find"
///获取会员的课程列表
#define mine_course_list          @"/sihehui/course/desktop/v1/home/list"
///获取会员的课程列表/精品微课
#define fine_course_list          @"/sihehui/course/desktop/v1/list"

///更多分类页面接口
#define more_sort_list         @"/sihehui/course/category/desktop/v1/list"
///获取评论列表
#define more_comment_list         @"/sihehui/comment/desktop/v1/list"
///新增评论
#define add_comment_list         @"/sihehui/comment/desktop/v1/save"

///删除订单
#define delete_order          @"/sihehui/order/admin/v1/delete"
///获取单条订单
#define single_order          @"/sihehui/order/admin/v1/find"
///获取订单列表
#define order_list         @"/sihehui/order/admin/v1/list"
///新增订单
#define add_order          @"/sihehui/order/admin/v1/save"
///修改订单
#define change_order          @"/sihehui/order/admin/v1/update"

///今日干活
#define Today_list          @"/sihehui/article/desktop/v1/list"
///推介服务
#define recommend_list          @"/sihehui/siheservice/desktop/v1/list/recommend"
///猜你喜欢
#define guess_list          @"/sihehui/member/click/desktop/v1/guess/list"
///底部展示
#define home_bottom_url         @"/sihehui/siheservice/desktop/v1/app/home/list"
//课程分类
#define course_sort_url         @"/sihehui/column/desktop/v1/list"
//服务模块（精品服务、培训服务、活动执行、招商加盟）
#define service_list_url         @"/sihehui/siheservice/desktop/v1/list"
///服务详情
#define service_detail_url      @"/sihehui/siheservice/desktop/v1/find"

///登录
#define login_url  @"/sihehui/member/desktop/v1/login"
///注册发送验证码
#define send_code   @"/sihehui/member/desktop/v1/register/sms/send"
///注册
#define register_url     @"/sihehui/member/desktop/v1/register/member"
///忘记密码发送验证码
#define send_code_forget  @"/sihehui/member/desktop/v1/forget/sms/send"
///忘记密码
#define forget_password  @"/sihehui/member/desktop/v1/forget/password"
///会员信息
#define mine_info  @"/sihehui/member/desktop/v1/find"
///消息列表
#define message_list   @"/sihehui/member/message/desktop/v1/list"
///帮助列表
#define help_list   @"/sihehui/help/desktop/v1/list"
///申请入驻提交审核
#define apply_for_url @"/sihehui/company/settled/desktop/v1/save"
///历史记录
#define history_list_url @"/sihehui/member/watch/history/desktop/v1/list"
///我的购买
#define mine_purchse_url  @"/sihehui/order/desktop/v1/list"
///我的收藏
#define mine_collect_url @"/sihehui/member/book/desktop/v1/list"
///我的关注
#define mine_follow_url  @"/sihehui/member/follow/desktop/v1/list"
///课程购买
#define buy_course_url   @"/sihehui/order/desktop/v1/app/course/wx/save"
///加入思和会
#define join_in_url     @"/sihehui/member/desktop/v1/join"
///关注
#define follow_url   @"/sihehui/member/follow/desktop/v1/save"
///点赞
#define like_url     @"/sihehui/member/like/desktop/v1/save"
///收藏
#define book_url    @"/sihehui/member/book/desktop/v1/save"


typedef void(^responseModel)(id response);
@interface BaseApi : NSObject
+ (void)requestAccountInfoModel:(responseModel ) response;
@end
