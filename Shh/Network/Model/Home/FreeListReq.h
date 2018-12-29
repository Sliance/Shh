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
@property(nonatomic,copy)NSString *articleOrCourseImagePath;
@property(nonatomic,copy)NSString *articleOrCourseTitle;
@property(nonatomic,copy)NSString *articleOrCourseId;
@property(nonatomic,copy)NSString *articleId;
@property(nonatomic,copy)NSString *siheserviceId;

@property(nonatomic,copy)NSString *courseTitle;
@property(nonatomic,copy)NSString *searchType;
@property(nonatomic,copy)NSString *teacherMemberId;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *courseType;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *amount;

@end

NS_ASSUME_NONNULL_END
