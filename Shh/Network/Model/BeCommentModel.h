//
//  BeCommentModel.h
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BeCommentModel : NSObject
///
@property(nonatomic,strong)NSString *articleOrCourseId;
///
@property(nonatomic,strong)NSString *beCommentId;
///
@property(nonatomic,strong)NSString *beCommentMemberId;
///
@property(nonatomic,strong)NSString *beCommentMemberNickname;
///
@property(nonatomic,strong)NSString *commentContent;
///
@property(nonatomic,strong)NSString *commentId;
///
@property(nonatomic,strong)NSString *commentLikeCount;
///
@property(nonatomic,strong)NSString *memberAvatarPath;
///
@property(nonatomic,strong)NSString *memberId;
///
@property(nonatomic,strong)NSString *memberNickname;
///
@property(nonatomic,strong)NSString *systemCreateTime;
///
@property(nonatomic,strong)NSString *systemVersion;
@end

NS_ASSUME_NONNULL_END
