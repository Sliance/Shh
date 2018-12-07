//
//  MineMedalCell.h
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MineMedalRes.h"
#import "ZYProGressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineMedalCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *integralLabel;
@property(nonatomic,strong)UIButton *headImage;
@property(nonatomic,strong)MineMedalRes*model;
@property(nonatomic,strong)ZYProGressView *progress;

@end

NS_ASSUME_NONNULL_END
