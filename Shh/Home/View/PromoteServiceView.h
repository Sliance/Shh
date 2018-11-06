//
//  PromoteServiceView.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
///推介服务
@interface PromoteServiceView : BaseView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,assign)CGFloat offer;
@property(nonatomic,copy)void (^allBlock)(void);

@end
