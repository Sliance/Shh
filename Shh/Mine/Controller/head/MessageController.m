//
//  MessageController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/16.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MessageController.h"
#import "MineServiceApi.h"
#import "MessageListCell.h"
#import "EmptyView.h"

@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)EmptyView*emptyView;
@end

@implementation MessageController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"思和会"];
        
    }
    return self;
}
-(EmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[EmptyView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENWIDTH)];
        _emptyView.image.image = [UIImage imageNamed:@"empty_homework"];
        _emptyView.titleLabel.text = @"暂无消息";
        _emptyView.hidden = YES;
    }
    return _emptyView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.emptyView];
    [self.tableview registerClass:[MessageListCell class] forCellReuseIdentifier:NSStringFromClass([MessageListCell class])];
    self.dataArr = [NSMutableArray array];
    [self requestData];
}

-(void)requestData{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getMessageListWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            if (weakself.dataArr.count ==0) {
                weakself.emptyView.hidden = NO;
            }
            [weakself.tableview reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageListCell*cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageRes*model = self.dataArr[indexPath.row];
    [cell setModel:model];
    return cell;
}

@end
