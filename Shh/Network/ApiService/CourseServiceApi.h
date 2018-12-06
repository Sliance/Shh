//
//  CourseServiceApi.h
//  Shh
//
//  Created by dnaer7 on 2018/10/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "FreeListReq.h"
#import "CourseSortRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseServiceApi : BaseApi
+ (instancetype)share;
///获取单条课程
-(void)getSingleCourseWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///获取单条课程目录
-(void)singleCourseDirectoryWithParam:(FreeListReq *) req response:(responseModel) responseModel;
///课程分类
-(void)courseSortDirectoryWithParam:(FreeListReq *) req response:(responseModel) responseModel;

@end

NS_ASSUME_NONNULL_END
