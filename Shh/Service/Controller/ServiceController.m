//
//  ServiceController.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ServiceController.h"
#import "QualityServiceCell.h"
#import "TrainingServicesCell.h"
#import "ToJoinCell.h"
#import "HomeFreeHeadView.h"
#import "ServiceHeadView.h"
#import "NavigationView.h"
#import "HomeServiceApi.h"
#import "ServiceApi.h"

@interface ServiceController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ServiceHeadView *headview;
@property (nonatomic, strong)NavigationView *navView;
@property(nonatomic,strong)NSMutableArray *goodArr;
@property(nonatomic,strong)NSMutableArray *trainArr;
@property(nonatomic,strong)NSMutableArray *activityArr;
@property(nonatomic,strong)NSMutableArray *joinArr;
@end

@implementation ServiceController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

-(ServiceHeadView *)headview{
    if (!_headview) {
        _headview = [[ServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 235)];
        
    }
    return _headview;
}
-(NavigationView *)navView{
    if (!_navView) {
        _navView = [[NavigationView alloc]init];
        _navView.frame = CGRectMake(0, 0, SCREENWIDTH, [self navHeightWithHeight]);
        [_navView setLeftWidth:15];
    }
    return _navView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    self.tableview.tableHeaderView = self.headview;
    [self.view addSubview:self.navView];
     self.goodArr = [NSMutableArray array];
     self.trainArr = [NSMutableArray array];
     self.activityArr = [NSMutableArray array];
     self.joinArr = [NSMutableArray array];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [self getBannerList:@"wxService"];
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
            NSMutableArray *arr  = [NSMutableArray array];
            for (BannerRes *model in response) {
                if (model.bannerImagePath) {
                    [arr addObject:model.bannerImagePath];
                }
            }
            [weakself.headview.cycleView setImageUrlGroups:arr];
        }
        [weakself getService:0];
    }];
}
-(void)getService:(NSInteger)index{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    if (index==0) {
        req.columnId = @"1045875275674472450";
    }else if (index ==1){
        req.columnId = @"1045942000354193409";
    }else if (index ==2){
        req.columnId = @"1045942106063237121";
    }else if (index ==3){
        req.columnId = @"1045942150409613313";
    }
    req.pageIndex = 1;
    req.pageSize = @"10";
    __weak typeof(self)weakself = self;
    [[ServiceApi share]getServiceListWithParam:req response:^(id response) {
        if (response) {
            if (index ==0) {
                [weakself.goodArr removeAllObjects];
                [weakself.goodArr addObjectsFromArray:response];
            }else if (index ==1) {
                [weakself.trainArr removeAllObjects];
                [weakself.trainArr addObjectsFromArray:response];
            }else if (index ==2) {
                [weakself.activityArr removeAllObjects];
                [weakself.activityArr addObjectsFromArray:response];
            }else if (index ==3) {
                [weakself.joinArr removeAllObjects];
                [weakself.joinArr addObjectsFromArray:response];
            }
            [weakself.tableview reloadData];
        }
        if (index ==0) {
            [weakself getService:1];
        }else if (index ==1) {
            [weakself getService:2];
        }else if (index ==2) {
            [weakself getService:3];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==3) {
        return 209;
    }
    return 115;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0||section ==2) {
        return 1;
    }
    if (section ==1) {
        return self.trainArr.count;
    }
    return self.joinArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeFreeHeadView *freeview = [[HomeFreeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 55)];
    if (section ==0) {
        freeview.titleLabel.text = @"精品服务";
    }else if (section ==1){
        freeview.titleLabel.text = @"培训服务";
    }else if (section ==1){
        freeview.titleLabel.text = @"活动执行";
    }else if (section ==1){
        freeview.titleLabel.text = @"招商加盟";
    }
    return freeview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        static NSString *identify = @"TrainingServicesCell";
        TrainingServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[TrainingServicesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        ServiceListRes *model =self.trainArr[indexPath.row];
        [cell setModel:model];
        return cell;
    }else if (indexPath.section ==3){
        static NSString *identify = @"ToJoinCell";
        ToJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ToJoinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        ServiceListRes *model =self.joinArr[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    static NSString *identify = @"QualityServiceCell";
    QualityServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[QualityServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        [cell setDataArr:self.goodArr];
    }else if (indexPath.section ==2){
        [cell setDataArr:self.activityArr];
    }
    return cell;
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
