//
//  MemberShipFootView.h
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberShipFootView : BaseView
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIButton *agreeBtn;
@property(nonatomic,strong)UILabel *dianLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)void(^submitBlock)(void);
@property(nonatomic,copy)void(^detailBlock)(void);

@end

NS_ASSUME_NONNULL_END
