//
//  SortViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortViewController.h"
#import "SortLeftScrollow.h"

#import "HomeLikeCell.h"
#import "HomeServiceApi.h"

@interface SortViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,SortLeftScrollowDelegate>

@property(nonatomic,strong)SortLeftScrollow *sortLeftView;
@property (nonatomic, strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *courseArr;
@property(nonatomic,strong)NSMutableArray *detailDataArr;
@property(nonatomic,assign)NSInteger headIndex;
@end
static NSString *cellId = @"HomeLikeCell";
@implementation SortViewController

-(SortLeftScrollow *)sortLeftView{
    if (!_sortLeftView) {
        _sortLeftView = [[SortLeftScrollow alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], 80, SCREENHEIGHT-[self navHeightWithHeight])];
        _sortLeftView.delegate = self;
    }
    return _sortLeftView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"分类"];
//       [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
  
   [self.view addSubview:self.sortLeftView];
    _dataArr = [NSMutableArray array];
    self.courseArr = [NSMutableArray array];
    _detailDataArr = [NSMutableArray array];
  
    
   
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];

    layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 15);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(80, [self navHeightWithHeight], SCREENWIDTH-80, SCREENHEIGHT-[self navHeightWithHeight]) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[HomeLikeCell class] forCellWithReuseIdentifier:cellId];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
     [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.collectionView
     registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    
    
   
    
}
-(void)setCurrentTitle:(NSString *)currentTitle{
    _currentTitle = currentTitle;
     [self getSortList];
}
-(void)getSortList{
    BaseModelReq *req = [[BaseModelReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = @"";
    req.timestamp = @"0";
    req.platform = @"wechat";
    req.cityName = @"上海市";
    req.version = @"1.0.0";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share] getMoreSortWithParam:req response:^(id response) {
        if (response) {
          NSArray *result =   [MoreSortRes mj_objectArrayWithKeyValuesArray:response[@"courseCategoryList"]];
            [weakself.dataArr  removeAllObjects];
            [weakself.dataArr addObjectsFromArray:result];
            NSMutableArray *arr = [NSMutableArray array];
            for (MoreSortRes *model in result) {
                if (model.courseCategoryName) {
                    [arr addObject:model.courseCategoryName];
                }
                if ([model.courseCategoryName isEqualToString:weakself.currentTitle]) {
                    [weakself getCourseList:model.courseCategoryId];
                }
            }
            MoreSortRes *firstmodel = [weakself.dataArr firstObject];
            if (weakself.currentTitle.length>0) {
                 [weakself.sortLeftView setCurrentTitle:weakself.currentTitle];
            }else{
                 [weakself getCourseList:firstmodel.courseCategoryId];
            }
            
            [weakself.sortLeftView setDataArr:arr];
        }
    }];
}
-(void)getCourseList:(NSString*)colmunid{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.columnId = @"";
    req.courseCategoryId = colmunid;
    req.pageIndex = 1;
    req.pageSize = @"1000";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getFineClassWithParam:req response:^(id response) {
        if (response) {
            [weakself.courseArr removeAllObjects];
            [weakself.courseArr addObjectsFromArray:response];
        }
        [weakself.collectionView reloadData];
    }];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.courseArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 0,0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -10;
}



//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH/2-40, 125);
    
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];


    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }

    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setImageWidth:125];
    [cell setImageHeight:71];
    FreeListRes *model = self.courseArr[indexPath.row];
    [cell setFreeModel:model];
    cell.nameLabel.numberOfLines = 2;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark--SortLeftScrollowDelegate
-(void)selectedSortIndex:(NSInteger)index{
    
    _headIndex = index;
    MoreSortRes *model= self.dataArr[index];
    [self getCourseList:model.courseCategoryId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
