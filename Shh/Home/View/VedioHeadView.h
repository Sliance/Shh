//
//  VedioHeadView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "SingleCourseDrectoryRes.h"
#import "DetailCourseRes.h"
#import "YGPlayerView.h"
#import "FreeListRes.h"


NS_ASSUME_NONNULL_BEGIN

@interface VedioHeadView : BaseView<UICollectionViewDelegate,UICollectionViewDataSource>
{
    YGPlayerView *playerView;
}
@property (nonatomic, strong) SingleCourseDrectoryRes *model;
@property (nonatomic, strong) NSMutableArray *playInfos;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *lineLabel1;
@property(nonatomic,strong)DetailCourseRes *detailCourse;

@property (nonatomic, strong) UILabel *introductLabel;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) UILabel *introducTDecs;

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray*dataArr;

@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property(nonatomic,copy)void(^heightBlock)(CGFloat);
@property(nonatomic,copy)void(^fouceBlock)(BOOL);
@property(nonatomic,copy)void(^listBlock)(FreeListRes *);
@end

NS_ASSUME_NONNULL_END
