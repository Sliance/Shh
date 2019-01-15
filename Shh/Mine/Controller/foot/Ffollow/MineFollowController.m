//
//  MineFollowController.m
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineFollowController.h"
#import "MineServiceApi.h"
#import "FollowsCell.h"
#import "FollowDetailController.h"
#import "ZSSortSelectorView.h"

@interface MineFollowController ()<UITableViewDelegate,UITableViewDataSource,ZSSortSelectorViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *companyArr;
@property(nonatomic,strong)ZSSortSelectorView *selectorView;
@property(nonatomic,assign)NSInteger index;


@end

@implementation MineFollowController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight]+40, SCREENWIDTH, SCREENHEIGHT-40) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 40)];
        _selectorView.delegate = self;
        [self.selectorView setDataArr:@[@"讲师",@"企业"]];
        [self.selectorView setCurrentPage:self.index];
        
    }
    return _selectorView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.selectorView];
    _dataArr = [[NSMutableArray alloc]init];
    _companyArr = [[NSMutableArray alloc]init];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
      [self requestData];
}
-(void)requestData{
        FreeListReq *req = [[FreeListReq alloc]init];
        req.appId = @"1041622992853962754";
        req.token = [UserCacheBean share].userInfo.token;
        req.timestamp = @"0";
        req.platform = @"ios";
        req.pageIndex = 1;
        req.pageSize = @"100";
        req.memberId = [UserCacheBean share].userInfo.memberId;
        __weak typeof(self)weakself = self;
        [[MineServiceApi share]getFollowListWithParam:req response:^(id response) {
            if (response) {
                [weakself.dataArr removeAllObjects];
                [weakself.companyArr removeAllObjects];
                for (FollowRes *model in response) {
                    if ([model.followCategory isEqualToString:@"company"]) {
                        [self.companyArr addObject:model];
                    }else{
                        [self.dataArr addObject:model];
                    }
                }
                [weakself.tableview reloadData];
            }
        }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"我的关注"];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.index ==0) {
        return self.dataArr.count;
    }else if (self.index ==1){
        return self.companyArr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"FollowsCell";
    FollowsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[FollowsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    FollowRes *model;
    if (self.index ==0) {
        model  = self.dataArr[indexPath.row];
    }else if (self.index ==1){
        model = self.companyArr[indexPath.row];
    }
    
    [cell setModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FollowDetailController*detailVC = [[FollowDetailController alloc]init];
    FollowRes *model;
    if (self.index ==0) {
        model  = self.dataArr[indexPath.row];
    }else if (self.index ==1){
        model = self.companyArr[indexPath.row];
    }
    [detailVC setTeacherMemberId:model.beFollowMemberId];
    [detailVC setIndex:self.index];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)chooseButtonType:(NSInteger)type{
    self.index =type;
    [self.tableview reloadData];
}
@end
