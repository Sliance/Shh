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
#import "RecommendListRes.h"
#import "GuessListRes.h"

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


@end
