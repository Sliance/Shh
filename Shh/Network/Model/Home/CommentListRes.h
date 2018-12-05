//
//  CommentListRes.h
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentListRes : NSObject
///
@property(nonatomic,strong)NSString *memberAvatarPath;
///
@property(nonatomic,strong)NSString *commentContent;
///
@property(nonatomic,strong)NSString *beCommentId;
///
@property(nonatomic,strong)NSString *systemVersion;
///
@property(nonatomic,strong)NSString *beCommentMemberNickname;
///
@property(nonatomic,strong)NSString *commentLikeCount;
///
@property(nonatomic,strong)NSString *commentId;
///
@property(nonatomic,strong)NSString *articleOrCourseId;

///
@property(nonatomic,strong)NSString *beCommentMemberId;
///
@property(nonatomic,strong)NSString *systemCreateTime;
///
@property(nonatomic,strong)NSString *memberNickname;
///
@property(nonatomic,strong)NSArray *beCommentList;
///
@property(nonatomic,strong)NSString *memberId;
///
@property(nonatomic,assign)BOOL memberIsLike;

@end

NS_ASSUME_NONNULL_END
