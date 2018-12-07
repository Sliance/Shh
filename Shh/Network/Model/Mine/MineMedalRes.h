//
//  MineMedalRes.h
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineMedalRes : NSObject
///
@property(nonatomic,copy)NSString *memberBadgeId;
///
@property(nonatomic,assign)NSInteger mission;
///
@property(nonatomic,copy)NSString *badgeType;
///
@property(nonatomic,strong)NSString *descriptions;
///
@property(nonatomic,assign)BOOL finish;
///
@property(nonatomic,copy)NSString *memberId;
///
@property(nonatomic,assign)NSInteger complete;


@end

NS_ASSUME_NONNULL_END
