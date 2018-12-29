//
//  ServiceApi.h
//  Shh
//
//  Created by dnaer7 on 2018/10/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "FreeListReq.h"
#import "ServiceListRes.h"
#import "SignUpService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceApi : BaseApi
+ (instancetype)share;
///服务列表
-(void)getServiceListWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///服务报名
-(void)signUpServiceListWithParam:(SignUpService *) req response:(responseModel) responseModel;


@end

NS_ASSUME_NONNULL_END
