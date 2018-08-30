//
//  HomeGivingCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeGivingCell.h"

@implementation HomeGivingCell
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
        _titleLabel.text = @"打造团队的组织体系 建立有效的分配机制";
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _detailLabel.textColor = DSColorFromHex(0x777777);
       
        [_detailLabel setText:@"打造团队的组织体系：一切的商业模式落地与战略创新都要通过 组织变革来落地， 单店公司化运营组织专业" lineSpacing:5];
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _priceLabel.textColor = DSColorFromHex(0x474747);
        _priceLabel.text = @"¥199.99";
    }
    return _priceLabel;
}
-(UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:14];

        [_shareBtn setTitle:@"\U0000e92d" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        
    }
    return _shareBtn;
}
-(UIButton *)likeBtn{
    if(!_likeBtn){
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:14];
        [_likeBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        [_likeBtn setTitle:@"\U0000e924" forState:UIControlStateNormal];
    }
    return _likeBtn;
}
-(UILabel *)shareLabel{
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc]init];
        _shareLabel.textAlignment = NSTextAlignmentRight;
        _shareLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _shareLabel.textColor = DSColorFromHex(0x777777);
        _shareLabel.text = @"656";
    }
    return _shareLabel;
}
-(UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]init];
        _likeLabel.textAlignment = NSTextAlignmentRight;
        _likeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _likeLabel.textColor = DSColorFromHex(0x777777);
        _likeLabel.text = @"2.3k";
    }
    return _likeLabel;
    
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
    [self addSubview:self.priceLabel];
    [self addSubview:self.shareBtn];
    [self addSubview:self.likeBtn];
    [self addSubview:self.shareLabel];
    [self addSubview:self.likeLabel];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
        make.height.mas_equalTo(194);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.headiamge.mas_bottom).offset(5);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(14);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeLabel.mas_left).offset(-5);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.width.height.mas_equalTo(14);
    }];
    [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeBtn.mas_left).offset(-15);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(14);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareLabel.mas_left).offset(-5);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(15);
        make.width.height.mas_equalTo(14);
    }];
    
}
@end
