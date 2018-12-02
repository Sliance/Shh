//
//  FollowsCell.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "FollowRes.h"
NS_ASSUME_NONNULL_BEGIN

@interface FollowsCell : BaseTableViewCell
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) FollowRes*model;
@end

NS_ASSUME_NONNULL_END
