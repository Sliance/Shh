//
//  HomeServiceApi.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/10/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//


#import "BaseApi.h"
#import "BannersReq.h"
#import "FreeListReq.h"
#import "BannerRes.h"
#import "FreeListRes.h"
#import "TodayListRes.h"
#import "ServiceListRes.h"
#import "GuessListRes.h"
#import "MoreSortRes.h"
#import "CommentListRes.h"
#import "SingleCourseDrectoryRes.h"
#import "DetailCourseRes.h"
#import "DetailArticleRes.h"
#import "DetailServiceRes.h"
#import "CommentReq.h"
#import "HotSearchListRes.h"

@interface HomeServiceApi : BaseApi
+ (instancetype)share;
///banner获取
-(void)getBannerWithParam:(BannersReq *) req response:(responseModel) responseModel;
///免费课程
-(void)getFreeListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///今日干活（1045266497792114689）、精品微课（1045258743325130753）
-(void)getTodayListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///精品微课（1045258743325130753）
-(void)getFineClassWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///推介服务
-(void)getRecommendListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///猜你喜欢
-(void)getGuessListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///首页底部展示
-(void)gethHomeBottomWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取更多分类
-(void)getMoreSortWithParam:(BaseModelReq *) req response:(responseModel) responseModel;
///获取单条课程
-(void)getsingleWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取评论列表
-(void)getCommentListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取单条课程目录
-(void)SingleCourseDirectoryWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取单条文章详情
-(void)getSingleArticleWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取服务详情
-(void)getServiceDetailWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///新增评论
-(void)addCommentWithParam:(CommentReq *) req response:(responseModel) responseModel;
///获取热门搜索
-(void)getHotSearchWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取搜索列表
-(void)getSearchListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///课程购买
-(void)buyCourseWithParam:(FreeListReq *) req response:(responseModel) responseModel;
@end
