//
//  ExceptionalController.m
//  Shh
//
//  Created by zhangshu on 2018/12/27.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ExceptionalController.h"
#import "ZSConfig.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "HomeServiceApi.h"
#import "LoginController.h"

@interface ExceptionalController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *yinView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIButton *alipayBtn;
@property(nonatomic,strong)UILabel *midLine;
@property(nonatomic,strong)UILabel *bottomLine;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *disBtn;
@property(nonatomic,strong)NSArray*dataArr;
@property(nonatomic,strong)UITextField *otherBtn;
@property(nonatomic,strong)UIButton *tmpBtn;

@end

@implementation ExceptionalController
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-150, SCREENHEIGHT/2-150, 300, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:6];
    }
    return _bgView;
}
-(UILabel *)midLine{
    if (!_midLine) {
        _midLine = [[UILabel alloc]initWithFrame:CGRectMake(150, 165, 0.5, 30)];
        _midLine.backgroundColor = DSColorFromHex(0xf0f0f0);
    }
    return _midLine;
}
-(UILabel *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 300, 0.5)];
        _bottomLine.backgroundColor = DSColorFromHex(0xf0f0f0);
    }
    return _bottomLine;
}
-(UITextField *)otherBtn{
    if (!_otherBtn) {
        _otherBtn = [[UITextField alloc]init];
        _otherBtn.textAlignment = NSTextAlignmentCenter;
        _otherBtn.placeholder = @"其他金额";
        _otherBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
        _otherBtn.font = [UIFont systemFontOfSize:13];
        _otherBtn.delegate = self;
    }
    return _otherBtn;
}
-(UIView *)yinView{
    if (!_yinView) {
        _yinView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _yinView.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinView;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
        [_wxBtn setTitle:@"微信" forState:UIControlStateNormal];
        [_wxBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _wxBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _wxBtn.frame = CGRectMake(0, 160, 150, 40);
        [_wxBtn setIconInLeftWithSpacing:15];
        [_wxBtn addTarget:self action:@selector(pressWx) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
}
-(UIButton *)disBtn{
    if (!_disBtn) {
        _disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_disBtn setImage:[UIImage imageNamed:@"dismiss"] forState:UIControlStateNormal];
        _disBtn.frame = CGRectMake(260, 0, 40, 40);
        [_disBtn addTarget:self action:@selector(pressDismiss) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _disBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"打赏红包(元)";
    }
    
    return _titleLabel;
}
-(UIButton *)alipayBtn{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alipayBtn setImage:[UIImage imageNamed:@"alipay"] forState:UIControlStateNormal];
        [_alipayBtn setTitle:@"支付宝" forState:UIControlStateNormal];
        [_alipayBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _alipayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _alipayBtn.frame = CGRectMake(150, 160, 150, 40);
        [_alipayBtn setIconInLeftWithSpacing:15];
        [_alipayBtn addTarget:self action:@selector(pressAlipay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.yinView];
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressDismiss)];
    [self.yinView addGestureRecognizer:tap];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.wxBtn];
    [self.bgView addSubview:self.alipayBtn];
    [self.bgView addSubview:self.bottomLine];
    [self.bgView addSubview:self.midLine];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.disBtn];
    [self.bgView addSubview:self.otherBtn];
    self.dataArr = @[@"8.88",@"18.88",@"28.88"];
    for (int i =0; i<3; i++) {
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = DSColorFromHex(0xDCDCDC);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:DSColorFromHex(0X464646) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(i%2*120+40, i/2*40+60, 100, 30);
        if (i == 0) {
            btn.selected = YES;
            btn.backgroundColor = DEFAULTColor;
            _tmpBtn = btn;
        }
        btn.tag = i+100;
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setCornerRadius:3];
        [self.bgView addSubview:btn];
    }
    self.otherBtn.frame = CGRectMake(160, 100, 100, 30);
    [ZSNotification addWeixinPayResultNotification:self action:@selector(weixinPay:)];
    [ZSNotification addAlipayPayResultNotification:self action:@selector(AlipayPay:)];
}
#pragma mark-支付回调通知

-(void)weixinPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"weixinpay"] isEqualToString:@"success"]) {
        [self showInfo:@"打赏成功"];
    
    }
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)AlipayPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
    if ([[userInfo objectForKey:@"strMsg"] isEqualToString:@"支付成功"]) {
        [self showInfo:@"打赏成功"];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    _tmpBtn.selected = NO;
    _tmpBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
    _tmpBtn = nil;
    self.otherBtn.backgroundColor = DEFAULTColor;
    self.otherBtn.textColor = [UIColor whiteColor];
    return YES;
}
-(void)pressDismiss{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)pressWx{
     [self.view endEditing:YES];
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    if (_tmpBtn.tag ==100) {
        req.amount = @"8.88";
    }else if (_tmpBtn.tag ==101){
       req.amount = @"18.88";
    }else if (_tmpBtn.tag ==102){
        req.amount = @"28.88";
    }else{
        req.amount = _otherBtn.text;
    }
    if ([UserCacheBean share].userInfo.token.length>0) {
        [[HomeServiceApi share]exceptionalWxPayWithParam:req response:^(id response) {
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
    }else{
        [self showInfo:@"请先登录"];
        LoginController *loginVC = [[LoginController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
-(void)pressAlipay{
     [self.view endEditing:YES];
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberId = [UserCacheBean share].userInfo.memberId;
    if (_tmpBtn.tag ==100) {
        req.amount = @"8.88";
    }else if (_tmpBtn.tag ==101){
        req.amount = @"18.88";
    }else if (_tmpBtn.tag ==102){
        req.amount = @"28.88";
    }else{
        req.amount = _otherBtn.text;
    }
    if ([UserCacheBean share].userInfo.token.length>0) {
        [[HomeServiceApi share]exceptionalAlipayWithParam:req response:^(id response) {
            if (response) {
                OrderPayRes *model = response;
                NSString *appScheme = @"ShhScheme";
                [[AlipaySDK defaultService] payOrder:model.body fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        }];
    }else{
         [self showInfo:@"请先登录"];
        LoginController *loginVC = [[LoginController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}
-(void)pressBtn:(UIButton*)sender{
    self.otherBtn.backgroundColor = DSColorFromHex(0xDCDCDC);;
    self.otherBtn.textColor = DSColorFromHex(0x464646);
    [self.view endEditing:YES];
    if (_tmpBtn == nil){
        sender.selected = YES;
        sender.backgroundColor = DEFAULTColor;
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        sender.backgroundColor = DEFAULTColor;
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        _tmpBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
        sender.selected = YES;
        sender.backgroundColor = DEFAULTColor;
        sender.backgroundColor = DEFAULTColor;
        _tmpBtn = sender;
    }
    
}
@end
