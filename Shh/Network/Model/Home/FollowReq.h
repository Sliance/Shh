//
//  FollowReq.h
//  Shh
//
//  Created by zhangshu on 2018/12/4.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface FollowReq : BaseModelReq
///
@property(nonatomic,copy)NSString *beFollowMemberId;

@end

NS_ASSUME_NONNULL_END
