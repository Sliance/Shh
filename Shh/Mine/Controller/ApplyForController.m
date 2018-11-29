//
//  ApplyForController.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ApplyForController.h"
#import "ApplyCustomCell.h"
#import "ApplyImageCell.h"
#import "HQPickerView.h"
#import "MineServiceApi.h"

@interface ApplyForController ()<UITableViewDelegate,UITableViewDataSource,HQPickerViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITextField *allName;
@property(nonatomic,strong)UITextField *refereeName;
@property(nonatomic,strong)UITextField *brandName;
@property(nonatomic,strong)UITextField *addressField;
@property(nonatomic,strong)UITextField *contactField;
@property(nonatomic,strong)UITextField *contactPhone;
@property(nonatomic,strong)UITextField *fixPhone;
@property(nonatomic,strong)HQPickerView *picker;
@property(nonatomic,strong)ApplyForReq *req;
@property(nonatomic,strong)NSMutableArray *industryArr;
@property(nonatomic,strong)NSMutableArray *natureArr;
@property(nonatomic,strong)NSMutableArray *comSizeArr;
@property(nonatomic,strong)NSMutableArray *teamSizeArr;

@end

@implementation ApplyForController
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
-(HQPickerView *)picker{
    if (!_picker) {
        _picker = [[HQPickerView alloc]initWithFrame:self.view.bounds];
        _picker.delegate = self;
        _picker.hidden = YES;
    }
    return _picker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.picker];
    [self creatFootView];
    self.req = [[ApplyForReq alloc]init];
}

-(void)creatFootView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    footView.backgroundColor = DSColorFromHex(0xF0F0F0);
    UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    loginOutBtn.frame = CGRectMake(15, 4, SCREENWIDTH-30, 40);
    [loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginOutBtn.layer setCornerRadius:4];
    [loginOutBtn.layer setMasksToBounds:YES];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    loginOutBtn.backgroundColor =DSColorFromHex(0xE74A4A);
    [footView addSubview:loginOutBtn];
    [loginOutBtn addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.tableFooterView = footView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"申请入驻"];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 11;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&(indexPath.row ==0||indexPath.row ==1)) {
        return 60;
    }
    return 45;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return @"企业信息";
    }
    return @"联系人信息";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return 0.01;
    }
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view = [[UIView alloc]init];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&(indexPath.row ==0||indexPath.row ==1)) {
        static NSString *identify = @"ApplyImageCell";
        ApplyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ApplyImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        if (indexPath.row ==0) {
            cell.titleLabel.text = @"企业logo:";
            [cell setWidth:40];
        }else if (indexPath.row ==1){
            cell.titleLabel.text = @"营业执照：";
            [cell setWidth:60];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    static NSString *identify = @"ApplyCustomCell";
    ApplyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[ApplyCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        NSArray *titleArr = @[@"企业logo:",@"营业执照：",@"企业全称：",@"企业简称：",@"品牌名称：",@"公司行业：",@"企业性质：",@"企业规模：",@"团队规模：",@"所在省市：",@"地址："];
         NSArray *detailArr = @[@"请选择",@"请选择：",@"请填写企业全称",@"请填写企业简称",@"请填写品牌名称（选填）",@"请选择您的行业（选填）",@"请选择您的企业性质（选填）",@"请选择您的企业规模（选填）",@"请选择您的团队规模（选填）",@"请选择您所在省市",@"请填写公司地址"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.contentFiled.placeholder = detailArr[indexPath.row];
        if (indexPath.row ==5||indexPath.row ==6||indexPath.row ==7||indexPath.row ==8||indexPath.row ==9) {
            cell.contentFiled.userInteractionEnabled = NO;
        }else{
            cell.contentFiled.userInteractionEnabled = YES;
        }
    }else{
        NSArray *titleArr = @[@"联系人：",@"联系电话：",@"固定电话："];
        NSArray *detailArr = @[@"请填写联系人",@"请填写联系电话",@"请填写固定电话（选填）"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.contentFiled.placeholder = detailArr[indexPath.row];
    }

    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text {
    
}
-(void)pressSend{
    
}


@end
