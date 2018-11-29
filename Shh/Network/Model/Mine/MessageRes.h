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
@property(nonatomic,copy)NSString *signIn;
///
@property(nonatomic,copy)NSString *message;
///
@property(nonatomic,copy)NSString *title;
///
@property(nonatomic,copy)NSString *detail;


@end

NS_ASSUME_NONNULL_END
