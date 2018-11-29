//
//  ChangePassAlertView.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ChangePassAlertView.h"

@implementation ChangePassAlertView


-(UIButton *)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        _dismissBtn.frame = CGRectMake(230, 0, 30, 30);
        [_dismissBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-130, 194, 260, 240)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:4];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, 260, 16)];
        _titleLabel.text = @"修改密码";
        _titleLabel.textColor = DSColorFromHex(0x363636);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginBtn.frame = CGRectMake(10, 190, 240, 40);
        [_loginBtn.layer setMasksToBounds:YES];
        [_loginBtn.layer setCornerRadius:2];
        [_loginBtn addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.userInteractionEnabled = NO;
    }
    return _loginBtn;
}
-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:DSColorFromHex(0xAFAFAF) forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _forgetBtn.frame = CGRectMake(175, 156, 70, 13);
        [_forgetBtn addTarget:self action:@selector(pressForget) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
-(UITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(23, 60, 213, 40)];
        _phoneField.placeholder = @"请输入新密码";
        _phoneField.font = [UIFont systemFontOfSize:14];
    }
    return _phoneField;
}
-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(23, 100, 213, 1)];
        _line.backgroundColor = DSColorFromHex(0xE8E8E8);
    }
    return _line;
}
-(UITextField *)passWordField{
    if (!_passWordField) {
        _passWordField = [[UITextField alloc]initWithFrame:CGRectMake(23, 104, 213, 40)];
        _passWordField.placeholder = @"重复输入的新密码";
        _passWordField.font = [UIFont systemFontOfSize:14];
    }
    return _passWordField;
}
-(UILabel *)line1{
    if (!_line1) {
        _line1 = [[UILabel alloc]initWithFrame:CGRectMake(23, 144, 213, 1)];
        _line1.backgroundColor = DSColorFromHex(0xE8E8E8);
    }
    return _line1;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.dismissBtn];
        [self.bgView addSubview:self.loginBtn];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.phoneField];
        [self.bgView addSubview:self.line];
        [self.bgView addSubview:self.passWordField];
        [self.bgView addSubview:self.line1];
//        [self.bgView addSubview:self.forgetBtn];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)dealloc {
    
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFiledTextChange:(NSNotification *)noti{
    if (_phoneField.text.length>0&&_passWordField.text.length>0) {
        _loginBtn.backgroundColor = DSColorFromHex(0xE74A4A);
        _loginBtn.userInteractionEnabled = YES;
    }else{
        _loginBtn.backgroundColor = DSColorFromHex(0xC5C5C5);
        _loginBtn.userInteractionEnabled = NO;
        
    }
}
-(void)quit{
    self.CloseBlock();
}
-(void)pressLogin{
    self.finishBlock();
}

@end
