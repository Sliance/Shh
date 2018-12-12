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
@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UILabel *hYimage;
@property(nonatomic,strong)UILabel *hYtitle;
@property(nonatomic,strong)UILabel *hYDate;
@property(nonatomic,strong)UIImageView *yanImage;
@property(nonatomic,strong)UIImageView *zongImage;
@property(nonatomic,strong)UILabel *yanLabel;
@property(nonatomic,strong)UILabel *zongLabel;
@property(nonatomic,strong)UIButton *yanright;
@property(nonatomic,strong)UIButton *zongright;


@property(nonatomic,copy)void(^selecteBlock)(NSUInteger);
@property(nonatomic,copy)void(^tapBlock)(void);

@end
