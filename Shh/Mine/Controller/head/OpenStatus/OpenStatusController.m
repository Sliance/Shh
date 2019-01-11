//
//  OpenStatusController.m
//  Shh
//
//  Created by zhangshu on 2019/1/11.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "OpenStatusController.h"
#import "OpenStatusCell.h"
#import "MineServiceApi.h"
#import "AddMemberPayController.h"

@interface OpenStatusController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MemberInfoRes *result;

@end

@implementation OpenStatusController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"开通学籍"];
        
    }
    return self;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[OpenStatusCell class] forCellReuseIdentifier:NSStringFromClass([OpenStatusCell class])];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.tableFooterView = [[UIView alloc]init];
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
-(void)requestData{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.token = [UserCacheBean share].userInfo.token;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getMenberInfoWithParam:req response:^(id response) {
        if (response) {
            weakself.result = response;
            [weakself.tableview reloadData];
        }
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  180*(SCREENWIDTH-30)/345+10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OpenStatusCell*cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OpenStatusCell class])];
    if (indexPath.row ==0) {
        cell.titleLabel.text = @"研习社";
        cell.contentLabel.text = @"·100+往期课程免费看   ·全年50堂顶级课程更新";
        cell.detailLabel.text = @"·1年研习社学籍              ·APP每周三上线";
        cell.bgImage.image = [UIImage imageNamed:@"study_bg"];
        if (self.result.studyStatus ==0) {
            cell.dateLabel.text = @"尚未开通";
            [cell.openBtn setTitle:@"开通" forState:UIControlStateNormal];
            cell.openBtn.backgroundColor = DSColorFromHex(0xE70019);

        }else{
            [cell.openBtn setTitle:@"续费" forState:UIControlStateNormal];
            cell.openBtn.backgroundColor = DSColorFromHex(0xDEB279);
            NSString *date = [NSDate cStringFromTimestamp:self.result.studyEndTime Formatter:@"yyyy-mm-dd"];
            cell.dateLabel.text = [NSString stringWithFormat:@"有效期至%@",date];
        }
        WEAKSELF;
        [cell setOpenBlock:^{
            AddMemberPayController *addVC = [[AddMemberPayController alloc]init];
            addVC.hidesBottomBarWhenPushed = YES;
            [addVC setType:1];
            [weakSelf.navigationController pushViewController:addVC animated:YES];

        }];
    }else if (indexPath.row ==1){
        cell.titleLabel.text = @"总裁班";
        cell.contentLabel.text = @"·超过千个家居企业的选择 ·30万余家居人参加过";
        cell.detailLabel.text = @"·近3千商家实现千万业绩增长  ·近30商家突破1亿业绩规模";
        cell.detailLabel.font = [UIFont systemFontOfSize:12];
        cell.bgImage.image = [UIImage imageNamed:@"president_bg"];
        if (self.result.presidentStatus ==0) {
            cell.dateLabel.text = @"尚未开通";
            [cell.openBtn setTitle:@"开通" forState:UIControlStateNormal];
            cell.openBtn.backgroundColor = DSColorFromHex(0xE70019);
        }else{
            [cell.openBtn setTitle:@"续费" forState:UIControlStateNormal];
            cell.openBtn.backgroundColor = DSColorFromHex(0xDEB279);
            NSString *date = [NSDate cStringFromTimestamp:self.result.presidentEndTime Formatter:@"yyyy-mm-dd"];
            cell.dateLabel.text = [NSString stringWithFormat:@"有效期至%@",date];
        }
        WEAKSELF;
        [cell setOpenBlock:^{
            AddMemberPayController *addVC = [[AddMemberPayController alloc]init];
            addVC.hidesBottomBarWhenPushed = YES;
            [addVC setType:2];
            [weakSelf.navigationController pushViewController:addVC animated:YES];
            
        }];
    }
    return cell;
}

@end
