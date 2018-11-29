//
//  ForgetAlertView.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ForgetAlertView.h"

@implementation ForgetAlertView

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-130, 210, 260, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:4];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, 260, 16)];
        _titleLabel.text = @"忘记密码?";
        _titleLabel.textColor = DSColorFromHex(0x363636);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(23, 120, 213, 1)];
        _line.backgroundColor = DSColorFromHex(0xE8E8E8);
    }
    return _line;
}
-(UIButton *)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        _dismissBtn.frame = CGRectMake(230, 0, 30, 30);
        [_dismissBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}
-(UITextField *)codeField{
    if (!_codeField) {
        _codeField = [[UITextField alloc]initWithFrame:CGRectMake(23, 80, 213, 40)];
        _codeField.placeholder = @"请输入手机号码";
        _codeField.font = [UIFont systemFontOfSize:14];
    }
    return _codeField;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginBtn.frame = CGRectMake(10, 150, 240, 40);
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:2];
        [_loginBtn addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.userInteractionEnabled = NO;
    }
    return _loginBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.dismissBtn];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.line];
        [self.bgView addSubview:self.codeField];
        [self.bgView addSubview:self.loginBtn];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChangeForget:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)dealloc {
    
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFiledTextChangeForget:(NSNotification *)noti{
    if (_codeField.text.length==11) {
        _loginBtn.backgroundColor = DSColorFromHex(0xE74A4A);
        _loginBtn.userInteractionEnabled = YES;
    }else{
        _loginBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _loginBtn.userInteractionEnabled = NO;
        
    }
}
-(void)quit
{
    
    self.closeBlock();
}
-(void)pressLogin{
    self.getBlock();
}
@end
