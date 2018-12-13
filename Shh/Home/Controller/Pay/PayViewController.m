//
//  PayViewController.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "PayViewController.h"
#import "HomeServiceApi.h"
#import "MemberShipController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AddMemberPayController.h"

@interface PayViewController ()
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *wxImage;
@property(nonatomic,strong)UILabel *wxLabel;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIImageView *alipayImage;
@property(nonatomic,strong)UILabel *alipayLabel;
@property(nonatomic,strong)UIButton *alipayBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIButton *huiBtn;
@property(nonatomic,strong)UILabel *huiLabel;
@property(nonatomic,strong)NSMutableDictionary *resultDic;



@end

@implementation PayViewController
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"logo"];
    }
    return _headImage;
}
-(UIImageView *)wxImage{
    if (!_wxImage) {
        _wxImage = [[UIImageView alloc]init];
        _wxImage.image = [UIImage imageNamed:@"pay"];
    }
    return _wxImage;
}
-(UIImageView *)alipayImage{
    if (!_alipayImage) {
        _alipayImage = [[UIImageView alloc]init];
        _alipayImage.image = [UIImage imageNamed:@"alipay"];
    }
    return _alipayImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"成功经销商的目标管理";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥0";
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = DEFAULTColor;
    }
    return _priceLabel;
}
-(UILabel *)wxLabel{
    if (!_wxLabel) {
        _wxLabel = [[UILabel alloc]init];
        _wxLabel.text = @"微信支付";
        _wxLabel.font = [UIFont systemFontOfSize:14];
        _wxLabel.textAlignment = NSTextAlignmentLeft;
        _wxLabel.textColor = [UIColor blackColor];
    }
    return _wxLabel;
}
-(UILabel *)alipayLabel{
    if (!_alipayLabel) {
        _alipayLabel = [[UILabel alloc]init];
        _alipayLabel.text = @"支付宝支付";
        _alipayLabel.font = [UIFont systemFontOfSize:14];
        _alipayLabel.textAlignment = NSTextAlignmentLeft;
        _alipayLabel.textColor = [UIColor blackColor];
    }
    return _alipayLabel;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"wx_selected"] forState:UIControlStateSelected];
        _wxBtn.selected = YES;
        [_wxBtn addTarget:self action:@selector(pressWx:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
}
-(UIButton *)alipayBtn{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alipayBtn setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"wx_selected"] forState:UIControlStateSelected];
        _alipayBtn.selected = NO;
        [_alipayBtn addTarget:self action:@selector(pressAlipay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayBtn;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = DEFAULTColor;
        [_submitBtn.layer setCornerRadius:4];
        [_submitBtn.layer setMasksToBounds:YES];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UIButton *)huiBtn{
    if (!_huiBtn) {
        _huiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_huiBtn setTitle:@"点击入会" forState:UIControlStateNormal];
        [_huiBtn setTitleColor:DEFAULTColor forState:UIControlStateNormal];
        _huiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       
        [_huiBtn addTarget:self action:@selector(pressHui) forControlEvents:UIControlEventTouchUpInside];
    }
    return _huiBtn;
}
-(UILabel *)huiLabel{
    if (!_huiLabel) {
        _huiLabel = [[UILabel alloc]init];
        _huiLabel.text = @"在线会员免费观看";
        _huiLabel.font = [UIFont systemFontOfSize:14];
        _huiLabel.textAlignment = NSTextAlignmentCenter;
        _huiLabel.textColor = DSColorFromHex(0x969696);
    }
    return _huiLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultDic = [[NSMutableDictionary alloc]init];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.wxImage];
    [self.view addSubview:self.wxLabel];
    [self.view addSubview:self.wxBtn];
    [self.view addSubview:self.alipayImage];
    [self.view addSubview:self.alipayLabel];
    [self.view addSubview:self.alipayBtn];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.huiBtn];
    [self.view addSubview:self.huiLabel];
    [self setContentLauout];
    [ZSNotification addWeixinPayResultNotification:self action:@selector(weixinPay:)];
    [ZSNotification addAlipayPayResultNotification:self action:@selector(AlipayPay:)];
}
#pragma mark-支付回调通知

-(void)weixinPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"weixinpay"] isEqualToString:@"success"]) {
        [self showInfo:@"付款成功"];
    }
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)AlipayPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)setContentLauout{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30+[self navHeightWithHeight]);
        make.centerX.equalTo(self.view);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.wxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(30);
        make.width.height.mas_equalTo(24);
    }];
    [self.wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wxImage.mas_right).offset(10);
        make.centerY.equalTo(self.wxImage);
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.wxImage);
         make.width.height.mas_equalTo(40);
    }];
    [self.alipayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.wxImage.mas_bottom).offset(20);
        make.width.height.mas_equalTo(24);
        
    }];
    [self.alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alipayImage.mas_right).offset(10);
        make.centerY.equalTo(self.alipayImage);
    }];
    [self.alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.alipayImage);
        make.width.height.mas_equalTo(40);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.view).offset(-15);
         make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.alipayImage.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    [self.huiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-100);
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    [self.huiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.huiBtn.mas_bottom).offset(0);
        
    }];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"支付";
    }
    return self;
}
-(void)setCourseId:(NSString *)courseId{
    _courseId = courseId;
    [self buyCourseData];
}
-(void)buyCourseData{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.courseId = self.courseId;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]buyCourseWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            weakself.resultDic = response[@"data"];
            weakself.priceLabel.text = [NSString stringWithFormat:@"￥%@",weakself.resultDic[@"orderRealAmount"]];
        }
    }];
}

-(void)pressWx:(UIButton*)sender{
  
    self.wxBtn.selected = YES;
    self.alipayBtn.selected = NO;
}
-(void)pressAlipay{
    self.wxBtn.selected = NO;
    self.alipayBtn.selected = YES;
}
-(void)pressSubmit{
    if (self.wxBtn.selected ==NO&&self.alipayBtn.selected == NO) {
        [self showInfo:@"请选择付款方式"];
        return;
    }
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.orderId = self.resultDic[@"orderId"];
    if (self.wxBtn.selected == YES) {
            [[HomeServiceApi share]getWxPayWithParam:req response:^(id response) {
                if(response){
                    OrderPayRes *model = response;
                    //调起微信支付
                    PayReq* req             = [[PayReq alloc] init];
                    req.partnerId           = model.partnerid;
                    req.prepayId            = model.prepayid;
                    req.nonceStr            = model.noncestr;
                    req.timeStamp           = model.timestamp.intValue;
                    req.package             = model.packagestr;
                    req.sign                = model.sign;
                    [WXApi sendReq:req];
                }
            }];
    }else if (self.alipayBtn.selected ==YES){
        [[HomeServiceApi share]getAlipayWithParam:req response:^(id response) {
            if (response) {
                OrderPayRes *model = response;
                NSString *appScheme = @"ShhScheme";
                [[AlipaySDK defaultService] payOrder:model.body fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        }];
    }

    
}
-(void)pressHui{
    AddMemberPayController*memberVC = [[AddMemberPayController alloc]init];
    [memberVC setType:1];
    [self.navigationController pushViewController:memberVC animated:YES];
}
@end
