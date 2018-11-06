//
//  AllServiceListController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AllServiceListController.h"
#import "ToJoinCell.h"

#import "ServiceApi.h"
@interface AllServiceListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation AllServiceListController

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    [self.view addSubview:self.tableview];
    
}
-(void)setIndex:(NSInteger)index{
    [self getService:index];
}
-(void)setTitles:(NSString *)titles{
    self.title = titles;
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
    req.pageSize = @"100";
    __weak typeof(self)weakself = self;
    [[ServiceApi share]getServiceListWithParam:req response:^(id response) {
        if (response) {
            
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            
            [weakself.tableview reloadData];
        }
        
    }];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 209;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"ToJoinCell";
    ToJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[ToJoinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    ServiceListRes *model =self.dataArr[indexPath.row];
    [cell setModel:model];
    return cell;
    
}

@end
