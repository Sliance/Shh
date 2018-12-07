//
//  IntegralCell.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "IntegralCell.h"

@implementation IntegralCell

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
        _detailLabel.textColor = DSColorFromHex(0x969696);
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

-(UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc]init];
        _integralLabel.textColor = [UIColor greenColor];
        _integralLabel.font = [UIFont systemFontOfSize:14];
        _integralLabel.textAlignment = NSTextAlignmentRight;
    }
    return _integralLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self addSubview:self.integralLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
            
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            
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
    self.titleLabel.text = model.content;
    self.detailLabel.text = model.systemCreateTime;
    self.integralLabel.text = model.integral;
    
}



@end
