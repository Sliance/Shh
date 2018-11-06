//
//  FreeListReq.h
//  Shh
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface FreeListReq : BaseModelReq
///栏目编号
@property(nonatomic,copy)NSString *columnId;
///课程分类编号
@property(nonatomic,copy)NSString *courseCategoryId;
///课程目录编号
@property(nonatomic,copy)NSString *courseListId;
@property(nonatomic,copy)NSString *courseId;

@property(nonatomic,copy)NSString *articleOrCourseType;

@property(nonatomic,copy)NSString *articleOrCourseId;
@end

NS_ASSUME_NONNULL_END
