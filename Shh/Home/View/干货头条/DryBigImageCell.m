//
//  DryBigImageCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DryBigImageCell.h"
#import "UILabel+String.h"
@implementation DryBigImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
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
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.text = @"8种常见的砍价方式！导 购要怎么应对？";
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailLabel.textColor = DSColorFromHex(0x787878);
        
        [_detailLabel setText:@"面对砍价，导购需要知道顾客 的一些心理特点，同时掌握…" lineSpacing:5];
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _priceLabel.textColor = DSColorFromHex(0x787878);
        _priceLabel.text = @"下午 1:09";
    }
    return _priceLabel;
}
-(UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:11];
        
        [_shareBtn setTitle:@"\U0000e92c" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        
    }
    return _shareBtn;
}
-(UIButton *)likeBtn{
    if(!_likeBtn){
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:8];
        [_likeBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        [_likeBtn setTitle:@"\U0000e92b" forState:UIControlStateNormal];
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
-(UIImageView *)iconiamge{
    if (!_iconiamge) {
        _iconiamge = [[UIImageView alloc]init];
        _iconiamge.image = [UIImage imageNamed:@"toutiao_icon"];
    }
    return _iconiamge;
}
-(UILabel *)iconlabel{
    if (!_iconlabel) {
        _iconlabel = [[UILabel alloc]init];
        _iconlabel.textAlignment = NSTextAlignmentLeft;
        _iconlabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _iconlabel.textColor = DSColorFromHex(0x797979);
        _iconlabel.text = @"思和会";
    }
    return _iconlabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    [self addSubview:self.iconiamge];
    [self addSubview:self.iconlabel];
    self.backgroundColor = [UIColor whiteColor];
    [self.iconiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(15);
        make.width.height.mas_equalTo(21);
    }];
    [self.iconlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconiamge.mas_right).offset(10);
        make.centerY.equalTo(self.iconiamge);
    }];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(51);
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
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
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
