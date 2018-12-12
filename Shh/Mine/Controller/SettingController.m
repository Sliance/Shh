//
//  SettingController.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SettingController.h"
#import "UserCacheBean.h"
#import "PersonInfoController.h"
#import "AboutController.h"
#import "ForgetPassWordController.h"
@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation SettingController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self creatFootView];
}

-(void)creatFootView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    footView.backgroundColor = DSColorFromHex(0xF0F0F0);
    UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    loginOutBtn.frame = CGRectMake(0, 4, SCREENWIDTH, 40);
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    loginOutBtn.backgroundColor = [UIColor whiteColor];
    [footView addSubview:loginOutBtn];
    [loginOutBtn addTarget:self action:@selector(pressLoginOut) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableFooterView = footView;
}
-(void)pressLoginOut{
   
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确认退出？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { //响应事件
        [[UserCacheBean share]loginOut];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {//响应事件
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"设置"];
      
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSArray *imagearr = @[@"info_friend",@"about_mine",@"change_pass"];
    NSArray *titleArr = @[@"个人资料",@"关于我们",@"修改密码"];
    cell.imageView.image = [UIImage imageNamed:imagearr[indexPath.row]];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        PersonInfoController *vc = [[PersonInfoController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==1) {
        AboutController *vc = [[AboutController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row ==2) {
        ForgetPassWordController *vc = [[ForgetPassWordController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
