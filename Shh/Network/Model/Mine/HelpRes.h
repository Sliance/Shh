//
//  HelpRes.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpRes : NSObject
///
@property(nonatomic,copy)NSString *helpId;
///
@property(nonatomic,copy)NSString *systemCreateTime;
///
@property(nonatomic,copy)NSString *systemCreateUserId;
///
@property(nonatomic,copy)NSString *title;
///
@property(nonatomic,copy)NSString *content;
///
@property(nonatomic,assign)CGFloat height;
@end

NS_ASSUME_NONNULL_END
