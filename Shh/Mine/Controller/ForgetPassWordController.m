//
//  ForgetPassWordController.m
//  Shh
//
//  Created by zhangshu on 2018/12/12.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ForgetPassWordController.h"
#import "MineServiceApi.h"

@interface ForgetPassWordController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UITextField *passField;
@property(nonatomic,strong)UITextField *rePassField;
@property(nonatomic,strong)UILabel *line1;
@property(nonatomic,strong)UILabel *line2;
@property(nonatomic,strong)UILabel *line3;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UIButton *submitBtn;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger count;
@end

@implementation ForgetPassWordController
-(UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]init];
        _line1.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _line1;
}
-(UILabel *)line2{
    if (!_line2) {
        _line2 = [[UILabel alloc]init];
        _line2.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _line2;
}
-(UILabel *)line3{
    if (!_line3) {
        _line3 = [[UILabel alloc]init];
        _line3.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _line3;
}
-(UITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(15, [self navHeightWithHeight], SCREENWIDTH-30, 50)];
        _phoneField.delegate = self;
        _phoneField.font = [UIFont systemFontOfSize:14];
        _phoneField.placeholder = @"请输入手机号码";
        _phoneField.textColor = DSColorFromHex(0x464646);
    }
    return _phoneField;
}
-(UITextField *)codeField{
    if (!_codeField) {
        _codeField = [[UITextField alloc]initWithFrame:CGRectMake(15, [self navHeightWithHeight]+50, SCREENWIDTH-30, 50)];
        _codeField.delegate = self;
        _codeField.font = [UIFont systemFontOfSize:14];
        _codeField.placeholder = @"请输入六位验证码";
        _codeField.textColor = DSColorFromHex(0x464646);
    }
    return _codeField;
}
-(UITextField *)passField{
    if (!_passField) {
        _passField = [[UITextField alloc]initWithFrame:CGRectMake(15, [self navHeightWithHeight]+100, SCREENWIDTH-30, 50)];
        _passField.delegate = self;
        _passField.font = [UIFont systemFontOfSize:14];
        _passField.placeholder = @"请输入新密码";
        _passField.textColor = DSColorFromHex(0x464646);
    }
    return _passField;
}
-(UITextField *)rePassField{
    if (!_rePassField) {
        _rePassField = [[UITextField alloc]initWithFrame:CGRectMake(15, [self navHeightWithHeight]+150, SCREENWIDTH-30, 50)];
        _rePassField.delegate = self;
        _rePassField.font = [UIFont systemFontOfSize:14];
        _rePassField.placeholder = @"重复输入的新密码";
        _rePassField.textColor = DSColorFromHex(0x464646);
    }
    return _rePassField;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _sendBtn.frame = CGRectMake(SCREENWIDTH-100, [self navHeightWithHeight]+60, 80, 30);
        [_sendBtn.layer setMasksToBounds:YES];
        [_sendBtn.layer setCornerRadius:2];
        [_sendBtn addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.userInteractionEnabled = NO;
    }
    return _sendBtn;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _submitBtn.frame = CGRectMake(0, [self navHeightWithHeight]+200, SCREENWIDTH, 50);
        [_submitBtn.layer setMasksToBounds:YES];
        [_submitBtn.layer setCornerRadius:2];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.userInteractionEnabled = NO;
    }
    return _submitBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.passField];
    [self.view addSubview:self.rePassField];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.sendBtn];
    [self.view addSubview:self.submitBtn];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50+[self navHeightWithHeight]);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100+[self navHeightWithHeight]);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150+[self navHeightWithHeight]);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    NSString *name = UITextFieldTextDidChangeNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChangelogin:) name:name object:nil];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];  //很远的将来
}
- (void)textFiledTextChangelogin:(NSNotification *)noti{
    if (_phoneField.text.length==11) {
        _sendBtn.backgroundColor = DSColorFromHex(0xE74A4A);
        _sendBtn.userInteractionEnabled = YES;
    }else{
        _sendBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _sendBtn.userInteractionEnabled = NO;
    }
    if (_phoneField.text.length ==11&&_codeField.text.length>0&&_passField.text.length>0&&_rePassField.text.length>0) {
        _submitBtn.backgroundColor = DSColorFromHex(0xE74A4A);
        _submitBtn.userInteractionEnabled = YES;
    }else{
        _submitBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _submitBtn.userInteractionEnabled = NO;
    }
}
- (void)dealloc {
    
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"思和会"];
        
    }
    return self;
}
-(void)pressSend{
    self.count = 60;
    [self.timer setFireDate:[NSDate distantPast]]; //很远的过去
    self.sendBtn.enabled = NO;
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.phoneField.text;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]forgetSendCodeWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            [weakself showToast:@"发送成功"];
           
        }else{
            [weakself showToast:response[@"message"]];
        }
    }];
}
-(void)pressSubmit{
    LoginReq *req = [[LoginReq alloc]init];
    req.appId = @"1041622992853962754";
    req.timestamp = @"0";
    req.platform = @"ios";
    req.memberTel = self.phoneField.text;
    req.newsPassword = self.passField.text;
    req.reNewPassword = self.rePassField.text;
    req.smsCaptchaCode = self.codeField.text;
    req.token = @"";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]forgetPasswordWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            [weakself showToast:@"修改成功"];
            
            
        }else{
            [weakself showToast:response[@"message"]];
        }
    }];
}
- (void)timeDown
{
    if (self.count != 1){
        
        self.count -=1;
        self.sendBtn.enabled = NO;
        [self.sendBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.count] forState:UIControlStateNormal];
        
    } else {
        
        self.sendBtn.enabled = YES;
        [self.sendBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
}
@end
