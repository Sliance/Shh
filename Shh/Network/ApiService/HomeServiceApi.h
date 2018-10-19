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
@interface HomeServiceApi : BaseApi
+ (instancetype)share;
///banner获取
-(void)getBannerWithParam:(BannersReq *) req response:(responseModel) responseModel;
///免费课程
-(void)getFreeListWithParam:(FreeListReq *) req response:(responseModel) responseModel;

@end
