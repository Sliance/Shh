//
//  HomeServiceApi.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/10/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "BaseModelReq.h"

@interface HomeServiceApi : BaseApi
+ (instancetype)share;
///发送验证码
-(void)sendVerCodeWithParam:(BaseModelReq *) req response:(responseModel) responseModel;

@end
