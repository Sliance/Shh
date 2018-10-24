//
//  ServiceApi.m
//  Shh
//
//  Created by dnaer7 on 2018/10/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ServiceApi.h"

@implementation ServiceApi
+ (instancetype)share {
    static ServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[ServiceApi alloc] init];
        }
    });
    return global;
}
///服务列表
-(void)getServiceListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:service_list_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [ServiceListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
@end
