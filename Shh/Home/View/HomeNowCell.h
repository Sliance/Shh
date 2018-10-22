//
//  HomeNowCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "TodayListRes.h"

///今日干货
@interface HomeNowCell : BaseCollectionViewCell
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)TodayListRes *model;
@end
