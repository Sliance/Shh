//
//  RegisterAlertView.h
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterAlertView : BaseView
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *forgetBtn;
@property(nonatomic,strong)UIButton *dismissBtn;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *passWordField;
@property(nonatomic,strong)UITextField *nameField;
@property(nonatomic,strong)UITextField *inviteField;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *line0;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UILabel *line1;
@property(nonatomic,strong)UILabel *line2;
@property(nonatomic,strong)UILabel *registerLabel;
@property(nonatomic,copy)void(^ChooseBlock)(void);
@property(nonatomic,copy)void(^loginBlock)(void);
@property(nonatomic,copy)void(^forgetBlock)(void);

@end

NS_ASSUME_NONNULL_END
