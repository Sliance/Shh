//
//  SearchController.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SearchController.h"
#import "SearchHeadView.h"
#import "HomeServiceApi.h"
#import "DetailArticleController.h"
#import "HomeFreeCell.h"
#import "DetailCourseController.h"
#import "ZSSortSelectorView.h"
@interface SearchController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,ZSSortSelectorViewDelegate>
@property(nonatomic,strong)SearchHeadView *searchView;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray  *dataArr;
@property(nonatomic,strong)NSMutableArray  *searchArr;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,assign)NSInteger currentIndex;
@end
static NSString *freecellIds = @"HomeFreeCell";
@implementation SearchController
-(SearchHeadView *)searchView{
    if (!_searchView) {
        _searchView = [[SearchHeadView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, 45)];
        
    }
    return _searchView;
}
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0,  [self navHeightWithHeight]+45, SCREENWIDTH, 40)];
        _selectorView.delegate = self;
       
        
    }
    return _selectorView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight]+50, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight]+95, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeFreeCell class] forCellWithReuseIdentifier:freecellIds];
        _collectionView.hidden = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [_collectionView
         registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footreusableView"];
    }
    return _collectionView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"搜索";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.selectorView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.searchView];
    self.dataArr = [[NSMutableArray alloc]init];
    self.searchArr = [[NSMutableArray alloc]init];
    [self.selectorView setDataArr:@[@"课程",@"文章"]];
    [self.selectorView setCurrentPage:self.currentIndex];
    [self setTextFieldLeftView:self.searchView.searchField :@"search_home" :37];
    [self requestData];
    __weak typeof(self)weakself = self;
    [self.searchView setCancleBlock:^{
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    [self.searchView setEndBlock:^(NSString * text) {
        if (text.length >0) {
             weakself.tableview.hidden = YES;
            weakself.collectionView.hidden = NO;
            [weakself searchList:text type:@"course"];
        }else{
            weakself.tableview.hidden = NO;
            weakself.collectionView.hidden = YES;
        }
    }];
}
-(void)chooseButtonType:(NSInteger)type{
    if (type==0) {
         [self searchList:self.searchView.searchField.text type:@"course"];
    }else if (type ==1){
         [self searchList:self.searchView.searchField.text type:@"article"];
    }
}
-(void)searchList:(NSString*)title type:(NSString*)type{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.courseCategoryId = @"";
    req.courseTitle = title;
    req.searchType = type;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getSearchListWithParam:req response:^(id response) {
        if (response) {
            [weakself.searchArr removeAllObjects];
            [weakself.searchArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }else{
            
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
    req.pageSize = @"10";
    req.courseCategoryId = @"";
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]getHotSearchWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row ==0) {
        cell.textLabel.text = @"热门搜索";
    }else{
        HotSearchListRes *model = self.dataArr[indexPath.row-1];
        cell.textLabel.text = model.title;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     HotSearchListRes *model = self.dataArr[indexPath.row];
    if ([model.type isEqualToString:@"a"]) {
        TodayListRes *model1 = [[TodayListRes alloc]init];
        model1.articleId = model.id;
        DetailArticleController *detailVC = [[DetailArticleController alloc]init];
        [detailVC setModel:model1];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchArr.count;
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


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeFreeCell *freecell = [collectionView dequeueReusableCellWithReuseIdentifier:freecellIds forIndexPath:indexPath];
    FreeListRes *model = self.searchArr[indexPath.row];
    [freecell setModel:model];
    return freecell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FreeListRes *model = self.searchArr[indexPath.row];
    
        DetailCourseController *courseVC = [[DetailCourseController alloc]init];
        courseVC.hidesBottomBarWhenPushed = YES;
        [courseVC setModel:model];
        [self.navigationController pushViewController:courseVC animated:YES];
    
}

@end
