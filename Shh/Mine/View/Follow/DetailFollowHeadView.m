//
//  DetailFollowHeadView.m
//  Shh
//
//  Created by zhangshu on 2018/12/5.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailFollowHeadView.h"

@implementation DetailFollowHeadView

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setCornerRadius:25];
        [_headImage.layer setMasksToBounds:YES];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x787878);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _detailLabel;
}
-(UILabel *)fouceLabel{
    if (!_fouceLabel) {
        _fouceLabel = [[UILabel alloc]init];
        _fouceLabel.textColor = DSColorFromHex(0x969696);
        _fouceLabel.font = [UIFont systemFontOfSize:14];
        _fouceLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _fouceLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel;
}
-(UIButton *)fouceBtn{
    if (!_fouceBtn) {
        _fouceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fouceBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_fouceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fouceBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_fouceBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateSelected];
        [_fouceBtn setTitle:@"已关注" forState:UIControlStateSelected];
        _fouceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_fouceBtn.layer setCornerRadius:3];
        _fouceBtn.selected = YES;
        [_fouceBtn addTarget:self action:@selector(pressFouce) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fouceBtn;
}
-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0, 225, SCREENWIDTH, 40)];
        _selectorView.delegate = self;
        
        
    }
    return _selectorView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.lineLabel];
        [self addSubview:self.fouceBtn];
        [self addSubview:self.fouceLabel];
        [self addSubview:self.selectorView];
        [self setContentLayout];
        
        [self.selectorView setCurrentPage:0];
    }
    return self;
}
-(void)setContentLayout{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headImage.mas_bottom).offset(25);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(220);
        make.height.mas_equalTo(5);
    }];
    [self.fouceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
        make.centerX.equalTo(self);
    }];
    [self.fouceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.fouceBtn.mas_bottom).offset(10);
    }];
}

-(void)setModel:(FollowRes *)model{
    if (model.companyName.length>0) {
        self.nameLabel.text = model.companyName;
        self.detailLabel.text = model.companyNameAbbr;
        NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.companyLogoPath];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_write"]];
        self.fouceLabel.text = [NSString stringWithFormat:@"%@粉丝",model.beFollowCount];
    }else{
    self.nameLabel.text = model.memberName;
    self.detailLabel.text = model.memberDesc;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.memberAvatarPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_write"]];
    self.fouceLabel.text = [NSString stringWithFormat:@"%@ 动态  |  %@粉丝",model.courseAndArticleCount,model.followCount];
    }
}
-(void)pressFouce{
    self.fouceBlock();
}
-(void)chooseButtonType:(NSInteger)type{
    self.chooseBlock(type);
}
@end
