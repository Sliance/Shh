//
//  ApplyImageCell.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyImageCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *logoImage;
@property(nonatomic,assign)NSInteger width;
@end

NS_ASSUME_NONNULL_END
