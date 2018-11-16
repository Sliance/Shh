//
//  CommentReq.h
//  Shh
//
//  Created by dnaer7 on 2018/11/16.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentReq : BaseModelReq
///
@property(nonatomic,copy)NSString *articleOrCourseId;
///
@property(nonatomic,copy)NSString *beCommentId;
///
@property(nonatomic,copy)NSString *beCommentMemberId;
///
@property(nonatomic,copy)NSString *beCommentMemberNickname;
///
@property(nonatomic,copy)NSString *commentContent;
///
@property(nonatomic,copy)NSString *commentType;
@end

NS_ASSUME_NONNULL_END
