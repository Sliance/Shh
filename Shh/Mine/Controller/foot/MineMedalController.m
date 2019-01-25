//
//  MineMedalController.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MineMedalController.h"
#import "MineMedalCell.h"
#import "MineServiceApi.h"

@interface MineMedalController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* dataArr;
@property(nonatomic,strong)NSArray* titleArr;
@property(nonatomic,strong)NSArray* detailArr;
@property(nonatomic,strong)NSArray* finishArr;
@property(nonatomic,strong)NSMutableArray* resultArr;

@end

@implementation MineMedalController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
   
    if ([UserCacheBean share].userInfo.isShow ==NO) {
       self.titleArr = @[@"身份勋章",@"评论勋章",@"分享勋章",@"点赞勋章",@"求知勋章",@"我的勋章",@"天天向上",@"专心致志",@"助人为乐",@"行动达人",@"终身学习",@"全能高手"];
       self.detailArr= @[@"完善全部个人信息",@"完成5次评论",@"完成5次分享",@"完成10次点赞",@"为知识付出1次",@"登录100次",@"连续签到超过七天",@"完成听完一堂课",@"累积推广注册5人",@"线下课程参加超过3次",@"学习时间超过100个小时",@"精品课程学习超过20个"];
    }else{
        self.titleArr = @[@"身份勋章",@"评论勋章",@"分享勋章",@"点赞勋章",@"求知勋章",@"会员勋章",@"天天向上",@"专心致志",@"助人为乐",@"行动达人",@"终身学习",@"全能高手"];
        self.detailArr= @[@"完善全部个人信息",@"完成5次评论",@"完成5次分享",@"完成10次点赞",@"为知识付费1次",@"成为思和会会员",@"连续签到超过七天",@"完成听完一堂课",@"累积推广注册5人",@"线下课程参加超过3次",@"学习时间超过100个小时",@"精品课程学习超过20个"];
    }
    
    self.finishArr = @[@"1",@"5",@"5",@"10",@"1",@"1",@"7",@"1",@"5",@"3",@"100",@"20"];
    self.resultArr = [[NSMutableArray alloc]init];
    for (int i =0; i<self.titleArr.count; i++) {
        MineMedalRes *model = [[MineMedalRes alloc]init];
        model.descriptions = self.titleArr[i];
        model.finish = 0;
        model.mission = [self.finishArr[i] integerValue];
        
        [self.resultArr addObject:model];
    }
    self.dataArr = [[NSMutableArray alloc]init];
    [self.tableview registerClass:[MineMedalCell class] forCellReuseIdentifier:NSStringFromClass([MineMedalCell class])];
    [self requestDetail];
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
    [[MineServiceApi share]getmMineMedalWithParam:req response:^(id response) {
        if (response) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            NSArray *result =  [self.dataArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.descriptions in %@",self.titleArr]];
            NSLog(@"%@",result);
            [self.resultArr enumerateObjectsUsingBlock:^(MineMedalRes *model, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.dataArr enumerateObjectsUsingBlock:^(MineMedalRes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([model.descriptions isEqualToString:obj.descriptions]) {
                        model.finish = obj.finish;
                        model.mission = obj.mission;
                        model.complete = obj.complete;
                    }
                }];
            }];
            
            [weakself.tableview reloadData];
        }
    }];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:@"我的勋章"];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMedalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineMedalCell class])];
    
    [cell.headImage setImage: [UIImage imageNamed:[NSString stringWithFormat:@"medal%ld",(long)indexPath.row]] forState:UIControlStateNormal];
    [cell.headImage setImage: [UIImage imageNamed:[NSString stringWithFormat:@"medals%ld",(long)indexPath.row]] forState:UIControlStateSelected];
    
    cell.detailLabel.text = self.detailArr[indexPath.row];
    
    MineMedalRes*model = self.resultArr[indexPath.row];
    [cell setModel:model];

    return cell;
}
@end
