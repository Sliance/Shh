//
//  PersonInfoController.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "PersonInfoController.h"
#import "ApplyCustomCell.h"
#import "ApplyImageCell.h"
#import "HQPickerView.h"
#import "MineServiceApi.h"

#import "GFAddressPicker.h"
#import "ImageModel.h"
#import "UIImage+Resize.h"
@interface PersonInfoController ()<UITableViewDelegate,UITableViewDataSource,HQPickerViewDelegate,GFAddressPickerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UITextField *allName;
@property(nonatomic,strong)UITextField *refereeName;

@property(nonatomic,strong)UITextField *addressField;
@property(nonatomic,strong)UITextField *contactField;
@property(nonatomic,strong)UITextField *contactPhone;
@property(nonatomic,strong)UITextField *fixPhone;
@property(nonatomic,strong)HQPickerView *picker;
@property (nonatomic, strong) GFAddressPicker *pickerView;

@property(nonatomic,strong)NSMutableArray *industryArr;
@property(nonatomic,strong)NSMutableArray *natureArr;
@property(nonatomic,strong)NSMutableArray *comSizeArr;
@property(nonatomic,strong)NSMutableArray *teamSizeArr;
@property(nonatomic,assign)NSInteger ImageType;
@property(nonatomic,strong)MemberInfoRes *result;

@end

@implementation PersonInfoController

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
    
    self.industryArr = [NSMutableArray arrayWithObjects:@"瓷砖",@"地板",@"家具",@"照明",@"橱柜",@"卫浴",@"吊顶", nil];
    self.natureArr = [NSMutableArray arrayWithObjects:@"家装公司",@"商家",@"企业",@"其他", nil];
    self.comSizeArr = [NSMutableArray arrayWithObjects:@"0-300万",@"300万-1000万",@"1000万-3000万",@"3000万-5000万",@"+1亿", nil];
    self.teamSizeArr = [NSMutableArray arrayWithObjects:@"0-30人",@"30-100人",@"100-200人",@"200人以上", nil];
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
-(void)creatFootView{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    footView.backgroundColor = DSColorFromHex(0xF0F0F0);
    UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOutBtn setTitle:@"保持" forState:UIControlStateNormal];
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
        [self setTitle:@"个人资料"];
        
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&(indexPath.row ==0||indexPath.row ==1)) {
        return 60;
    }
    return 45;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return @"";
    }
    return @"";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 5)];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 5)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0&&indexPath.row ==0) {
        static NSString *identify = @"ApplyImageCell";
        ApplyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ApplyImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
            cell.titleLabel.text = @"头像";
            [cell setWidth:40];
        
                NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,self.result.memberAvatarPath];
                [cell.logoImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    

    if (indexPath.section ==0) {
        NSArray *titleArr = @[@"头像",@"姓名",@"电话",@"行业",@"职位",@"品牌名称",@"公司名称",@"企业性质",@"企业规模",@"团队规模",@"所在省市"];
        NSArray *detailArr = @[@"头像",@"姓名",@"电话",@"行业",@"职位",@"品牌名称",@"公司名称",@"企业性质",@"企业规模",@"团队规模",@"所在省市"];
        
        if (indexPath.row ==3||indexPath.row ==10||indexPath.row ==7||indexPath.row ==8||indexPath.row ==9) {
            static NSString *identify = @"UITableViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            }
            cell.textLabel.text = titleArr[indexPath.row];
            cell.detailTextLabel.text = detailArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = DSColorFromHex(0x464646);
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
            if (indexPath.row ==3) {
                if(self.result.industryType.length>0){
                    cell.detailTextLabel.text = self.result.industryType;
                }
                self.result.industryType = cell.detailTextLabel.text;
            }else if (indexPath.row ==7){
                if (self.result.companyType.length>0) {
                    cell.detailTextLabel.text = self.result.companyType;
                }
                self.result.companyType = cell.detailTextLabel.text;
            }else if (indexPath.row ==8){
                if (self.result.companySize.length>0) {
                    cell.detailTextLabel.text = self.result.companySize;
                }
                self.result.companySize = cell.detailTextLabel.text;
            }else if (indexPath.row ==9){
                if (self.result.teamSize.length>0) {
                    cell.detailTextLabel.text = self.result.teamSize;
                }
                self.result.teamSize = cell.detailTextLabel.text;
            }else if (indexPath.row ==10){
                if (self.result.province.length>0) {
                    cell.detailTextLabel.text = self.result.province;
                }
                self.result.province = cell.detailTextLabel.text;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
            
            
               }else{
                   static NSString *identify = @"ApplyCustomCell";
                   ApplyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
                   if (!cell) {
                       cell = [[ApplyCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
                   }
                   cell.titleLabel.text = titleArr[indexPath.row];
                   cell.contentFiled.placeholder = detailArr[indexPath.row];
                   cell.contentFiled.userInteractionEnabled = YES;
                   if (indexPath.row ==6) {
                       if (self.result.companyName.length>0) {
                           cell.contentFiled.text = self.result.companyName;
                       }
                       self.result.companyName = cell.contentFiled.text;
                   }else if (indexPath.row ==1){
                       if (self.result.memberName.length>0) {
                           cell.contentFiled.text = self.result.memberName;
                       }
                       self.result.memberName = cell.contentFiled.text;
                   }else if (indexPath.row ==5){
                       if (self.result.brandName.length>0) {
                           cell.contentFiled.text = self.result.brandName;
                       }
                       self.result.brandName = cell.contentFiled.text;
                   }else if (indexPath.row ==2){
                       if (self.result.memberTel.length>0) {
                           cell.contentFiled.text = self.result.memberTel;
                       }
                       self.result.memberTel = cell.contentFiled.text;
                       
                   }
                    cell.accessoryType = UITableViewCellAccessoryNone;
                   return cell;
                      
          }
                   

    }
        static NSString *identify = @"ApplyCustomCell";
        ApplyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ApplyCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        NSArray *titleArr = @[@"微信号",@"QQ号"];
        NSArray *detailArr = @[@"请填写微信号",@"请填写QQ号"];
        cell.titleLabel.text = titleArr[indexPath.row];
        cell.contentFiled.placeholder = detailArr[indexPath.row];
         cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row ==0&&indexPath.section ==1) {
            if (self.result.wechatNo.length>0) {
                cell.contentFiled.text = self.result.wechatNo;
            }
            self.result.wechatNo = cell.contentFiled.text;
        }else if (indexPath.row ==1&&indexPath.section ==1){
            if (self.result.tencentNo.length>0) {
                cell.contentFiled.text = self.result.tencentNo;
            }
           self.result.tencentNo = cell.contentFiled.text;
        }
   
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
        }else if (indexPath.row ==3) {
            [self.picker setCustomArr:self.industryArr];
            [self.picker setType:0];
            self.picker.hidden = NO;
        }else if (indexPath.row ==7){
            [self.picker setCustomArr:self.natureArr];
            [self.picker setType:1];
            self.picker.hidden = NO;
        }else if (indexPath.row ==8){
            [self.picker setCustomArr:self.comSizeArr];
            [self.picker setType:2];
            self.picker.hidden = NO;
        }else if (indexPath.row ==9){
            
            [self.picker setCustomArr:self.teamSizeArr];
            [self.picker setType:3];
            self.picker.hidden = NO;
        }else if (indexPath.row ==10){
            self.pickerView.hidden = NO;
        }
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text Type:(NSInteger)type{
    self.picker.hidden = YES;
    if (type ==0) {
        self.result.industryType = text;
    }else if (type ==1){
        self.result.companyType = text;
    }else if (type ==2){
        self.result.companySize = text;
    }else if (type ==3){
        self.result.teamSize = text;
    }
    [self.tableview reloadData];
}
-(void)pressSend{
    self.result.appId = @"1041622992853962754";
    self.result.timestamp = @"0";
    self.result.platform = @"ios";
    self.result.token = [UserCacheBean share].userInfo.token;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]changeMemberInfoWithParam:self.result response:^(id response) {
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
    
    self.result.province = [NSString stringWithFormat:@"%@%@",province,city];
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
        weakself.result.memberAvatarPath = model.fileOriginalPath;
        [weakself showInfo:@"上传成功"];
        [weakself.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself showInfo:@"上传失败"];
        
    }];
    
    
    
    
    return 0;
}

@end
