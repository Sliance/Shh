//
//  CourseHeadView.h
//  Shh
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ZSCycleScrollView.h"
#import "ZSSortSelectorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CourseHeadView : BaseView<ZSCycleScrollViewDelegate,ZSSortSelectorViewDelegate>

@property(nonatomic,strong)ZSCycleScrollView *cycleView;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,copy)void(^selectedBlock)(NSInteger);



@end

NS_ASSUME_NONNULL_END
