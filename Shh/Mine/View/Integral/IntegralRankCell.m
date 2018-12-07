//
//  IntegralRankCell.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "IntegralRankCell.h"

@implementation IntegralRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x464646);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

-(UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc]init];
        _integralLabel.textColor = DSColorFromHex(0x464646);
        _integralLabel.font = [UIFont systemFontOfSize:14];
        _integralLabel.textAlignment = NSTextAlignmentRight;
    }
    return _integralLabel;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setCornerRadius:20];
        [_headImage.layer setMasksToBounds:YES];
    }
    return _headImage;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.integralLabel];
        [self addSubview:self.headImage];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.centerY.equalTo(self);
            
        }];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(40);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(10);
            make.centerY.equalTo(self).offset(0);
            
        }];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            
        }];
    }
    return self;
}
-(void)setModel:(IntegralRes *)model{
    _model = model;
    self.titleLabel.text = model.rank;
    self.detailLabel.text = model.memberName;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.memberAvatarPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine"]];
    self.integralLabel.text = model.integral;
}
@end
