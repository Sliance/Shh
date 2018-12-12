//
//  SendCodeAlertView.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SendCodeAlertView.h"

@implementation SendCodeAlertView

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
        _titleLabel.text = @"输入验证码";
        _titleLabel.textColor = DSColorFromHex(0x363636);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 73, 260, 16)];
        _detailLabel.text = @"验证码发送至";
        _detailLabel.textColor = DSColorFromHex(0x969696);
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:14];
    }
    return _detailLabel;
}
-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]initWithFrame:CGRectMake(23, 230, 213, 1)];
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
        _codeField = [[UITextField alloc]initWithFrame:CGRectMake(80, 190, 100, 40)];
        _codeField.placeholder = @"请输入六位验证码";
        _codeField.font = [UIFont systemFontOfSize:12];
    }
    return _codeField;
}
-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeBtn setTitle:@"60" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_sendCodeBtn addTarget:self action:@selector(pressCode:) forControlEvents:UIControlEventTouchUpInside];
        [_sendCodeBtn.layer setCornerRadius:4];
        [_sendCodeBtn.layer setMasksToBounds:YES];
        [_sendCodeBtn.layer setBorderColor:DSColorFromHex(0x969696).CGColor];
        [_sendCodeBtn.layer setBorderWidth:0.5];
        _sendCodeBtn.frame = CGRectMake(100, 140, 60, 25);
    }
    return _sendCodeBtn;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.dismissBtn];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.line];
        [self.bgView addSubview:self.codeField];
        [self.bgView addSubview:self.detailLabel];
        [self.bgView addSubview:self.sendCodeBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChangeCode:) name:UITextFieldTextDidChangeNotification object:nil];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        self.count = 60;
    }
    return self;
}
- (void)dealloc {
    
    //移除观察者 self
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textFiledTextChangeCode:(NSNotification *)noti{
    if(_codeField.text.length==6) {
        self.registerBlock(_codeField.text);
    }
}
-(void)quit
{
    
    self.closeBlock();
}
-(void)pressCode:(UIButton*)sender{
    
    self.count = 60;
    self.sendCodeBtn.enabled = NO;
    // 加1个定时器
    self.sendBlock();
}
- (void)timeDown
{
    if (self.count != 1){
        
        self.count -=1;
        self.sendCodeBtn.enabled = NO;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld", (long)self.count] forState:UIControlStateNormal];
        
    } else {
        
        self.sendCodeBtn.enabled = YES;
        [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
}
@end
