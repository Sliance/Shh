//
//  MineFootView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface MineFootView : BaseView
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,copy)void(^selecteBlock)(NSUInteger);
@property(nonatomic,copy)void(^headBlock)(NSInteger);

@end
