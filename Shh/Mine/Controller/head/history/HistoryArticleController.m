//
//  HistoryArticleController.m
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HistoryArticleController.h"
#import "HistorysCell.h"
#import "MineServiceApi.h"
#import "DetailCourseController.h"
#import "DetailAudioController.h"
@interface HistoryArticleController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;


@end
static NSString *freecellIds = @"HistorysCell";
@implementation HistoryArticleController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-30) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HistorysCell class] forCellWithReuseIdentifier:freecellIds];
        _collectionView.backgroundColor = DSColorFromHex(0xFAFAFA);
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
   
}
-(void)getFreeListType:(NSString*)type{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getHistoryListWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            for (FreeListRes *model in response) {
                if ([model.courseVideoOrAudio isEqualToString:type]) {
                    [weakself.dataArr addObject:model];
                }
            }
            [weakself.collectionView reloadData];
        }
        
        
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREENWIDTH, 115);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    
    return CGSizeMake(SCREENWIDTH, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
     return CGSizeMake(SCREENWIDTH, 80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistorysCell *freecell = [collectionView dequeueReusableCellWithReuseIdentifier:freecellIds forIndexPath:indexPath];
    FreeListRes *model = self.dataArr[indexPath.row];
    [freecell setModel:model];
    return freecell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FreeListRes *model = self.dataArr[indexPath.row];
    if ([model.courseVideoOrAudio isEqualToString:@"video"]) {
        DetailCourseController *courseVC = [[DetailCourseController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
    }else{
        DetailAudioController *courseVC = [[DetailAudioController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
    }
}

@end
