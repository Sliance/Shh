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
        [_playBtn setTitle:@"视频" forState:UIControlStateNormal];
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _playBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
        
        [_playBtn addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
-(UIButton *)suoBtn{
    if (!_suoBtn) {
        _suoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_suoBtn setTitle:@"音频" forState:UIControlStateSelected];
        _suoBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
        _suoBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_suoBtn addTarget:self action:@selector(pressAudio) forControlEvents:UIControlEventTouchUpInside];
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
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.width.mas_equalTo(SCREENWIDTH-110);
            make.top.equalTo(self).offset(10);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        }];

        self.suoBtn.frame = CGRectMake(SCREENWIDTH-55, 20, 40, 20);
        self.playBtn.frame = CGRectMake(SCREENWIDTH-96, 20, 40, 20);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_playBtn.bounds      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft    cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _playBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _playBtn.layer.mask = maskLayer;
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:_suoBtn.bounds      byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight    cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = _suoBtn.bounds;
        maskLayer1.path = maskPath1.CGPath;
        _suoBtn.layer.mask = maskLayer1;
    }
    return self;
}
-(void)setModel:(CourseListModel *)model{
    _model = model;
    self.titleLabel.text = model.courseTitle;
    NSString *time = [NSString stringWithFormat:@"%.2ld:%.2ld",model.courseMediaDuration
                      /60,model.courseMediaDuration%60];
    self.contentLabel.text = [NSString stringWithFormat:@"%@/%@人学过",time,model.watch];
    self.suoBtn.selected = model.memberIsBuyThisCourse;
    if (model.courseMediaPath.length>0) {
        self.playBtn.backgroundColor = DEFAULTColor;
        self.playBtn.enabled = YES;
    }else{
        self.playBtn.enabled = NO;
        self.playBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    if (model.courseAudioPath.length>0) {
        self.suoBtn.backgroundColor = DEFAULTColor;
        self.suoBtn.enabled = YES;
    }else{
        self.suoBtn.enabled = NO;
        self.suoBtn.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
}
-(void)pressPlay{
    self.playBlock(self.playBtn.selected);
}
-(void)pressAudio{
    self.audioBlock(self.suoBtn.selected);
}
@end
