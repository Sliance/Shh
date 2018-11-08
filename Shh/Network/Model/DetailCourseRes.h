//
//  DetailCourseRes.h
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseModel.h"
#import "CourseMemberModel.h"
#import "CourseListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailCourseRes : NSObject
///
@property(nonatomic,strong)NSString *memberIsBook;
///
@property(nonatomic,strong)NSString *memberIsLike;
///
@property(nonatomic,strong)CourseMemberModel *member;
///
@property(nonatomic,strong)CourseModel *course;
///
@property(nonatomic,strong)NSArray *courseList;
///
@property(nonatomic,strong)NSString *memberIsBuyThisCourse;
///
@property(nonatomic,strong)NSString *haveFollowMember;
///
@property(nonatomic,strong)NSString *courseListTotal;
///
@property(nonatomic,strong)NSString *watchCount;




@end

NS_ASSUME_NONNULL_END
