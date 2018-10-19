//
//  FreeListRes.h
//  Shh
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FreeListRes : NSObject
///课程编号
@property(nonatomic,copy)NSString *courseId;
///课程栏目编号
@property(nonatomic,copy)NSString *columnId;
///课程分类
@property(nonatomic,copy)NSString *courseType;
///课程分类
@property(nonatomic,copy)NSString *courseCategoryId;
///课程标题
@property(nonatomic,copy)NSString *courseTitle;
///课程亮点
@property(nonatomic,copy)NSString *courseHighlight;
///是否免费
@property(nonatomic,copy)NSString *courseIsFree;
///是否限时免费
@property(nonatomic,copy)NSString *courseIsTimelimitFree;
///是否会员免费
@property(nonatomic,copy)NSString *courseIsVipFree;
///课程价格
@property(nonatomic,copy)NSString *coursePrice;
///课程简介
@property(nonatomic,copy)NSString *courseIntroduction;
///课程app封面图
@property(nonatomic,copy)NSString *courseAppCoverImagePath;
///课程pc封面图
@property(nonatomic,copy)NSString *coursePcCoverImagePath;
///课程pc主图
@property(nonatomic,copy)NSString *coursePcImagePath;
///课程大纲
@property(nonatomic,copy)NSString *courseOutline;
///课程虚拟点击量
@property(nonatomic,copy)NSString *courseVirtualClickCount;
///课程评论数量
@property(nonatomic,copy)NSString *courseCommentCount;

///课程真实点击量
@property(nonatomic,copy)NSString *courseTrueClickCount;
///课程真实点赞数量
@property(nonatomic,copy)NSString *courseTrueLikeCount;
///
@property(nonatomic,strong)NSArray *courseBannerList;

@end

NS_ASSUME_NONNULL_END
