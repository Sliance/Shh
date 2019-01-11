//
//  OpenStatusCell.h
//  Shh
//
//  Created by zhangshu on 2019/1/11.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OpenStatusCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *openBtn;
@property(nonatomic,copy)void (^openBlock)(void);
@end

NS_ASSUME_NONNULL_END
