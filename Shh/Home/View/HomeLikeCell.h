//
//  HomeLikeCell.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "GuessListRes.h"
#import "RecommendListRes.h"
#import "FreeListRes.h"

@interface HomeLikeCell : BaseCollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,assign)NSInteger imageHeight;
@property(nonatomic,assign)NSInteger imageWidth;



@property(nonatomic,strong)GuessListRes *model;
@property(nonatomic,strong)RecommendListRes *bottomModel;
@property(nonatomic,strong)FreeListRes *freeModel;
@end
