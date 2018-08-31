//
//  HomeController.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeController.h"
#import "HomeFreeCell.h"
#import "HomeHeadView.h"
#import "HomeNowCell.h"
#import "HomeGivingCell.h"
#import "HomeLikeCell.h"
#import "HomeFreeHeadView.h"
#import "NavigationView.h"
#import "SortViewController.h"
#import "MoreSortViewController.h"
#import "PromoteServiceView.h"
#import "DryHeadlinesController.h"

@interface HomeController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)HomeHeadView *headView;
@property (nonatomic, strong)NavigationView *navView;
@end
static NSString *freecellIds = @"HomeFreeCell";
static NSString *nowcellIds = @"HomeNowCell";
static NSString *givecellIds = @"HomeGivingCell";
static NSString *likecellIds = @"HomeLikeCell";
@implementation HomeController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[HomeFreeCell class] forCellWithReuseIdentifier:freecellIds];
        [_collectionView registerClass:[HomeNowCell class] forCellWithReuseIdentifier:nowcellIds];
        [_collectionView registerClass:[HomeGivingCell class] forCellWithReuseIdentifier:givecellIds];
        [_collectionView registerClass:[HomeLikeCell class] forCellWithReuseIdentifier:likecellIds];
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
    self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
       
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==4) {
        return 6;
    }
    return 3;
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
    
    return 0;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==3){
        return CGSizeMake(SCREENWIDTH, 318);
    }else if (indexPath.section ==4){
         return CGSizeMake(SCREENWIDTH/3, 176);
    }else if (indexPath.section ==5){
         return CGSizeMake(SCREENWIDTH/2, 160);
    }
    return CGSizeMake(SCREENWIDTH, 115);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    if(section ==0){
        return CGSizeMake(SCREENWIDTH, 270);
    }else if (section ==5){
        return CGSizeMake(SCREENWIDTH, 305);
    }
    return CGSizeMake(SCREENWIDTH, 55);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==5) {
        return CGSizeMake(SCREENWIDTH, 50);
    }
    return CGSizeMake(SCREENWIDTH, 0);
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
    
    
    
    if(indexPath.section ==0){
        HomeHeadView* validView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 270)];
        
        [headerView addSubview:validView];
        [validView setSelectedBlock:^(NSInteger index) {
            if (index ==4) {
                MoreSortViewController *moreVC = [[MoreSortViewController alloc]init];
                moreVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:moreVC animated:YES];
            }else if (index ==0){
                DryHeadlinesController *dryVC = [[DryHeadlinesController alloc]init];
                dryVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:dryVC animated:YES];
            }
        }];
    }else if (indexPath.section ==5){
        PromoteServiceView *promoteView = [[PromoteServiceView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 305)];
        [headerView addSubview:promoteView];
    }else{
        HomeFreeHeadView *freeview = [[HomeFreeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
        [headerView addSubview:freeview];
        switch (indexPath.section) {
                case 1:
            {
                freeview.titleLabel.text = @"今日干货";
            }
                break;
                case 2:
            {
                freeview.titleLabel.text = @"精品微课";
            }
                break;
                case 3:
            {
                freeview.titleLabel.text = @"会员大课";
            }
                break;
                case 4:
            {
                freeview.titleLabel.text = @"猜你喜欢";
            }
                break;
            default:
                break;
        }
    }
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeFreeCell *freecell = [collectionView dequeueReusableCellWithReuseIdentifier:freecellIds forIndexPath:indexPath];
    HomeNowCell *nowcell = [collectionView dequeueReusableCellWithReuseIdentifier:nowcellIds forIndexPath:indexPath];
    HomeGivingCell *givecell = [collectionView dequeueReusableCellWithReuseIdentifier:givecellIds forIndexPath:indexPath];
    HomeLikeCell *likecell = [collectionView dequeueReusableCellWithReuseIdentifier:likecellIds forIndexPath:indexPath];
    
    switch (indexPath.section) {
            case 0:
            {
               return freecell;
            }
            break;
            case 1:
        {
            return nowcell;
        }
            break;
            case 2:
        {
            return freecell;
        }
            break;
            case 3:
        {
            return givecell;
        }
            break;
            case 4:
        {
            [likecell setImageWidth:110];
            [likecell setImageHeight:110];
            
            return likecell;
        }
            break;
            case 5:
        {
            [likecell setImageWidth:165];
            [likecell setImageHeight:110];
            likecell.nameLabel.text = @"加入思和会";
            return likecell;
        }
            break;
        default:
            break;
    }
    
    
    return freecell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SortViewController *sortVC = [[SortViewController alloc]init];
    sortVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sortVC animated:YES];
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
