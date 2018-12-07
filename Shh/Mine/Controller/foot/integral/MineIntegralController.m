//
//  MineIntegralController.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MineIntegralController.h"
#import "IntegralHeadView.h"
#import "MineServiceApi.h"
#import "IntegralCell.h"
#import "IntegralRankCell.h"
#import "PromoteQrController.h"

@interface MineIntegralController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)IntegralHeadView* headView;
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSMutableArray* detailArr;
@property(nonatomic,strong)NSMutableArray* rankArr;
@property(nonatomic,strong)NSMutableArray* taskArr;
@property(nonatomic,strong)NSMutableArray* task1Arr;
@end

@implementation MineIntegralController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:@"我的积分"];
        
    }
    return self;
}
-(IntegralHeadView *)headView{
    if (!_headView) {
        _headView = [[IntegralHeadView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 180*SCREENWIDTH/375+50)];
    }
    return _headView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.type = 0;
    [self.headView.selectorView setCurrentPage:0];
    [self requestDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.detailArr = [[NSMutableArray alloc]init];
    self.rankArr = [[NSMutableArray alloc]init];
    [self.tableview registerClass:[IntegralCell class] forCellReuseIdentifier:NSStringFromClass([IntegralCell class])];
    [self.tableview registerClass:[IntegralRankCell class] forCellReuseIdentifier:NSStringFromClass([IntegralRankCell class])];
    self.taskArr = [NSMutableArray arrayWithObjects:@"分享APP+1",@"分享干活+1",@"分享课程+1",@"分享服务+1", nil];
    self.task1Arr = [NSMutableArray arrayWithObjects:@"推荐入会+50",@"注册ApPP+2",@"完善个人资料+2", nil];
    __weak typeof(self)weakself = self;
    [self.headView setChooseBlock:^(NSInteger index) {
        weakself.type = index;
        if (index == 0) {
            [weakself requestDetail];
        }else if (index ==1){
            [weakself requestTask];
        }else if (index ==2){
            [weakself requestRank];
        }
    }];
    [self.headView setShareBlock:^{
        PromoteQrController *qrVC = [[PromoteQrController alloc]init];
        [weakself.navigationController pushViewController:qrVC animated:YES];
    }];
}
-(void)requestDetail{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getIntegralDetailWithParam:req response:^(id response) {
        if (response) {
            [weakself.detailArr removeAllObjects];
            [weakself.detailArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
    }];
}
-(void)requestTask{
    [self.tableview reloadData];
}
-(void)requestRank{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getIntegralRankWithParam:req response:^(id response) {
        if (response) {
            [weakself.rankArr removeAllObjects];
            [weakself.rankArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type ==0) {
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type ==0) {
        return self.detailArr.count;
    }else if (self.type ==1){
        if (section ==0) {
            return self.taskArr.count;
        }else if (section ==1){
            return self.task1Arr.count;
        }
    }else if (self.type ==2){
        if (section ==0) {
            return 1;
        }else if (section ==1){
            return self.rankArr.count;
        }
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.type ==1) {
        if (section ==0) {
            return 0;
        }
        return 50;
    }else if (self.type ==2){
        if (section ==0) {
            return 0;
        }
        return 0;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type ==1) {
        if (section ==0) {
            return 30;
        }
        return 30;
    }else if (self.type ==2){
        if (section ==0) {
            return 0;
        }
        return 10;
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.type ==1) {
        if (section ==0) {
            return @"日常任务";
        }else if (section ==1){
            return @"特殊任务";
        }
    }
    return @"";
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type ==0) {
         IntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralCell class])];
        IntegralRes*model = self.detailArr[indexPath.row];
        [cell setModel:model];
        return cell;
    }else if (self.type ==1){
        static NSString *identify = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = DSColorFromHex(0x464646);
        if (indexPath.section ==0) {
            cell.textLabel.text = self.taskArr[indexPath.row];
            cell.detailTextLabel.text = @"未完成";
            cell.detailTextLabel.textColor = DSColorFromHex(0x969696);
        }else if (indexPath.section ==1){
            cell.textLabel.text = self.task1Arr[indexPath.row];
            if (indexPath.row ==1) {
                cell.detailTextLabel.text = @"未完成";
                cell.detailTextLabel.textColor = DSColorFromHex(0x969696);
            }else{
                cell.detailTextLabel.text = @"点击前往";
                cell.detailTextLabel.textColor = [UIColor redColor];
            }
        }
        return cell;
    }
    IntegralRankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralRankCell class])];
    
    if (indexPath.section ==1) {
        IntegralRes*model = self.rankArr[indexPath.row];
        [cell setModel:model];
        cell.integralLabel.textColor = DSColorFromHex(0x464646);
    }else if (indexPath.section ==0){
        for (IntegralRes*model in self.rankArr) {
            if ([model.memberId isEqualToString:[UserCacheBean share].userInfo.memberId]) {
                cell.titleLabel.text = @"";
                cell.detailLabel.text = [NSString stringWithFormat:@"第%@名",model.rank];
                NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.memberAvatarPath];
                [cell.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine"]];
                cell.integralLabel.text = model.integral;
                cell.integralLabel.textColor = [UIColor redColor];
            }
        }
       
    }
    return cell;
}
@end