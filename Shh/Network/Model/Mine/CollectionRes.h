//
//  CollectionRes.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionRes : NSObject
///
@property(nonatomic,copy)NSString *articleOrCourseTitle;
///
@property(nonatomic,copy)NSString *articleOrCourseImagePath;
///
@property(nonatomic,copy)NSString *articleOrCourseId;
///
@property(nonatomic,copy)NSString *memberBookId;
///
@property(nonatomic,copy)NSString *articleOrCourseType;
///
@property(nonatomic,copy)NSString *memberId;
///
@property(nonatomic,copy)NSString *courseVideoOrAudio;
@end

NS_ASSUME_NONNULL_END
