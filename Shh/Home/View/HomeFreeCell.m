//
//  HomeFreeCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeFreeCell.h"

@implementation HomeFreeCell
-(UIImageView *)headiamge{
    if (!_headiamge) {
        _headiamge = [[UIImageView alloc]init];
        _headiamge.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _headiamge;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailLabel.textColor = DSColorFromHex(0x777777);
        
    }
    return _detailLabel;
}
-(UILabel *)huoLabel{
    if (!_huoLabel) {
        _huoLabel = [[UILabel alloc]init];
        _huoLabel.font = [UIFont fontWithName:@"icomoon"size:12];
        _huoLabel.text = @"\U0000e90b";
        _huoLabel.textColor = DSColorFromHex(0xE70019);
    }
    return _huoLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = DSColorFromHex(0xE70019);
        _countLabel.text = @"21万";
    }
    return _countLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _priceLabel.textColor = DSColorFromHex(0x474747);
        _priceLabel.text = @"￥0";
    }
    return _priceLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headiamge];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.huoLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.priceLabel];
    self.backgroundColor = [UIColor whiteColor];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(140);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
         make.right.equalTo(self).offset(-15);
    }];
    [self.huoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.bottom.equalTo(self.headiamge.mas_bottom).offset(-3);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(11);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.huoLabel.mas_right).offset(8);
        make.bottom.equalTo(self.headiamge.mas_bottom);
        
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.headiamge.mas_bottom);
    }];
    
}

-(void)setModel:(FreeListRes *)model{
    _model = model;
    self.titleLabel.text = model.courseTitle;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.courseAppCoverImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.detailLabel.text = model.courseIntroduction;
    self.countLabel.text = model.courseTrueClickCount;
   
        if (model.courseIsTimelimitFree ==YES) {
            self.priceLabel.text = @"￥0";
        }else{
         self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.coursePrice];
        }
}





@end
