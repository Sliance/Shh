//
//  HomeFreeCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
///限时免费
@interface HomeFreeCell : BaseCollectionViewCell
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *huoLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *priceLabel;

@end
