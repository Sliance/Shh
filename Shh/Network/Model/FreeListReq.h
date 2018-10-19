//
//  FreeListReq.h
//  Shh
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface FreeListReq : BaseModelReq
///栏目编号
@property(nonatomic,copy)NSString *columnId;
///课程分类编号
@property(nonatomic,copy)NSString *courseCategoryId;

@end

NS_ASSUME_NONNULL_END
