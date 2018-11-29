//
//  LoginController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "LoginController.h"
#import "HomeController.h"
#import "BaseCourseController.h"
#import "ServiceController.h"
#import "AgreeMentController.h"
#import "MineController.h"

#import "LoginAlertView.h"
#import "MineServiceApi.h"
#import "RegisterAlertView.h"
#import "SendCodeAlertView.h"
#import "ForgetAlertView.h"
#import "ChangePassAlertView.h"

@interface LoginController ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)LoginAlertView *loginview;
@property(nonatomic,strong)RegisterAlertView *registerView;
@property(nonatomic,strong)SendCodeAlertView *codeView;
@property(nonatomic,strong)ForgetAlertView *forgetView;
@property(nonatomic,strong)ChangePassAlertView *changeView;
@property(nonatomic,strong)NSString*type;


@end

@implementation LoginController
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"icon_write"];
    }
    return _iconImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"思和会";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"中国家居行业第一学习平台";
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailLabel;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.backgroundColor = [UIColor whiteColor];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:DSColorFromHex(0xE74A4A) forState:UIControlStateNormal];
        [_loginBtn.layer setCornerRadius:2];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginBtn addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.backgroundColor = DSColorFromHex(0xE74A4A);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerBtn.layer setCornerRadius:2];
        [_registerBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_registerBtn.layer setBorderWidth:1];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerBtn addTarget:self action:@selector(pressReginster) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}
-(LoginAlertView*)loginview{
    if (!_loginview) {
       _loginview = [[LoginAlertView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _loginview.hidden = YES;
    }
    return _loginview;
}
-(RegisterAlertView *)registerView{
    if (!_registerView) {
        _registerView = [[RegisterAlertView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _registerView.hidden = YES;
    }
    return _registerView;
}
-(SendCodeAlertView *)codeView{
    if (!_codeView) {
        _codeView = [[SendCodeAlertView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _codeView.hidden = YES;
    }
    return _codeView;
}
-(ForgetAlertView *)forgetView{
    if (!_forgetView) {
        _forgetView = [[ForgetAlertView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _forgetView.hidden = YES;
    }
    return _forgetView;
}
-(ChangePassAlertView *)changeView{
    if (!_changeView) {
        _changeView = [[ChangePassAlertView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _changeView.hidden = YES;
    }
    return _changeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.loginview];
    [self.view addSubview:self.registerView];
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.forgetView];
    [self.view addSubview:self.changeView];
    
    self.iconImage.frame = CGRectMake(SCREENWIDTH/2-56/2, [self navHeightWithHeight]+91, 56, 56);
    self.titleLabel.frame = CGRectMake(0, self.iconImage.ctBottom+26, SCREENWIDTH, 19);
    self.detailLabel.frame = CGRectMake(0, self.titleLabel.ctBottom+10, SCREENWIDTH, 14);
    self.loginBtn.frame = CGRectMake(SCREENWIDTH/2-252/2, self.detailLabel.ctBottom+85, 252, 44);
    self.registerBtn.frame = CGRectMake(SCREENWIDTH/2-252/2, self.loginBtn.ctBottom+25, 252, 44);
    __weak typeof(self)weakself = self;
    [self.loginview setChooseBlock:^{
        weakself.loginview.hidden = YES;
    }];
    [self.loginview setLoginBlock:^{
        [weakself goToLogin];
    }];
    [self.loginview setForgetBlock:^{
        weakself.loginview.hidden = YES;
        weakself.forgetView.hidden = NO;
    }];
    [self.registerView setChooseBlock:^{
        weakself.registerView.hidden = YES;
    }];
    [self.registerView setLoginBlock:^{
        [weakself sendCode];
    }];
    [self.registerView setForgetBlock:^{
        AgreeMentController *agreeVC = [[AgreeMentController alloc]init];
        [weakself.navigationController pushViewController:agreeVC animated:YES];
    }];
    [self.forgetView setCloseBlock:^{
        weakself.forgetView.hidden = YES;
    }];
    [self.forgetView setGetBlock:^{
        [weakself forgetSendCode];
    }];
    [self.changeView setCloseBlock:^{
        weakself.changeView.hidden = YES;
    }];
    [self.changeView setFinishBlock:^{
        [weakself forgetPassWord];
    }];
    [self.codeView setCloseBlock:^{
        weakself.codeView.hidden = YES;
    }];
    [self.codeView setRegisterBlock:^(NSString * code) {
        if ([weakself.type isEqualToString:@"register"]) {
            [weakself toRegister:code];
        }else{
            weakself.codeView.hidden = YES;
            weakself.changeView.hidden = NO;
        }
    }];
    [self.codeView setSendBlock:^{
        if ([weakself.type isEqualToString:@"register"]) {
            [weakself sendCode];
        }else{
            [weakself forgetSendCode];
        }
    }];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = DSColorFromHex(0xE74A4A);
        self.title = @"思和会";
    }
    return self;
}
-(void)pressLogin{
    
    self.loginview.hidden = NO;
}

-(void)pressReginster{
    self.registerView.hidden = NO;
}
-(void)goToLogin{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.loginview.phoneField.text;
    req.token = @"";
    req.memberPassword = self.loginview.passWordField.text;
    [[MineServiceApi share]loginWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            NSError *error = nil;
            UserBaseInfoModel *userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:response[@"data"] error:&error];
            [UserCacheBean share].userInfo = userInfoModel;
             self.tabBarController.selectedIndex =3;
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[HomeController class]]||[controller isKindOfClass:[BaseCourseController class]]||[controller isKindOfClass:[ServiceController class]]||[controller isKindOfClass:[MineController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
           
            
        }else{
            [self showToast:response[@"message"]];
        }
    }];
}

-(void)sendCode{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.registerView.phoneField.text;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]sendCodeWithParam:req response:^(id response) {
         if ([response[@"code"]integerValue] ==200 ) {
            [self showToast:@"发送成功"];
             weakself.registerView.hidden = YES;
             weakself.type = @"register";
             weakself.codeView.hidden = NO;
             weakself.codeView.count = 60;
             weakself.codeView.detailLabel.text = [NSString stringWithFormat:@"验证码发送至%@",weakself.registerView.phoneField.text];
             [weakself.codeView.timer setFireDate:[NSDate distantPast]];
         }else{
             [self showToast:response[@"message"]];
         }
    }];
    
}
-(void)toRegister:(NSString*)code{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.registerView.phoneField.text;
    req.memberName = self.registerView.nameField.text;
    req.invitationCode = self.registerView.inviteField.text;
    req.smsCaptchaCode = code;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]registerWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            NSError *error = nil;
            UserBaseInfoModel *userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:response[@"data"] error:&error];
            [UserCacheBean share].userInfo = userInfoModel;
            weakself.tabBarController.selectedIndex =3;
            for (UIViewController *controller in weakself.navigationController.viewControllers) {
                if ([controller isKindOfClass:[HomeController class]]||[controller isKindOfClass:[BaseCourseController class]]||[controller isKindOfClass:[ServiceController class]]) {
                    [weakself.navigationController popToViewController:controller animated:YES];
                }
            }
            
            
        }else{
            [weakself showToast:response[@"message"]];
        }
    }];
    
}
-(void)forgetSendCode{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.forgetView.codeField.text;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]forgetSendCodeWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            [self showToast:@"发送成功"];
            weakself.forgetView.hidden = YES;
            weakself.codeView.hidden = NO;
            weakself.codeView.count = 60;
            weakself.codeView.detailLabel.text = [NSString stringWithFormat:@"验证码发送至%@",weakself.forgetView.codeField.text];
            [weakself.codeView.timer setFireDate:[NSDate distantPast]];
            weakself.type = @"forget";
        }else{
            [self showToast:response[@"message"]];
        }
    }];
    
}
-(void)forgetPassWord{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.forgetView.codeField.text;
    req.newsPassword = self.changeView.phoneField.text;
    req.reNewPassword = self.changeView.passWordField.text;
    req.smsCaptchaCode = self.codeView.codeField.text;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]forgetPasswordWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            [self showToast:@"修改成功"];
            weakself.changeView.hidden = YES;
            weakself.loginview.hidden = NO;
            
        }else{
            [self showToast:response[@"message"]];
        }
    }];
}
@end
