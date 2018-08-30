//
//  HomeHeadView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "MineTypeBtn.h"

@interface HomeHeadView : BaseView

@property(nonatomic,copy)void (^selectedBlock)(NSInteger);

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton *allBtn;
@end
