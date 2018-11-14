//
//  AudioHeadView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailCourseRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioHeadView : BaseView<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *bannerImage;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *lineLabel1;
@property(nonatomic,strong)DetailCourseRes *detailCourse;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *introductLabel;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) UILabel *introducTDecs;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableview;
@property(nonatomic,strong)NSMutableArray*dataArr;

@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property(nonatomic,copy)void(^heightBlock)(CGFloat);
@property(nonatomic,copy)void(^fouceBlock)(BOOL);
@end

NS_ASSUME_NONNULL_END
