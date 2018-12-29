//
//  MessageRes.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageRes : NSObject
///
@property(nonatomic,assign)BOOL haveRead;
///
@property(nonatomic,copy)NSString *systemCreateTime;
///
@property(nonatomic,copy)NSString *systemCreateUserId;
///
@property(nonatomic,copy)NSString *memberMessageId;
///
@property(nonatomic,copy)NSString *introduction;
///
@property(nonatomic,copy)NSString *content;
///
@property(nonatomic,copy)NSString *title;
///
@property(nonatomic,copy)NSString *memberId;


@end

NS_ASSUME_NONNULL_END
