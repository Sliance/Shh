//
//  CourseModel.h
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseModel : NSObject
///
@property(nonatomic,strong)NSString *columnId;
///
@property(nonatomic,strong)NSString *courseAppCoverImagePath;
///
@property(nonatomic,strong)NSString *courseAppImagePath;
///
@property(nonatomic,strong)NSArray *courseBannerList;
///
@property(nonatomic,strong)NSString *courseBannerTime;
///
@property(nonatomic,strong)NSString *courseCategoryId;
///
@property(nonatomic,strong)NSString *courseCommentCount;
///
@property(nonatomic,strong)NSString *courseHighlight;
///
@property(nonatomic,strong)NSString *courseId;
///
@property(nonatomic,strong)NSString *courseIntroduction;
///
@property(nonatomic,strong)NSString *courseIsFree;
///
@property(nonatomic,strong)NSString *courseIsTimelimitFree;
///
@property(nonatomic,strong)NSString *courseIsVipFree;
///
@property(nonatomic,strong)NSString *courseOutline;
///
@property(nonatomic,strong)NSString *coursePcCoverImagePath;
///
@property(nonatomic,strong)NSString *coursePcImagePath;
///
@property(nonatomic,strong)NSString *coursePrice;
///
@property(nonatomic,strong)NSString *courseReviewRemark;
///
@property(nonatomic,strong)NSString *courseReviewStatus;
///
@property(nonatomic,strong)NSString *courseTitle;
///
@property(nonatomic,strong)NSString *courseTopSort;
///
@property(nonatomic,strong)NSString *courseTrueClickCount;
///
@property(nonatomic,strong)NSString *courseTrueLikeCount;
///
@property(nonatomic,strong)NSString *courseType;
///
@property(nonatomic,strong)NSString *courseVideoOrAudio;
///
@property(nonatomic,strong)NSString *courseVirtualClickCount;
///
@property(nonatomic,strong)NSString *lecturerMemberId;
///
@property(nonatomic,strong)NSString *systemVersion;
@end

NS_ASSUME_NONNULL_END
