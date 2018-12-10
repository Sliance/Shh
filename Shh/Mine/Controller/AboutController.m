//
//  AboutController.m
//  Shh
//
//  Created by zhangshu on 2018/12/10.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *wxLabel;
@property(nonatomic,strong)UILabel *wxDetailLabel;
@property(nonatomic,strong)UILabel *emailLabel;
@property(nonatomic,strong)UILabel *emailDLabel;
@end

@implementation AboutController
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"logo"];
        
    }
    return _headImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"100万家居人的学习平台";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x969696);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)wxLabel{
    if (!_wxLabel) {
        _wxLabel = [[UILabel alloc]init];
        _wxLabel.text = @"官方微信号";
        _wxLabel.font = [UIFont systemFontOfSize:16];
        _wxLabel.textColor = DSColorFromHex(0x464646);
        _wxLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _wxLabel;
}
-(UILabel *)wxDetailLabel{
    if (!_wxDetailLabel) {
        _wxDetailLabel = [[UILabel alloc]init];
        _wxDetailLabel.text = @"jiaju_yuan";
        _wxDetailLabel.font = [UIFont systemFontOfSize:14];
        _wxDetailLabel.textColor = DSColorFromHex(0x969696);
        _wxDetailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _wxDetailLabel;
}
-(UILabel *)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [[UILabel alloc]init];
        _emailLabel.text = @"E-mail";
        _emailLabel.font = [UIFont systemFontOfSize:16];
        _emailLabel.textColor = DSColorFromHex(0x464646);
        _emailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _emailLabel;
}
-(UILabel *)emailDLabel{
    if (!_emailDLabel) {
        _emailDLabel = [[UILabel alloc]init];
        _emailDLabel.text = @"3520739634@qq.com";
        _emailDLabel.font = [UIFont systemFontOfSize:14];
        _emailDLabel.textColor = DSColorFromHex(0x969696);
        _emailDLabel.textAlignment = NSTextAlignmentRight;
    }
    return _emailDLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headImage];
     [self.view addSubview:self.titleLabel];
     [self.view addSubview:self.wxLabel];
     [self.view addSubview:self.wxDetailLabel];
     [self.view addSubview:self.emailLabel];
     [self.view addSubview:self.emailDLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([self navHeightWithHeight]+30);
        make.centerX.equalTo(self.view);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    [self.wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(15);
        
    }];
    [self.wxDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-15);
        
    }];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxLabel.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(15);
        
    }];
    [self.emailDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxLabel.mas_bottom).offset(30);
        make.right.equalTo(self.view).offset(-15);
        
    }];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setTitle:@"思和会"];
        
    }
    return self;
}

@end
