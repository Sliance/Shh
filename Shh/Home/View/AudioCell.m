//
//  AudioCell.m
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AudioCell.h"

@implementation AudioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel;
}
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
-(UIButton *)suoBtn{
    if (!_suoBtn) {
        _suoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_suoBtn setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
        [_suoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_suoBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateNormal];
        [_suoBtn setTitle:@"" forState:UIControlStateNormal];
        [_suoBtn setTitle:@"已购买" forState:UIControlStateSelected];
        _suoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _suoBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = DSColorFromHex(0x787878);
        _contentLabel.font = [UIFont systemFontOfSize:13];
    }
    return _contentLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.playBtn];
        [self addSubview:self.suoBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.lineLabel];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.suoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(10);
            make.top.equalTo(self).offset(10);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(10);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        }];
    }
    return self;
}
-(void)setModel:(CourseListModel *)model{
    _model = model;
    self.titleLabel.text = model.courseTitle;
    NSString *time = [NSString stringWithFormat:@"%.2ld:%.2ld",model.courseMediaDuration
                      /60,model.courseMediaDuration%60];
    self.contentLabel.text = [NSString stringWithFormat:@"%@/%@人学过",time,model.watch];
}
-(void)pressPlay{
    self.playBlock(self.playBtn.selected);
}
@end
