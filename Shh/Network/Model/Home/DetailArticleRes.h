//
//  DetailArticleRes.h
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseMemberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailArticleRes : NSObject
///
@property(nonatomic,strong)CourseMemberModel *member;
///
@property(nonatomic,strong)NSString *columnId;
///
@property(nonatomic,strong)NSString *articleText;
///
@property(nonatomic,strong)NSString *articleReviewRemark;
///
@property(nonatomic,strong)NSString *articleGuide;
///
@property(nonatomic,strong)NSString *articleReviewStatus;
///
@property(nonatomic,strong)NSString *haveFollowMember;
///
@property(nonatomic,strong)NSString *systemVersion;
///
@property(nonatomic,strong)NSString *articleIntroduction;
///
@property(nonatomic,strong)NSString *realClickCount;
///
@property(nonatomic,strong)NSString *memberIsBook;
///
@property(nonatomic,strong)NSString *articleImagePosition;
///
@property(nonatomic,strong)NSString *beFollowCount;
///
@property(nonatomic,strong)NSString *memberId;
///
@property(nonatomic,strong)NSString *articlePcCoverImagePath;
///
@property(nonatomic,strong)NSString *articleTitle;
///
@property(nonatomic,strong)NSString *systemUpdateTime;
///
@property(nonatomic,strong)NSString *memberIsLike;
///
@property(nonatomic,strong)NSString *articleId;
///
@property(nonatomic,strong)NSString *articleAppCoverImagePath;
///
@property(nonatomic,strong)NSString *articleTopSort;
///
@property(nonatomic,strong)NSString *commentCount;
///
@property(nonatomic,strong)NSString *articleSource;
///
@property(nonatomic,strong)NSString *virtualReadCount;
///
@property(nonatomic,strong)NSString *virtualLikeCount;
@end

NS_ASSUME_NONNULL_END
