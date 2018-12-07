//
//  IntegralCell.h
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "IntegralRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegralCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *integralLabel;
@property(nonatomic,strong)IntegralRes *model;

@end

NS_ASSUME_NONNULL_END
