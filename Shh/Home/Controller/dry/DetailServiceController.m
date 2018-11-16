//
//  DetailServiceController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailServiceController.h"
#import "HomeNowCell.h"
#import "ServiceDetailView.h"
#import "HomeServiceApi.h"
#import "DetailArticleController.h"

@interface DetailServiceController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic,strong)DetailServiceRes *resultModel;
@property(nonatomic,assign)CGFloat height;

@end
static NSString *nowcellIds = @"HomeNowCell";
@implementation DetailServiceController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeNowCell class] forCellWithReuseIdentifier:nowcellIds];
        
        _collectionView.backgroundColor = DSColorFromHex(0xFAFAFA);
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
-(void)setModel:(ServiceListRes *)model{
    _model = model;
    self.dataArr = [NSMutableArray array];
     self.height = 10;
    self.title = @"服务详情";
    [self getService];
}
-(void)getService{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.siheserviceId = _model.siheserviceId;
    req.courseCategoryId = @"";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getServiceDetailWithParam:req response:^(id response) {
        if (response) {
           
            weakself.resultModel = response;
            [weakself.collectionView reloadData];
        }
        [weakself getArticleList:@"1043064325939695618"];
        
    }];
}
-(void)getArticleList:(NSString*)colmunid{
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
    [[HomeServiceApi share]getTodayListWithParam:req response:^(id response) {
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
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
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
    ServiceDetailView* validView = [[ServiceDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [ServiceDetailView getCellHeight:self.resultModel])];
    [validView setResultModel:self.resultModel];
   
    [headerView addSubview:validView];
    return headerView;
    
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
    
    
    
    return CGSizeMake(SCREENWIDTH, [ServiceDetailView getCellHeight:self.resultModel]);
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeNowCell *nowcell = [collectionView dequeueReusableCellWithReuseIdentifier:nowcellIds forIndexPath:indexPath];
    TodayListRes *model = self.dataArr[indexPath.row];
    [nowcell setModel:model];
    return nowcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailArticleController *detailVC = [[DetailArticleController alloc]init];
    TodayListRes *model = self.dataArr[indexPath.row];
    [detailVC setModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
