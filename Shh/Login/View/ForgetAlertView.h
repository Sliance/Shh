//
//  ForgetAlertView.h
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetAlertView : BaseView
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *dismissBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,copy)void(^closeBlock)(void);
@property(nonatomic,copy)void(^getBlock)(void);

@end

NS_ASSUME_NONNULL_END
