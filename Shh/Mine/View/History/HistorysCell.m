//
//  HistorysCell.m
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HistorysCell.h"

@implementation HistorysCell
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
        _titleLabel.numberOfLines =0;
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailLabel.textColor = DSColorFromHex(0x777777);
        
    }
    return _detailLabel;
}
-(UIImageView *)zanimage{
    if (!_zanimage) {
        _zanimage = [[UIImageView alloc]init];
        _zanimage.image = [UIImage imageNamed:@"dianzan"];
    }
    return _zanimage;
}
-(UIImageView *)kanimage{
    if (!_kanimage) {
        _kanimage = [[UIImageView alloc]init];
        _kanimage.image = [UIImage imageNamed:@"kan_mine"];
    }
    return _kanimage;
}
-(UILabel *)huoLabel{
    if (!_huoLabel) {
        _huoLabel = [[UILabel alloc]init];
        _huoLabel.font = [UIFont fontWithName:@"icomoon"size:12];
        _huoLabel.text = @"\U0000e90b";
        _huoLabel.textColor = DSColorFromHex(0xE70019);
    }
    return _huoLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = DSColorFromHex(0x969696);
        _countLabel.text = @"21";
    }
    return _countLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _priceLabel.textColor = DSColorFromHex(0x969696);
        _priceLabel.text = @"0";
    }
    return _priceLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headiamge];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.huoLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.kanimage];
    [self addSubview:self.zanimage];
    
    self.backgroundColor = [UIColor whiteColor];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(140);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.top.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headiamge.mas_right).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.right.equalTo(self).offset(-15);
    }];
//    [self.huoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headiamge.mas_right).offset(15);
//        make.bottom.equalTo(self.headiamge.mas_bottom).offset(-3);
//        make.width.mas_equalTo(10);
//        make.height.mas_equalTo(11);
//    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.headiamge.mas_bottom);
    }];
    [self.kanimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.priceLabel.mas_left).offset(-5);
           make.centerY.equalTo(self.priceLabel);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.kanimage.mas_left).offset(-10);
          make.centerY.equalTo(self.priceLabel);
        
    }];
    [self.zanimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.countLabel);
    }];
}

-(void)setModel:(FreeListRes *)model{
    _model = model;
    self.titleLabel.text = model.courseTitle;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.courseAppCoverImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.detailLabel.text = model.courseIntroduction;
    self.countLabel.text = model.courseTrueLikeCount;
   
        self.priceLabel.text = model.courseTrueClickCount;
}
-(void)setOrdermodel:(OrderRes *)ordermodel{
    _ordermodel = ordermodel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,ordermodel.orderAppImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = ordermodel.orderDesc;
}
-(void)setCollectModel:(CollectionRes *)collectModel{
    _collectModel = collectModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,collectModel.articleOrCourseImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = collectModel.articleOrCourseTitle;
}
-(void)setArticleModel:(TodayListRes *)articleModel{
    _articleModel = articleModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,articleModel.articleAppCoverImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = articleModel.articleTitle;
    self.priceLabel.text = articleModel.virtualReadCount;
    self.countLabel.text = articleModel.virtualLikeCount;
}
-(void)setCoursemodel:(FreeListRes *)coursemodel{
    _coursemodel = coursemodel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,coursemodel.courseAppImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = coursemodel.courseTitle;
    self.priceLabel.text = coursemodel.courseTrueClickCount;
    self.countLabel.text = coursemodel.courseTrueLikeCount;
}
@end
