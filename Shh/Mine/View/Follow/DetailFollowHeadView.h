//
//  DetailFollowHeadView.h
//  Shh
//
//  Created by zhangshu on 2018/12/5.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "FollowRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailFollowHeadView : BaseView
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *fouceLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong)FollowRes*model;

@end

NS_ASSUME_NONNULL_END
