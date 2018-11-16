//
//  HomeNowCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeNowCell.h"

@implementation HomeNowCell
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
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.text = @"从小白到达人，导购如何 赚的更多?";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _detailLabel.textColor = DSColorFromHex(0xB4B4B4);
        _detailLabel.text = @"导购训练  2小时前";
    }
    return _detailLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headiamge];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(140);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(5);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.bottom.equalTo(self.headiamge.mas_bottom).offset(-8);
        make.right.equalTo(self).offset(-15);
    }];
}

-(void)setModel:(TodayListRes *)model{
    _model = model;
    self.titleLabel.text = model.articleTitle;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.articleAppCoverImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    NSString *date = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"MM月dd日"];
    if (model.articleSource.length==0) {
        model.articleSource = @"导购训练";
    }
    self.detailLabel.text = [NSString stringWithFormat:@"%@  %@",model.articleSource,date];
    
}


@end
