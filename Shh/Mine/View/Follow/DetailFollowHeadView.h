//
//  DetailFollowHeadView.h
//  Shh
//
//  Created by zhangshu on 2018/12/5.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "FollowRes.h"
#import "ZSSortSelectorView.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailFollowHeadView : BaseView<ZSSortSelectorViewDelegate>
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *fouceLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong)FollowRes*model;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,copy)void (^chooseBlock)(NSInteger);
@property(nonatomic,copy)void (^fouceBlock)(void);

@end

NS_ASSUME_NONNULL_END
