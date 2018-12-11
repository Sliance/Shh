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
#import "MineServiceApi.h"
#import "GFAddressPicker.h"
#import "AddMemberPayController.h"

@interface MemberShipController ()<UITableViewDelegate,UITableViewDataSource,HQPickerViewDelegate,GFAddressPickerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)MemberShipFootView*footView;

@property(nonatomic,strong)UITextField *QQfield;
@property(nonatomic,strong)ApplyForReq *req;
@property(nonatomic,strong)HQPickerView *picker;
@property (nonatomic, strong) GFAddressPicker *pickerView;
@property(nonatomic,strong)NSMutableArray *industryArr;
@property(nonatomic,strong)NSMutableArray *natureArr;
@property(nonatomic,strong)NSMutableArray *comSizeArr;
@property(nonatomic,strong)NSMutableArray *teamSizeArr;
@property(nonatomic,strong)NSMutableArray *secretaryArr;

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
-(HQPickerView *)picker{
    if (!_picker) {
        _picker = [[HQPickerView alloc]initWithFrame:self.view.bounds];
        _picker.delegate = self;
        _picker.hidden = YES;
    }
    return _picker;
}
-(GFAddressPicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GFAddressPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [_pickerView updateAddressAtProvince:@"河南省" city:@"郑州市" town:@"金水区"];
        _pickerView.delegate = self;
        _pickerView.font = [UIFont boldSystemFontOfSize:18];
        _pickerView.hidden = YES;
    }
    return _pickerView;
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
    [self.view addSubview:self.picker];
    [self.view addSubview:self.pickerView];
     self.req = [[ApplyForReq alloc]init];
    self.tableview.tableHeaderView = self.headImage;
    self.tableview.tableFooterView = self.footView;
    self.industryArr = [NSMutableArray arrayWithObjects:@"瓷砖",@"地板",@"家具",@"照明",@"橱柜",@"卫浴",@"吊顶", nil];
    self.natureArr = [NSMutableArray arrayWithObjects:@"家装公司",@"商家",@"企业",@"其他", nil];
    self.comSizeArr = [NSMutableArray arrayWithObjects:@"0-300万",@"300万-1000万",@"1000万-3000万",@"3000万-5000万",@"+1亿", nil];
    self.teamSizeArr = [NSMutableArray arrayWithObjects:@"0-30人",@"30-100人",@"100-200人",@"200人以上", nil];
    self.secretaryArr = [NSMutableArray arrayWithObjects:@"江梦竹",@"王聪聪",@"闵雪莉",@"曹三祥",@"服务中心",@"严胜胜",@"jiang长宏",@"刘杨",@"高海云",@"刘冬梅",@"查权保",@"崔志业",@"赵东",@"刁泽旭",@"班海超",@"贾丽君",@"任玉婷",@"董雪",@"姚文正",@"程萌",@"查红芳",@"唐瑛",@"宋强",@"孙蒙恩",@"唐磊",@"陈家乐",@"周家胜",@"视频管理",@"思和咨询", nil];
    __weak typeof(self)weakself = self;
    [self.footView setDetailBlock:^{
        AgreeMentController*agreeVC = [[AgreeMentController alloc]init];
        [weakself.navigationController pushViewController:agreeVC animated:YES];
    }];
    [self.footView setSubmitBlock:^{
        [weakself submitData];
    }];
}
-(void)submitData{
    self.req.appId = @"1041622992853962754";
    self.req.timestamp = @"0";
    self.req.platform = @"ios";
    self.req.token = [UserCacheBean share].userInfo.token;
    self.req.memberAvatarId = @"";
    self.req.memberAvatarPath = @"";
    self.req.invitationCode = @"";
    self.req.version = @"1.0.0";
    self.req.systemVersion = @"0";
    self.req.secretaryMemberId = @"";
    self.req.wechatOpenId = @"";
    self.req.wechatUnionId = @"";
    self.req.parentInvitationMemberId = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]joinInWithParam:self.req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            AddMemberPayController *addVC = [[AddMemberPayController alloc]init];
            [addVC setOrderId:response[@"data"][@"orderId"]];
            [weakself.navigationController pushViewController:addVC animated:YES];
        }else{
             [weakself showInfo:response[@"message"]];
        }
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
        if (indexPath.section ==0) {
            if (self.req.memberName.length>0) {
                cell.contentFiled.text = self.req.memberName;
            }
            self.req.memberName = cell.contentFiled.text;
        }else if (indexPath.section == 1) {
            cell.headImage.image = [UIImage imageNamed:imageArr1[indexPath.row]];
            cell.titleLabel.text = titleArr1[indexPath.row];
            cell.contentFiled.placeholder = detailArr1[indexPath.row];
            if (indexPath.row ==1) {
                if (self.req.jobTitle.length>0) {
                    cell.contentFiled.text = self.req.jobTitle;
                }
                self.req.jobTitle = cell.contentFiled.text;
            }else if (indexPath.row ==2){
                if (self.req.companyName.length>0) {
                    cell.contentFiled.text = self.req.companyName;
                }
                self.req.companyName = cell.contentFiled.text;
            }else if (indexPath.row ==3){
                if (self.req.brandName.length>0) {
                    cell.contentFiled.text = self.req.brandName;
                }
                self.req.brandName = cell.contentFiled.text;
            }
        }else if (indexPath.section ==2){
            cell.headImage.image = [UIImage imageNamed:imageArr2[indexPath.row]];
             cell.titleLabel.text = titleArr2[indexPath.row];
            cell.contentFiled.placeholder = detailArr2[indexPath.row];
            if (indexPath.row ==0) {
                if (self.req.wechatNo.length>0) {
                    cell.contentFiled.text = self.req.wechatNo;
                }
                self.req.wechatNo = cell.contentFiled.text;
            }else if (indexPath.row ==1){
                if (self.req.tencentNo.length>0) {
                    cell.contentFiled.text = self.req.tencentNo;
                }
                self.req.tencentNo = cell.contentFiled.text;
            }
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
        if (indexPath.row ==0&&self.req.industryType.length>0) {
            cell.detailTextLabel.text = self.req.industryType;
        }else if (indexPath.row ==4&&self.req.companyType.length>0){
            cell.detailTextLabel.text = self.req.companyType;
        }else if (indexPath.row ==5&&self.req.companySize.length>0){
            cell.detailTextLabel.text = self.req.companySize;
        }else if (indexPath.row ==6&&self.req.teamSize.length>0){
            cell.detailTextLabel.text = self.req.teamSize;
        }else if (indexPath.row ==7&&self.req.province.length>0){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",self.req.province,self.req.city];
        }
    }else if (indexPath.section ==2){
        cell.imageView.image = [UIImage imageNamed:imageArr2[indexPath.row]];
        cell.textLabel.text = titleArr2[indexPath.row];
        cell.detailTextLabel.text = detailArr2[indexPath.row];
        if (indexPath.row ==2&&self.req.secretaryName.length>0) {
            cell.detailTextLabel.text = self.req.secretaryName;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.pickerView.hidden = YES;
    self.picker.hidden = YES;
    [self.view endEditing:YES];
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            [self.picker setCustomArr:self.industryArr];
            [self.picker setType:0];
            self.picker.hidden = NO;
        }else if (indexPath.row ==4){
            [self.picker setCustomArr:self.natureArr];
            [self.picker setType:1];
            self.picker.hidden = NO;
        }else if (indexPath.row ==5){
            [self.picker setCustomArr:self.comSizeArr];
            [self.picker setType:2];
            self.picker.hidden = NO;
        }else if (indexPath.row ==6){
            [self.picker setCustomArr:self.teamSizeArr];
            [self.picker setType:3];
            self.picker.hidden = NO;
        }else if (indexPath.row ==7){
            self.pickerView.hidden = NO;
        }
    }else if (indexPath.section ==2&&indexPath.row ==2){
        [self.picker setCustomArr:self.secretaryArr];
        [self.picker setType:4];
        self.picker.hidden = NO;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text Type:(NSInteger)type{
    self.picker.hidden = YES;
    if (type ==0) {
        self.req.industryType = text;
    }else if (type ==1){
        self.req.companyType = text;
    }else if (type ==2){
        self.req.companySize = text;
    }else if (type ==3){
        self.req.teamSize = text;
    }else if (type ==4){
        self.req.secretaryName = text;
    }
    [self.tableview reloadData];
}
- (void)GFAddressPickerCancleAction
{
    self.pickerView.hidden = YES;
}

- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area
{
    self.pickerView.hidden = YES;
    
    self.req.province = province;
    self.req.city = [NSString stringWithFormat:@"%@%@",city,area];
    [self.tableview reloadData];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
