//
//  MessageListCell.h
//  Shh
//
//  Created by zhangshu on 2018/12/25.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageListCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIImageView *rightImage;

@property(nonatomic,strong)MessageRes*model;

@end

NS_ASSUME_NONNULL_END
