//
//  DryHeadlinesController.m
//  Shh
//
//  Created by dnaer7 on 2018/10/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DryHeadlinesController.h"
#import "NavigationView.h"
#import "DryNoImageCell.h"
#import "DryBigImageCell.h"
#import "DrySmallImageCell.h"
#import "ZSSortSelectorView.h"
#import "CourseServiceApi.h"
#import "HomeServiceApi.h"
#import "DetailArticleController.h"
#import "HistoryBaseController.h"
#import "SearchController.h"

@interface DryHeadlinesController ()<UITableViewDelegate,UITableViewDataSource,ZSSortSelectorViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong)NavigationView *navView;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property (nonatomic, strong)NSMutableArray *sortArr;
@property (nonatomic, strong)NSMutableArray *articleArr;

@end

@implementation DryHeadlinesController
-(NavigationView *)navView{
    if (!_navView) {
        _navView = [[NavigationView alloc]init];
        _navView.frame = CGRectMake(0, 0, SCREENWIDTH, [self navHeightWithHeight]);
        [_navView setLeftWidth:45];
    }
    return _navView;
}
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 40)];
        _selectorView.delegate = self;
        
    }
    return _selectorView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight]+40, SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.selectorView];
    [self.view addSubview:self.tableview];
    self.sortArr = [NSMutableArray array];
    self.articleArr = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    [self.navView setLeftBlock:^{
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
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
    [self getCourseSort];
}
-(void)getCourseSort{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.articleOrCourseType = @"article";
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[CourseServiceApi share]courseSortDirectoryWithParam:req response:^(id response) {
        if (response) {
            [weakself.sortArr removeAllObjects];
            [weakself.sortArr addObjectsFromArray:response];
            
            CourseSortRes *first = [response firstObject];
            NSMutableArray *arr = [NSMutableArray array];
            for (CourseSortRes *model in response) {
                if (model.columnName) {
                    [arr addObject:model.columnName];
                }
            }
            [weakself.selectorView setDataArr:arr];
            [weakself getArticleList:first.columnId];
            [weakself.tableview reloadData];
        }
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
            [weakself.articleArr removeAllObjects];
            [weakself.articleArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
       
    }];
    
    
}
-(void)chooseButtonType:(NSInteger)type{
    CourseSortRes *model = self.sortArr[type];
    [self getArticleList:model.columnId];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayListRes *model = self.articleArr[indexPath.row];
    if ([model.articleImagePosition isEqualToString:@"cover"]) {
        return 370;
    }else if ([model.articleImagePosition isEqualToString:@"right"]){
        return 183;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.articleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayListRes *model = self.articleArr[indexPath.row];
    if ([model.articleImagePosition isEqualToString:@"cover"]) {
        static NSString *identify = @"DryBigImageCell";
        DryBigImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[DryBigImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        [cell setModel:model];
        return cell;
    }
    static NSString *identify = @"DrySmallImageCell";
    DrySmallImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[DrySmallImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setModel:model];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailArticleController *detailVC = [[DetailArticleController alloc]init];
    TodayListRes *model = self.articleArr[indexPath.row];
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
