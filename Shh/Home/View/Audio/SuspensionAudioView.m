//
//  SuspensionAudioView.m
//  Shh
//
//  Created by zhangshu on 2018/12/10.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SuspensionAudioView.h"

@implementation SuspensionAudioView

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = DSColorFromHex(0x969696);
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.text = @"00:00";
    }
    return _dateLabel;
}
-(UIImageView *)bannerImage{
    if (!_bannerImage) {
        _bannerImage = [[UIImageView alloc]init];
        _bannerImage.userInteractionEnabled = YES;
    }
    return _bannerImage;
}
-(UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"play_audio"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"stop_aduio"] forState:UIControlStateSelected];
        [_playBtn addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
-(UIButton *)nameBtn{
    if (!_nameBtn) {
        _nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nameBtn.frame = CGRectMake(90, 40, SCREENWIDTH-170, 20);
        [_nameBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [_nameBtn addTarget:self action:@selector(pressDetail) forControlEvents:UIControlEventTouchUpInside];
        [_nameBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _nameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bannerImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.nameBtn];
        [self.bannerImage  addSubview:self.playBtn];
        [self.bannerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.height.mas_equalTo(80);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bannerImage.mas_right).offset(10);
            make.right.equalTo(self).offset(-70);
            make.top.equalTo(self).offset(10);
        }];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(10);
        }];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bannerImage);
            make.centerY.equalTo(self.bannerImage);
        }];
    }
    return self;
}
-(void)setDetailCourse:(DetailCourseRes *)detailCourse{
    _detailCourse = detailCourse;
    NSString *bannerurl = [NSString stringWithFormat:@"%@%@",DPHOST,detailCourse.course.courseAppImagePath];
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:bannerurl]];
    [self.nameBtn setTitle:detailCourse.member.memberName forState:UIControlStateNormal];
}
-(void)setModel:(CourseListModel *)model{
    _model = model;
    self.nameLabel.text = model.courseTitle;
    [self.nameBtn setIconInRightWithSpacing:SCREENWIDTH-230];
}
-(void)pressPlay{
    self.playBlock(self.playBtn.selected);
}
-(void)pressDetail{
    
    self.detailBlock();
}


@end
