//
//  CourseServiceApi.m
//  Shh
//
//  Created by dnaer7 on 2018/10/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CourseServiceApi.h"

@implementation CourseServiceApi
+ (instancetype)share {
    static CourseServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[CourseServiceApi alloc] init];
        }
    });
    return global;
}
///课程分类
-(void)courseSortDirectoryWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:course_sort_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [CourseSortRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
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
