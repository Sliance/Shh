//
//  QualityCollectionCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/30.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "ServiceListRes.h"
#import "RecommendListRes.h"

@interface QualityCollectionCell : BaseCollectionViewCell
@property(nonatomic,strong)UIImageView *headiamge;
@property(nonatomic,assign)NSInteger imageHeight;
@property(nonatomic,assign)NSInteger imageWidth;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)ServiceListRes *model;
@property(nonatomic,strong)RecommendListRes *recomendModel;

@end
