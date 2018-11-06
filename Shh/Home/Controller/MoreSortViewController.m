//
//  MoreSortViewController.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/30.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MoreSortViewController.h"
#import "MoreSortCollectionCell.h"
#import "HomeServiceApi.h"
#import "CourseSortRes.h"
#import "SortViewController.h"
#import "ArticleListController.h"
#import "CourseListController.h"

@interface MoreSortViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *courseArr;


@end
static NSString *morecellIds = @"MoreSortCollectionCell";
@implementation MoreSortViewController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, [self navHeightWithHeight], SCREENWIDTH-30, SCREENHEIGHT-[self navHeightWithHeight]) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MoreSortCollectionCell class] forCellWithReuseIdentifier:morecellIds];
        
        _collectionView.backgroundColor = DSColorFromHex(0xFAFAFA);
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"更多分类"];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _dataArr = [NSMutableArray array];
    self.courseArr = [NSMutableArray array];
    [self.view addSubview:self.collectionView];
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
            NSArray *result1 =   [CourseSortRes mj_objectArrayWithKeyValuesArray:response[@"columnList"]];
            [weakself.dataArr  removeAllObjects];
            [weakself.dataArr addObjectsFromArray:result];
            [weakself.courseArr  removeAllObjects];
            for (CourseSortRes *model in result1) {
                if (([model.articleOrCourseType isEqualToString:@"article"]||[model.articleOrCourseType isEqualToString:@"course"])&&![model.columnName isEqualToString:@"思和快讯"]) {
                    [weakself.courseArr addObject:model];
                }
            }
        
            
        }
        [weakself.collectionView reloadData];
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==0) {
        return self.dataArr.count;
    }
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
    
    return 5;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREENWIDTH/3-10, 43);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    
    return CGSizeMake(SCREENWIDTH, 50);
    
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-30, 50)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = DSColorFromHex(0x474747);
    label.font = [UIFont boldSystemFontOfSize:18];;
    [headerView addSubview:label];
    if (indexPath.section ==0) {
        label.text = @"课程分类";
    }else if (indexPath.section ==1){
        label.text = @"栏目分类";
    }
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreSortCollectionCell *freecell = [collectionView dequeueReusableCellWithReuseIdentifier:morecellIds forIndexPath:indexPath];
    if (indexPath.section ==0) {
        MoreSortRes *model = self.dataArr[indexPath.row];
        freecell.titleLabel.text = model.courseCategoryName;
    }else if (indexPath.section ==1){
        CourseSortRes *model = self.courseArr[indexPath.row];
        freecell.titleLabel.text = model.columnName;
    }
    return freecell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        SortViewController *sortVC = [[SortViewController alloc]init];
        MoreSortRes *model = self.dataArr[indexPath.row];
        [sortVC setCurrentTitle:model.courseCategoryName];
        sortVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sortVC animated:YES];
    }else if (indexPath.section ==1){
        CourseSortRes *model = self.courseArr[indexPath.row];
        if ([model.articleOrCourseType isEqualToString:@"article"]) {
            ArticleListController *articleVC = [[ArticleListController alloc]init];
            [articleVC setModel:model];
            [self.navigationController pushViewController:articleVC animated:YES];
        }else if ([model.articleOrCourseType isEqualToString:@"course"]){
            CourseListController *courseVC = [[CourseListController alloc]init];
            [courseVC setModel:model];
            [self.navigationController pushViewController:courseVC animated:YES];
        }
    }
   
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
