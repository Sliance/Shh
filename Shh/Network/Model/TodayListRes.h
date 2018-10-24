//
//  TodayListRes.h
//  Shh
//
//  Created by dnaer7 on 2018/10/22.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodayListRes : NSObject
///
@property(nonatomic,copy)NSString *articlePcCoverImagePath;
///
@property(nonatomic,copy)NSString *articleTitle;
///
@property(nonatomic,copy)NSString *columnId;
///
@property(nonatomic,copy)NSString *articleText;
///
@property(nonatomic,copy)NSString *articleReviewRemark;

///
@property(nonatomic,copy)NSString *articleId;
///
@property(nonatomic,copy)NSString *articleGuide;
///
@property(nonatomic,copy)NSString *articleAppCoverImagePath;
///
@property(nonatomic,copy)NSString *articleTopSort;
///
@property(nonatomic,copy)NSString *systemVersion;

///
@property(nonatomic,copy)NSString *articleIntroduction;
///
@property(nonatomic,copy)NSString *commentCount;
///
@property(nonatomic,copy)NSString *realClickCount;
///
@property(nonatomic,copy)NSString *articleSource;
///
@property(nonatomic,copy)NSString *virtualReadCount;

///
@property(nonatomic,copy)NSString *systemCreateTime;
///
@property(nonatomic,copy)NSString *virtualLikeCount;
///
@property(nonatomic,copy)NSString *articleImagePosition;
///
@property(nonatomic,copy)NSString *memberId;



@end

NS_ASSUME_NONNULL_END
