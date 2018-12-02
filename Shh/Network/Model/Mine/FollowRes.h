//
//  FollowRes.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowRes : NSObject
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,copy)NSString *memberDesc;
///
@property(nonatomic,copy)NSString *memberName;
///
@property(nonatomic,copy)NSString *beFollowMemberId;

@end

NS_ASSUME_NONNULL_END
