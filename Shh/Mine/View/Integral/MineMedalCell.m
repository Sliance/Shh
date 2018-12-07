//
//  MineMedalCell.m
//  Shh
//
//  Created by zhangshu on 2018/12/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MineMedalCell.h"

@implementation MineMedalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(ZYProGressView *)progress{
    if (!_progress) {
        _progress =   [[ZYProGressView alloc]initWithFrame:CGRectMake(125 ,70, SCREENWIDTH-180, 22)];
        _progress.bottomColor = DSColorFromHex(0xE6E6E6);
        _progress.progressColor = DEFAULTColor;
        _progress.progressValue = @"0";
    }
    return _progress;
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
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

-(UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc]init];
        _integralLabel.frame = CGRectMake(SCREENWIDTH-50, 70, 50, 22);
        _integralLabel.textColor = DSColorFromHex(0x969696);
        _integralLabel.font = [UIFont systemFontOfSize:14];
        _integralLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _integralLabel;
}
-(UIButton *)headImage{
    if (!_headImage) {
        _headImage = [UIButton buttonWithType:UIButtonTypeCustom];
     
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
        [self addSubview:self.progress];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(15);
            make.top.equalTo(self).offset(15);
            
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            
        }];
       
    }
    return self;
}
-(void)setModel:(MineMedalRes *)model{
    _model = model;
    self.titleLabel.text = model.descriptions;
    self.integralLabel.text = [NSString stringWithFormat:@"%ld/%ld",model.complete,(long)model.mission];
    double progress = model.complete/model.mission;
    self.progress.progressValue = [NSString stringWithFormat:@"%f",progress];
    self.headImage.selected = model.finish;
    if (model.finish ==YES) {
        self.progress.progressValue = @"1";
        self.integralLabel.text = @"1/1";
    }
}
@end
