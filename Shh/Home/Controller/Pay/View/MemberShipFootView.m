//
//  MemberShipFootView.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MemberShipFootView.h"

@implementation MemberShipFootView

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = DEFAULTColor;
        [_submitBtn.layer setCornerRadius:4];
        [_submitBtn.layer setMasksToBounds:YES];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x969696);
        _titleLabel.text = @"提交即默认同意相关服务条款";
    }
    return _titleLabel;
}
-(UILabel *)dianLabel{
    if (!_dianLabel) {
        _dianLabel = [[UILabel alloc]init];
        _dianLabel.textAlignment = NSTextAlignmentLeft;
        _dianLabel.font = [UIFont systemFontOfSize:14];
        _dianLabel.textColor = DEFAULTColor;
        _dianLabel.text = @"*";
    }
    return _dianLabel;
}
-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setTitle:@"阅读详情" forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_agreeBtn setTitleColor:DSColorFromHex(0x18609C) forState:UIControlStateNormal];
        [_agreeBtn addTarget:self action:@selector(pressDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.dianLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.agreeBtn];
        [self addSubview:self.submitBtn];
        [self.dianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dianLabel.mas_right).offset(2);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(50);
        }];
        [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(50);
        }];
        [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}
-(void)pressDetail{
    self.detailBlock();
}
-(void)pressSubmit{
    self.submitBlock();
}
@end
