//
//  LoginController.m
//  Shh
//
//  Created by dnaer7 on 2018/11/8.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *registerBtn;
@property(nonatomic,strong)UIImageView *iconImage;
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
        
    }
    return _registerBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
    self.iconImage.frame = CGRectMake(SCREENWIDTH/2-56/2, [self navHeightWithHeight]+91, 56, 56);
    self.titleLabel.frame = CGRectMake(0, self.iconImage.ctBottom+26, SCREENWIDTH, 19);
    self.detailLabel.frame = CGRectMake(0, self.titleLabel.ctBottom+10, SCREENWIDTH, 14);
    self.loginBtn.frame = CGRectMake(SCREENWIDTH/2-252/2, self.detailLabel.ctBottom+85, 252, 44);
    self.registerBtn.frame = CGRectMake(SCREENWIDTH/2-252/2, self.loginBtn.ctBottom+25, 252, 44);
    
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = DSColorFromHex(0xE74A4A);
        self.title = @"思和会";
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
