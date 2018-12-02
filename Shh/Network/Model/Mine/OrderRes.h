//
//  OrderRes.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderRes : NSObject
///
@property(nonatomic,copy)NSString *orderDesc;
///
@property(nonatomic,copy)NSString *orderAlreadyPayAmount;
///
@property(nonatomic,copy)NSString *orderAppImagePath;
///
@property(nonatomic,copy)NSString *articleOrCourseType;
///
@property(nonatomic,copy)NSString *orderId;
///
@property(nonatomic,copy)NSString *orderType;
///
@property(nonatomic,copy)NSString *orderNo;

@end

NS_ASSUME_NONNULL_END
