//
//  IntegralHeadView.h
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ZSSortSelectorView.h"
NS_ASSUME_NONNULL_BEGIN

@interface IntegralHeadView : BaseView<ZSSortSelectorViewDelegate>
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,copy)void (^chooseBlock)(NSInteger);
@property(nonatomic,copy)void (^shareBlock)(void);

@end

NS_ASSUME_NONNULL_END
