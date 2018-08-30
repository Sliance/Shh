//
//  HomeGivingCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "UILabel+String.h"

///会员大课
@interface HomeGivingCell : BaseCollectionViewCell
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UILabel *shareLabel;
@property(nonatomic,strong)UILabel *likeLabel;

@end
