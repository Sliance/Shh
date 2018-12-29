//
//  MessageListCell.m
//  Shh
//
//  Created by zhangshu on 2018/12/25.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MessageListCell.h"

@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:6];
        [_bgView.layer setBorderWidth:0.5];
        [_bgView.layer setBorderColor:DSColorFromHex(0x969696).CGColor];
    }
    return _bgView;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = DSColorFromHex(0x969696);
        _dateLabel.font = [UIFont systemFontOfSize:10];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x464646);
        _detailLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0x969696);
    }
    return _lineLabel;
}
-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_right"]];
    }
    return _rightImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.dateLabel];
        [self addSubview:self.bgView];
        [self addSubview:self.lineLabel];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.detailLabel];
        [self.bgView addSubview:self.lineLabel];
        [self.bgView addSubview:self.rightImage];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(30);
        }];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(30);
            make.height.mas_equalTo(90);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(15);
            make.top.equalTo(self.bgView).offset(10);
        }];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(5);
            make.right.equalTo(self.bgView).offset(-5);
            make.top.equalTo(self.bgView).offset(40);
            make.height.mas_equalTo(0.3);
        }];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-10);
            make.top.equalTo(self.bgView).offset(10);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(15);
            make.top.equalTo(self.lineLabel.mas_bottom).offset(10);
        }];
        
    }
    return self;
}
-(void)setModel:(MessageRes *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.content;
    NSString*date = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy-MM-dd HH:mm"];
    self.dateLabel.text = date;
}

@end
