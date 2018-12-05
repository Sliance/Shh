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

#import "GFAddressPicker.h"
#import "ImageModel.h"
#import "UIImage+Resize.h"

@interface ApplyForController ()<UITableViewDelegate,UITableViewDataSource,HQPickerViewDelegate,GFAddressPickerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITextField *allName;
@property(nonatomic,strong)UITextField *refereeName;

@property(nonatomic,strong)UITextField *addressField;
@property(nonatomic,strong)UITextField *contactField;
@property(nonatomic,strong)UITextField *contactPhone;
@property(nonatomic,strong)UITextField *fixPhone;
@property(nonatomic,strong)HQPickerView *picker;
@property (nonatomic, strong) GFAddressPicker *pickerView;
@property(nonatomic,strong)ApplyForReq *req;
@property(nonatomic,strong)NSMutableArray *industryArr;
@property(nonatomic,strong)NSMutableArray *natureArr;
@property(nonatomic,strong)NSMutableArray *comSizeArr;
@property(nonatomic,strong)NSMutableArray *teamSizeArr;
@property(nonatomic,assign)NSInteger ImageType;

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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.picker];
    [self.view addSubview:self.pickerView];
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
            if (self.req.companyLogoPath.length>0) {
                NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,self.req.companyLogoPath];
                [cell.logoImage sd_setImageWithURL:[NSURL URLWithString:url]];
            }
        }else if (indexPath.row ==1){
            cell.titleLabel.text = @"营业执照：";
            [cell setWidth:60];
            if (self.req.businessLicensePath.length>0) {
                NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,self.req.businessLicensePath];
                [cell.logoImage sd_setImageWithURL:[NSURL URLWithString:url]];
            }
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
         NSArray *detailArr = @[@"请选择",@"请选择：",@"请填写企业全称",@"请填写企业简称",@"请填写品牌名称(选填)",@"请选择您的行业(选填)",@"请选择您的企业性质(选填)",@"请选择您的企业规模(选填)",@"请选择您的团队规模(选填)",@"请选择您所在省市",@"请填写公司地址"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.contentFiled.placeholder = detailArr[indexPath.row];
        if (indexPath.row ==5||indexPath.row ==6||indexPath.row ==7||indexPath.row ==8||indexPath.row ==9) {
            cell.contentFiled.userInteractionEnabled = NO;
            if (indexPath.row ==5) {
                if (self.req.industry.length>0) {
                     cell.contentFiled.text = self.req.industry;
                }
                self.req.industry = cell.contentFiled.text;
            }else if (indexPath.row ==6){
                if (self.req.typeid.length>0) {
                    cell.contentFiled.text = self.req.typeid;
                }
                self.req.typeid = cell.contentFiled.text;
            }else if (indexPath.row ==7){
                if (self.req.companySize.length>0) {
                    cell.contentFiled.text = self.req.companySize;
                }
                self.req.companySize = cell.contentFiled.text;
            }else if (indexPath.row ==8){
                if (self.req.teamSize.length>0) {
                    cell.contentFiled.text = self.req.teamSize;
                }
                self.req.teamSize = cell.contentFiled.text;
            }else if (indexPath.row ==9){
                if (self.req.location.length>0) {
                    cell.contentFiled.text = self.req.location;
                }
                self.req.location = cell.contentFiled.text;
            }
        }else{
            cell.contentFiled.userInteractionEnabled = YES;
            if (indexPath.row ==2) {
                if (self.req.companyName.length>0) {
                    cell.contentFiled.text = self.req.companyName;
                }
                self.req.companyName = cell.contentFiled.text;
            }else if (indexPath.row ==3){
                if (self.req.companyNameAbbr.length>0) {
                    cell.contentFiled.text = self.req.companyNameAbbr;
                }
                self.req.companyNameAbbr = cell.contentFiled.text;
            }else if (indexPath.row ==4){
                if (self.req.brandName.length>0) {
                    cell.contentFiled.text = self.req.brandName;
                }
                self.req.brandName = cell.contentFiled.text;
            }else if (indexPath.row ==10){
                if (self.req.address.length>0) {
                    cell.contentFiled.text = self.req.address;
                }
                self.req.address = cell.contentFiled.text;
                
            }
        }
    }else{
        NSArray *titleArr = @[@"联系人：",@"联系电话：",@"固定电话："];
        NSArray *detailArr = @[@"请填写联系人",@"请填写联系电话",@"请填写固定电话（选填）"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.contentFiled.placeholder = detailArr[indexPath.row];
        if (indexPath.row ==0) {
            if (self.req.contact.length>0) {
                cell.contentFiled.text = self.req.contact;
            }
            self.req.contact = cell.contentFiled.text;
        }else if (indexPath.row ==1){
            if (self.req.phoneNumber.length>0) {
                cell.contentFiled.text = self.req.phoneNumber;
            }
            self.req.phoneNumber = cell.contentFiled.text;
        }else if (indexPath.row ==2){
            if (self.req.telephoneNumber.length>0) {
                cell.contentFiled.text = self.req.telephoneNumber;
            }
            self.req.telephoneNumber = cell.contentFiled.text;
        }
    }

    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.pickerView.hidden = YES;
    self.picker.hidden = YES;
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            UIActionSheet *leftAction = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄照片", @"选择手机中的照片", nil];
            leftAction.tag = 101;
            [leftAction showInView:self.view];
            self.ImageType = 0;
        }else if (indexPath.row ==1){
            UIActionSheet *leftAction = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄照片", @"选择手机中的照片", nil];
            leftAction.tag = 102;
            [leftAction showInView:self.view];
            self.ImageType =1;
        }else if (indexPath.row ==5) {
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
        }else if (indexPath.row ==9){
            self.pickerView.hidden = NO;
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
- (void)GFAddressPickerCancleAction
{
    self.pickerView.hidden = YES;
}

- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area
{
    self.pickerView.hidden = YES;
    
    self.req.location = [NSString stringWithFormat:@"%@  %@  %@",province,city,area];
    [self.tableview reloadData];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    if (buttonIndex == 0) {
        [self takePhotoWithTag];
    }  else if(buttonIndex == 1) {
        [self localPhotoWithTag];
    }
}

//处理图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationMedium];
    //
    [self sendImageRequest:image];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
//手机拍照
-(void)takePhotoWithTag
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 获取图库
-(void)localPhotoWithTag
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - HTTPRequest
- (NSInteger)sendImageRequest:(UIImage *)image
{
    BaseModelReq *req = [[BaseModelReq alloc]init];
    req.token = @"";
    req.appId = @"997303469549645826";
    req.platform = @"ios";
    req.timestamp = @"0";
    __weak typeof(self)weakself = self;
    NSDictionary * body = @{@"category":@"user",@"file":@"HeadImg"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //ContentType设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,upload_photo_url];
    [manager POST:url parameters:[req mj_keyValues] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 上传 多张图片
                NSData *pictureData = UIImageJPEGRepresentation(image, 1.0);
                
                [formData appendPartWithFileData:pictureData name:@"file" fileName: @"multipartFiles.jpeg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功的block回调
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *result = [ImageModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        ImageModel*model = [result firstObject];
        if (weakself.ImageType==0) {
            weakself.req.companyLogoId = model.fileId;
            weakself.req.companyLogoPath = model.fileOriginalPath;
        }else if (weakself.ImageType ==1){
            weakself.req.businessLicenseId = model.fileId;
            weakself.req.businessLicensePath = model.fileOriginalPath;
        }
        [weakself showInfo:@"上传成功"];
        [weakself.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself showInfo:@"上传失败"];
        
    }];
    
    

    
    return 0;
}
@end
