//
//  FollowDetailController.m
//  Shh
//
//  Created by zhangshu on 2018/12/5.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "FollowDetailController.h"
#import "DetailFollowHeadView.h"
#import "MineServiceApi.h"
#import "DetailCourseController.h"
#import "DetailServiceController.h"
#import "DetailArticleController.h"
#import "HistorysCell.h"
#import "HomeServiceApi.h"

@interface FollowDetailController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)DetailFollowHeadView *headView;
@property(nonatomic,assign)NSInteger type;
@end

static NSString *freecellIds = @"HistorysCell";

@implementation FollowDetailController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:@"思和会"];
        
    }
    return self;
}
-(DetailFollowHeadView *)headView{
    if (!_headView) {
        _headView = [[DetailFollowHeadView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, 250)];
    }
    return _headView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HistorysCell class] forCellWithReuseIdentifier:freecellIds];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.collectionView];
    __weak typeof(self)weakself = self;
    [self.headView setChooseBlock:^(NSInteger type) {
        weakself.type = type;
        if (weakself.index ==0) {
            [weakself getCourse];
        }else{
            if (type ==0) {
                [weakself getArticle];
            }else if (type ==1){
                [weakself getService];
            }
        }
    }];
    [self.headView setFouceBlock:^{
        [weakself getFollow];
    }];
}
-(void)setTeacherMemberId:(NSString *)teacherMemberId{
    _teacherMemberId = teacherMemberId;
   
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index ==0) {
        [self.headView.selectorView setDataArr:@[@"课程"]];
         [self requestData];
    }else if (index ==1){
        [self.headView.selectorView setDataArr:@[@"文章",@"服务"]];
        [self requestCompany];
    }
}
-(void)getFollow{
    FollowReq *req = [[FollowReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.version = @"1.0.0";
    req.cityName = @"上海市";
    req.beFollowId = self.teacherMemberId;
    req.type = @"member";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]followWithParam:req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
            if ([response[@"code"]integerValue] ==200  ) {
                if (weakself.headView.fouceBtn.selected ==NO) {
                    weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
                    weakself.headView.fouceBtn.selected = YES;
                }else{
                    weakself.headView.fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
                    weakself.headView.fouceBtn.selected = NO;
                }
            }
        }
    }];
}
-(void)requestCompany{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.companySettledId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getCompanyInfoWithParam:req response:^(id response) {
        if (response) {
            [weakself.headView setModel:response];
        }
        [weakself getArticle];
    }];
}
-(void)getService{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.teacherMemberId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getCompanyServiceWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
    }];
}
-(void)requestData{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.teacherMemberId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getTeacherInfoWithParam:req response:^(id response) {
        if (response) {
            [weakself.headView setModel:response];
        }
        [weakself getCourse];
       
    }];
}
-(void)getArticle{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.teacherMemberId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getTeacherArticleWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
    }];
}
-(void)getCourse{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.teacherMemberId = self.teacherMemberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getTeacherCourseWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
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
    return UIEdgeInsetsMake(20, 0, 0, 0);
    
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
    
    
    
    return CGSizeMake(SCREENWIDTH, 250);
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HistorysCell *freecell = [collectionView dequeueReusableCellWithReuseIdentifier:freecellIds forIndexPath:indexPath];
    if (self.type ==0&&self.index ==1) {
         TodayListRes *model = self.dataArr[indexPath.row];
        [freecell setArticleModel:model];
    }else if (self.type ==0&&self.index ==0){
        FreeListRes*model = self.dataArr[indexPath.row];
        [freecell setCoursemodel:model];
    }else if (self.type ==1&&self.index ==1){
        FreeListRes*model = self.dataArr[indexPath.row];
        [freecell setCoursemodel:model];
    }

    return freecell;
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
    [headerView addSubview:self.headView];
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type ==0&&self.index ==1) {
        TodayListRes *model = self.dataArr[indexPath.row];
        DetailArticleController *detailVC = [[DetailArticleController alloc]init];
        [detailVC setModel:model];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (self.type ==0&&self.index ==0 ){
        FreeListRes *model  = self.dataArr[indexPath.row];
        DetailCourseController *courseVC = [[DetailCourseController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
        
    }else if (self.type ==1&&self.index ==1 ){
        ServiceListRes *model  = self.dataArr[indexPath.row];
        DetailServiceController *courseVC = [[DetailServiceController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
        
    }
   
   
    
}
@end
