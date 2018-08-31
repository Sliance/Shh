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

@interface ServiceController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ServiceHeadView *headview;
@property (nonatomic, strong)NavigationView *navView;

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
        _headview = [[ServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 275)];
        
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
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    return 3;
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
        return cell;
    }else if (indexPath.section ==3){
        static NSString *identify = @"ToJoinCell";
        ToJoinCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ToJoinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        return cell;
    }
    static NSString *identify = @"QualityServiceCell";
    QualityServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[QualityServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
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
