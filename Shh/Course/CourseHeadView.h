//
//  CourseHeadView.h
//  Shh
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ZSCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseHeadView : BaseView<ZSCycleScrollViewDelegate>

@property(nonatomic,strong)ZSCycleScrollView *cycleView;

@end

NS_ASSUME_NONNULL_END
