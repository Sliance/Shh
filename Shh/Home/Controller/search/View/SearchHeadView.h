//
//  SearchHeadView.h
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchHeadView : BaseView<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *searchField;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UILabel *line1;
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,copy)void (^cancleBlock)(void);
@property(nonatomic,copy)void (^endBlock)(NSString*);
@end

NS_ASSUME_NONNULL_END
