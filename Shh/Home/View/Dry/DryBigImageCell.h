//
//  DryBigImageCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TodayListRes.h"

@interface DryBigImageCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *iconiamge;
@property(nonatomic,strong)UILabel *iconlabel;
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UILabel *shareLabel;
@property(nonatomic,strong)UILabel *likeLabel;
@property(nonatomic,strong)TodayListRes *model;
@end
