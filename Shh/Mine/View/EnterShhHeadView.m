//
//  EnterShhHeadView.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "EnterShhHeadView.h"

@implementation EnterShhHeadView

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"思和会服务平台面对企业开放，发布企业自身的所有产品与服务、信息、咨询、包括广告等内容。思和会拥有10几万家居流量，曝光量大！";
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textColor = DSColorFromHex(0x4646464);
        _contentLabel.text = @"◆  平台优势  ◆";
    }
    return _contentLabel;
}
-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"enter"];
    }
    return _rightImage;
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
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.rightImage];
        [self addSubview:self.leftline];
        [self addSubview:self.line];
        [self addSubview:self.rightline];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self);
            make.height.mas_equalTo(170);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self.rightImage.mas_bottom).offset(15);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(120);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
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
    }
    return self;
}


@end
