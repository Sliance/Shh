//
//  EnterShhFootView.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "EnterShhFootView.h"

@implementation EnterShhFootView

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = DSColorFromHex(0x4646464);
        _contentLabel.text = @"◆  平台支持  ◆";
    }
    return _contentLabel;
}

-(UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _line;
}
-(UILabel *)leftline{
    if (!_leftline) {
        _leftline = [[UILabel alloc]init];
        _leftline.backgroundColor = DSColorFromHex(0x464646);
    }
    return _leftline;
}
-(UILabel *)rightline{
    if (!_rightline) {
        _rightline = [[UILabel alloc]init];
        _rightline.backgroundColor = DSColorFromHex(0x464646);
    }
    return _rightline;
}
-(UIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyBtn setTitle:@"申请入驻" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_applyBtn.layer setCornerRadius:4];
        [_applyBtn.layer setMasksToBounds:YES];
        _applyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _applyBtn.backgroundColor =DSColorFromHex(0xE74A4A);
        [_applyBtn addTarget:self action:@selector(pressApply) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.contentLabel];
       
        [self addSubview:self.leftline];
        [self addSubview:self.line];
        [self addSubview:self.rightline];
        [self addSubview:self.applyBtn];
        [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.bottom.right.equalTo(self).offset(-15);
            make.height.mas_equalTo(40);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(120);
            make.top.equalTo(self).offset(15);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(5);
        }];
        [self.leftline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentLabel.mas_left);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(60);
            make.centerY.equalTo(self.contentLabel);
        }];
        [self.rightline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel.mas_right);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(60);
            make.centerY.equalTo(self.contentLabel);
        }];
        NSArray *imageArr = @[@"qunzu",@"jifenbaoshi",@"hezuo"];
       
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
            [btn setTitle:@"用户资源" forState:UIControlStateNormal];
            btn.frame = CGRectMake(20+(SCREENWIDTH/3-80/3+20)*i,50, SCREENWIDTH/3-80/3, 60);
           
            [btn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
             [btn setIconInTopWithSpacing:10];
            [self addSubview:btn];
            UILabel *label = [[UILabel alloc]init];
            label.text = @"亿万精准用户资源共享";
            label.font = [UIFont systemFontOfSize:12];
            label.frame = CGRectMake(20+(SCREENWIDTH/3-80/3+20)*i,btn.ctBottom, SCREENWIDTH/3-80/3, 30);
            label.textColor = DSColorFromHex(0x969696);
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            [self addSubview:label];
        }
    }
    return self;
}
-(void)pressApply{
    self.appBlock();
}

@end
