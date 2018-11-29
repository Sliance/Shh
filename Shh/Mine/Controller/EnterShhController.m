//
//  EnterShhController.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "EnterShhController.h"
#import "EnterShhCell.h"
#import "EnterShhHeadView.h"
#import "EnterShhFootView.h"
#import "ApplyForController.h"

@interface EnterShhController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)EnterShhHeadView *headView;
@property(nonatomic,strong)EnterShhFootView *footView;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *imageArr;
@end

@implementation EnterShhController
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
-(EnterShhHeadView *)headView{
    if (!_headView) {
        _headView = [[EnterShhHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 300)];
    }
    return _headView;
}
-(EnterShhFootView *)footView{
    if (!_footView) {
        _footView = [[EnterShhFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.tableview.tableFooterView = self.footView;
    self.dataArr = @[@"思和会拥有100多万线上线下会员用户和50多万精准家居建材用户，他们活跃在思和会的各方平台，是思和会专业和精细的佐证",@"企业的产品服务、信息咨询、广告内容都可在思和会上大放异彩，思和会为您提供丰富的服务内容，入驻会有不一样的体验",@"思和会上百万的用户数据是一个大图书馆，在这里有海量的评价数据和后台统计，更精准为您的数据营销提供助力",@"思和会拥有强大的集客系统和精准的客户流量，帮助您增加曝光量与关注度。"];
    self.titleArr = @[@"1.庞大的用户群体",@"2.丰富的服务内容",@"3.海量的评价数据",@"4.先进的引流系统"];
    self.imageArr = @[@"im1",@"im2",@"im3",@"im4"];
    __weak typeof(self)weakself = self;
    [self.footView setAppBlock:^{
        ApplyForController *applyVC = [[ApplyForController alloc]init];
        [weakself.navigationController pushViewController:applyVC animated:YES];
    }];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"入驻思和会"];
    }
    return self;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"EnterShhCell";
    EnterShhCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[EnterShhCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.contentLabel.text = self.dataArr[indexPath.row];
    cell.rightImage.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    return cell;
}
@end
