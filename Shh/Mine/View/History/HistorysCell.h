//
//  HistorysCell.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "FreeListRes.h"
#import "OrderRes.h"
#import "CollectionRes.h"
#import "TodayListRes.h"
#import "FreeListRes.h"


NS_ASSUME_NONNULL_BEGIN

@interface HistorysCell : BaseCollectionViewCell
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *huoLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *kanimage;
@property(nonatomic,strong)UIImageView *zanimage;
@property(nonatomic,strong)FreeListRes *model;
@property(nonatomic,strong)OrderRes *ordermodel;
@property(nonatomic,strong)CollectionRes*collectModel;
@property(nonatomic,strong)TodayListRes*articleModel;
@property(nonatomic,strong)FreeListRes*coursemodel;


@end

NS_ASSUME_NONNULL_END
