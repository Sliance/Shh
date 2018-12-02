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

@interface MineFollowController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MineFollowController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    _dataArr = [[NSMutableArray alloc]init];
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
                [weakself.dataArr addObjectsFromArray:response];
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
    return self.dataArr.count;
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
    FollowRes *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    return cell;
}
@end
