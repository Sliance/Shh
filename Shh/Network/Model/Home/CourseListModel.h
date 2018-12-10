//
//  CourseListModel.h
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseListModel : NSObject
///
@property(nonatomic,strong)NSString *courseId;
///
@property(nonatomic,strong)NSString *courseListId;
///
@property(nonatomic,strong)NSString *courseListIsAllowTry;
///
@property(nonatomic,assign)NSInteger courseMediaDuration;
///
@property(nonatomic,strong)NSString *courseMediaPath;
///
@property(nonatomic,strong)NSString *courseMediaSize;
///
@property(nonatomic,strong)NSString *courseNo;
///
@property(nonatomic,strong)NSString *courseTitle;
///
@property(nonatomic,strong)NSString *systemVersion;
///
@property(nonatomic,strong)NSString *watch;
///
@property(nonatomic,assign)BOOL memberIsBuyThisCourse;

@end

NS_ASSUME_NONNULL_END
