//
//  HelpCenterController.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "HelpCenterController.h"
#import "MineServiceApi.h"
#import "HelpCell.h"

@interface HelpCenterController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation HelpCenterController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.dataArr = [[NSMutableArray alloc]init];
    [self requestData];
}
-(void)requestData{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.token = [UserCacheBean share].userInfo.token;
    req.pageIndex = 1;
    req.pageSize = @"5";
    __weak typeof(self)wealself = self;
    [[MineServiceApi share] getHelpListWithParam:req response:^(id response) {
        if (response) {
            [wealself.dataArr removeAllObjects];
            [wealself.dataArr addObjectsFromArray:response];
            [wealself.tableview reloadData];
        }
    }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"思和会"];
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpRes *model = self.dataArr[indexPath.row];
    return model.height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"HelpCell";
    HelpCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HelpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    HelpRes *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    __weak typeof(self)weakself = self;
    [cell setHeightBlock:^(HelpRes * model) {
        [weakself.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        [weakself.tableview reloadData];
    }];
    return cell;
}
@end
