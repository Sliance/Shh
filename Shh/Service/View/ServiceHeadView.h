//
//  ServiceHeadView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ZSCycleScrollView.h"

@interface ServiceHeadView : BaseView<ZSCycleScrollViewDelegate>
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIButton *memberBtn;
@property(nonatomic,strong)ZSCycleScrollView *cycleView;
@end
