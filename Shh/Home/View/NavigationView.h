//
//  NavigationView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface NavigationView : BaseView
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIButton *historyBtn;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,assign)NSInteger leftWidth;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,copy)void (^leftBlock)(void);
@property(nonatomic,copy)void (^historyBlock)(void);
@property(nonatomic,copy)void (^searchBlock)(void);
@end
