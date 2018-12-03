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
#import "XXInputView.h"

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
@property (weak, nonatomic) XXInputView *inputView;

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
    self.industryArr = [NSMutableArray arrayWithObjects:@"瓷砖",@"地板",@"家具",@"照明",@"橱柜",@"卫浴",@"吊顶", nil];
    self.natureArr = [NSMutableArray arrayWithObjects:@"家装公司",@"商家",@"企业",@"其他", nil];
    self.comSizeArr = [NSMutableArray arrayWithObjects:@"0-300万",@"300万-1000万",@"1000万-3000万",@"3000万-5000万",@"+1亿", nil];
    self.teamSizeArr = [NSMutableArray arrayWithObjects:@"0-30人",@"30-100人",@"100-200人",@"200人以上", nil];
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
        if (indexPath.row ==5||indexPath.row ==6||indexPath.row ==7||indexPath.row ==8) {
            cell.contentFiled.userInteractionEnabled = NO;
            if (indexPath.row ==5&&self.req.industry.length>0) {
                cell.contentFiled.text = self.req.industry;
            }else if (indexPath.row ==6&&self.req.typeid.length>0){
                cell.contentFiled.text = self.req.typeid;
            }else if (indexPath.row ==7&&self.req.companySize.length>0){
                cell.contentFiled.text = self.req.companySize;
            }else if (indexPath.row ==8&&self.req.teamSize.length>0){
                cell.contentFiled.text = self.req.teamSize;
            }
        }else{
            cell.contentFiled.userInteractionEnabled = YES;
            if (indexPath.row ==9) {
                cell.contentFiled.mode = XXPickerViewModeProvinceCity;
                self.req.location = cell.contentFiled.text;
            }
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
    if (indexPath.section ==0) {
        if (indexPath.row ==5) {
            [self.picker setCustomArr:self.industryArr];
            [self.picker setType:0];
            self.picker.hidden = NO;
        }else if (indexPath.row ==6){
            [self.picker setCustomArr:self.natureArr];
            [self.picker setType:1];
            self.picker.hidden = NO;
        }else if (indexPath.row ==7){
            [self.picker setCustomArr:self.comSizeArr];
            [self.picker setType:2];
            self.picker.hidden = NO;
        }else if (indexPath.row ==8){
            [self.picker setCustomArr:self.teamSizeArr];
            [self.picker setType:3];
            self.picker.hidden = NO;
        }
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text Type:(NSInteger)type{
    self.picker.hidden = YES;
    if (type ==0) {
        self.req.industry = text;
    }else if (type ==1){
        self.req.typeid = text;
    }else if (type ==2){
        self.req.companySize = text;
    }else if (type ==3){
        self.req.teamSize = text;
    }
    [self.tableview reloadData];
}
-(void)pressSend{
    self.req.appId = @"1041622992853962754";
    self.req.timestamp = @"0";
    self.req.platform = @"ios";
    self.req.token = [UserCacheBean share].userInfo.token;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]applyForWithParam:self.req response:^(id response) {
        if (response) {
            [weakself showInfo:response[@"message"]];
        }
    }];
}
- (XXInputView *)inputView {
    if (_inputView == nil) {
        XXInputView *inputView = [[XXInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 250) mode:XXPickerViewModeDate dataSource:nil];
        inputView.hideSeparator = YES;
        inputView.completeBlock = ^(NSString *dateString){
            
        };
        
        [self.view addSubview:inputView];
        
        self.inputView = inputView;
    }
    
    return _inputView;
}

@end
