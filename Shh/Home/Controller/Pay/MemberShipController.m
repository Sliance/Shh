//
//  MemberShipController.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MemberShipController.h"
#import "HQPickerView.h"
#import "MemberShipCell.h"
#import "MemberShipFootView.h"
#import "AgreeMentController.h"

@interface MemberShipController ()<UITableViewDelegate,UITableViewDataSource,HQPickerViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)MemberShipFootView*footView;


@end

@implementation MemberShipController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 131*SCREENWIDTH/375)];
        _headImage.image = [UIImage imageNamed:@"jion"];
    }
    return _headImage;
}
-(MemberShipFootView *)footView{
    if (!_footView) {
        _footView = [[MemberShipFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 110)];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headImage;
    self.tableview.tableFooterView = self.footView;
    __weak typeof(self)weakself = self;
    [self.footView setDetailBlock:^{
        AgreeMentController*agreeVC = [[AgreeMentController alloc]init];
        [weakself.navigationController pushViewController:agreeVC animated:YES];
    }];
    [self.footView setSubmitBlock:^{
        
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"加入思和会会员";
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return 8;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return 0.01;
    }
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view = [[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1||section ==2) {
        return 0.01;
    }
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *imageArr1 = @[@"hangye_mine",@"zhiwei_mine",@"gongsi_mine",@"pinpai_mine",@"xingzhi_mine",@"team_mine",@"team_mine",@"address_mine"];
    NSArray *imageArr2 = @[@"weixin_mine",@"qq_mine",@"mishu_mine"];
    NSArray *titleArr1 = @[@"行业类型",@"职位名称",@"公司名称",@"品牌名称",@"企业性质",@"企业规模",@"团队规模",@"所在省市"];
    NSArray *titleArr2 = @[@"微信号",@"QQ号",@"小秘书"];
    NSArray *detailArr1 = @[@"请选择您的行业",@"请填写您的职位",@"请输入您的公司",@"请输入您的品牌名称",@"请选择您的企业性质",@"请选择您的企业规模",@"请选择您的团队规模",@"请选择您所在的省市"];
    NSArray *detailArr2 = @[@"请输入您的微信号",@"请输入您的QQ号",@"请选择服务小秘书"];
    if (indexPath.section ==0||(indexPath.section ==1&&(indexPath.row ==1||indexPath.row ==2||indexPath.row ==3))||(indexPath.section ==2&&(indexPath.row ==0||indexPath.row==1))) {
        static NSString *identify = @"MemberShipCell";
        MemberShipCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[MemberShipCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        
        if (indexPath.section == 1) {
            cell.headImage.image = [UIImage imageNamed:imageArr1[indexPath.row]];
            cell.titleLabel.text = titleArr1[indexPath.row];
            cell.contentFiled.placeholder = detailArr1[indexPath.row];
        }else if (indexPath.section ==2){
            cell.headImage.image = [UIImage imageNamed:imageArr2[indexPath.row]];
             cell.titleLabel.text = titleArr2[indexPath.row];
            cell.contentFiled.placeholder = detailArr2[indexPath.row];
        }
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:imageArr1[indexPath.row]];
         cell.textLabel.text = titleArr1[indexPath.row];
        cell.detailTextLabel.text = detailArr1[indexPath.row];
        
    }else if (indexPath.section ==2){
        cell.imageView.image = [UIImage imageNamed:imageArr2[indexPath.row]];
        cell.textLabel.text = titleArr2[indexPath.row];
        cell.detailTextLabel.text = detailArr2[indexPath.row];
    }
    return cell;
}

@end
