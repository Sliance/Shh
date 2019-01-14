//
//  CourseController.m
//  Shh
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CourseController.h"
#import "HomeGivingCell.h"
#import "CourseHeadView.h"
#import "CourseServiceApi.h"
#import "HomeServiceApi.h"
#import "NavigationView.h"
#import "SortViewController.h"
#import "DetailCourseController.h"
#import "DetailAudioController.h"
#import "HistoryBaseController.h"
#import "SearchController.h"
#import "DetailArticleController.h"
#import "DetailServiceController.h"

@interface CourseController ()<UICollectionViewDelegate, UICollectionViewDataSource,ZSCycleScrollViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NavigationView *navView;
@property (nonatomic, strong)NSMutableArray *sortArr;
@property (nonatomic, strong)NSMutableArray *bannerArr;
@property (nonatomic, strong)NSMutableArray *courseArr;
@property (nonatomic, assign)NSInteger currentIndex;

@end
static NSString *givecellIds = @"HomeGivingCell";
@implementation CourseController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[HomeGivingCell class] forCellWithReuseIdentifier:givecellIds];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
-(NavigationView *)navView{
    if (!_navView) {
        _navView = [[NavigationView alloc]init];
        _navView.frame = CGRectMake(0, 0, SCREENWIDTH, [self navHeightWithHeight]);
        [_navView setLeftWidth:15];
    }
    return _navView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.navView];
    [self.view addSubview:self.collectionView];
    
    self.sortArr = [NSMutableArray array];
    self.bannerArr = [NSMutableArray array];
    self.courseArr = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    [self.navView setHistoryBlock:^{
        HistoryBaseController *setVC = [[HistoryBaseController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:setVC animated:YES];
    }];
    [self.navView setSearchBlock:^{
        SearchController *setVC = [[SearchController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:setVC animated:YES];
    }];
    _currentIndex = 1;
    [self getBannerList:@"wxCourse"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
  
        _currentIndex = 1;
        [self getBannerList:@"wxCourse"];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)getBannerList:(NSString*)type{
    BannersReq *req = [[BannersReq alloc]init];
    req.appId = @"1041622992853962754";
    req.appOrPc = @"APP";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.bannerLocation = type;
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getBannerWithParam:req response:^(id response) {
        if (response) {
            [weakself.bannerArr removeAllObjects];
            [weakself.bannerArr addObjectsFromArray:response];
            
            [weakself.collectionView reloadData];
        }
         [self getCourseSort];
    }];
}
-(void)getCourseSort{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseType = @"course";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[CourseServiceApi share]courseSortDirectoryWithParam:req response:^(id response) {
        if (response) {
            [weakself.sortArr removeAllObjects];
            [weakself.sortArr addObjectsFromArray:response];
           
            CourseSortRes *model = [self.sortArr firstObject];
            [weakself getCourseList:model.columnId];
        }
        [weakself.collectionView reloadData];
    }];
}
-(void)getCourseList:(NSString*)colmunid{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.columnId = colmunid;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
     __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getFineClassWithParam:req response:^(id response) {
        if (response) {
            [weakself.courseArr removeAllObjects];
            [weakself.courseArr addObjectsFromArray:response];
        }
        [weakself.collectionView reloadData];
    }];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.courseArr.count;
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
    
    return 10;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREENWIDTH, 318);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREENWIDTH, 200*SCREENWIDTH/375+40);
    
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView" forIndexPath:indexPath];
        footview.backgroundColor =DSColorFromHex(0xF2F2F2);
        
        return footview;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    CourseHeadView *courseView = [[CourseHeadView alloc]init];
    courseView.frame = CGRectMake(0, 0, SCREENWIDTH, 200*SCREENWIDTH/375+40);
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"分类"];
    for (CourseSortRes *model in self.sortArr) {
        if (model.columnName) {
            [arr addObject:model.columnName];
        }
    }
    [courseView.selectorView setDataArr:arr];
    [courseView.selectorView setCurrentPage:self.currentIndex];
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (BannerRes *model in self.bannerArr) {
        if (model.bannerImagePath) {
            [imageArr addObject:model.bannerImagePath];
        }
    }
    [courseView.cycleView  setImageUrlGroups:imageArr];
    courseView.cycleView.delegate = self;
    __weak typeof(self)weakself = self;
    [courseView setSelectedBlock:^(NSInteger index) {
        weakself.currentIndex = index;
        if (index ==0) {
            SortViewController *sortVC = [[SortViewController alloc]init];
            sortVC.hidesBottomBarWhenPushed = YES;
            [sortVC setCurrentTitle:@""];
            [weakself.navigationController pushViewController:sortVC animated:YES];
        }else{
            CourseSortRes *model = weakself.sortArr[index-1];
            [weakself getCourseList:model.columnId];
        }
    }];
    [headerView addSubview:courseView];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeGivingCell *givecell = [collectionView dequeueReusableCellWithReuseIdentifier:givecellIds forIndexPath:indexPath];
    FreeListRes *model = self.courseArr[indexPath.row];
    [givecell setModel:model];
    return givecell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FreeListRes *model = self.courseArr[indexPath.row];
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
-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    BannerRes*resmodel = self.bannerArr[row];
    if ([resmodel.bannerType isEqualToString:@"course"]) {
        FreeListRes *model = [[FreeListRes alloc]init];
        DetailCourseController *courseVC = [[DetailCourseController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        model.courseId = resmodel.bannerTypeId;
        model.courseCategoryId = @"1044405524206198785";
        model.columnId = resmodel.bannerTypeId;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
    }else if ([resmodel.bannerType isEqualToString:@"article"]){
        TodayListRes *model1 = [[TodayListRes alloc]init];
        DetailArticleController *courseVC = [[DetailArticleController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        model1.articleId = resmodel.bannerTypeId;
        model1.columnId = @"1043064375499591682";
        [courseVC setModel:model1];
        [self.navigationController pushViewController:courseVC animated:YES];
    }else if ([resmodel.bannerType isEqualToString:@"service"]){
        DetailServiceController *serviceVC = [[DetailServiceController alloc]init];
        ServiceListRes *model = [[ServiceListRes alloc]init];
        model.columnId = @"1043064325939695618";
        model.siheserviceId = resmodel.bannerTypeId;
        serviceVC.hidesBottomBarWhenPushed = YES;
        [serviceVC setModel:model];
        [self.navigationController pushViewController:serviceVC animated:YES];
    }
    
}

@end
