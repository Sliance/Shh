//
//  ArticleHeadView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailArticleRes.h"
#import "HomeNowCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ArticleHeadView : BaseView<UIWebViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *fouceBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *fouceLabel;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)DetailArticleRes *model;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIButton *excBtn;

@property(nonatomic,copy)void(^heightBlock)(CGFloat);
@property(nonatomic,copy)void(^fouceBlock)(BOOL);
@property(nonatomic,copy)void(^listBlock)(TodayListRes *);
@property(nonatomic,copy)void(^excBlock)(void);

@end

NS_ASSUME_NONNULL_END
