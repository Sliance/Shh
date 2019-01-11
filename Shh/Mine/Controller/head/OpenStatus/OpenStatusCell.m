//
//  OpenStatusCell.m
//  Shh
//
//  Created by zhangshu on 2019/1/11.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "OpenStatusCell.h"

@implementation OpenStatusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.image = [UIImage imageNamed:@"study_bg"];
        _bgImage.userInteractionEnabled = YES;
    }
    return _bgImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
    }
    return _titleLabel;
}
-(UILabel *)dateLabel{
     if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = DSColorFromHex(0x464646);
    }
    return _dateLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = DSColorFromHex(0x464646);
    }
    return _contentLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = DSColorFromHex(0x464646);
    }
    return _detailLabel;
}
-(UIButton *)openBtn{
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openBtn.layer setMasksToBounds:YES];
        [_openBtn.layer setCornerRadius:4];
        _openBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_openBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_openBtn addTarget:self action:@selector(pressOpen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bgImage];
        [self.bgImage addSubview:self.titleLabel];
        [self.bgImage addSubview:self.dateLabel];
        [self.bgImage addSubview:self.contentLabel];
        [self.bgImage addSubview:self.detailLabel];
        [self.bgImage addSubview:self.openBtn];
        [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(10);
            make.height.mas_equalTo(180*(SCREENWIDTH-30)/345);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImage).offset(15);
            make.right.equalTo(self.bgImage).offset(-15);
            make.bottom.equalTo(self.bgImage).offset(-15);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImage).offset(15);
            make.right.equalTo(self.bgImage).offset(-15);
            make.bottom.equalTo(self.detailLabel.mas_top).offset(-10);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImage).offset(94);
            make.right.equalTo(self.bgImage).offset(-80);
            make.top.equalTo(self.bgImage).offset(26);
        }];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImage).offset(94);
            make.right.equalTo(self.bgImage).offset(-80);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
        [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgImage).offset(-16);
            make.top.equalTo(self.bgImage).offset(33);
            make.width.mas_equalTo(64);
            make.height.mas_equalTo(26);
        }];
    }
    return self;
}

-(void)pressOpen{
    self.openBlock();
}

@end
