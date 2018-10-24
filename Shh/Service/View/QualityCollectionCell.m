//
//  QualityCollectionCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/30.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "QualityCollectionCell.h"

@implementation QualityCollectionCell
-(UIImageView *)headiamge{
    if (!_headiamge) {
        _headiamge = [[UIImageView alloc]init];
        [_headiamge.layer setCornerRadius:2];
        [_headiamge.layer setMasksToBounds:YES];
        _headiamge.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _headiamge;
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
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    
    
}

-(void)setImageWidth:(NSInteger)imageWidth{
    _imageWidth = imageWidth;
}
-(void)setImageHeight:(NSInteger)imageHeight{
    _imageHeight = imageHeight;
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15/2);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(self.imageHeight);
        make.width.mas_equalTo(self.imageWidth);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.headiamge.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.headiamge.mas_bottom);
        make.height.mas_equalTo(50);
    }];
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.text = @"全案营销";
    }
    return _nameLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = DSColorFromHex(0xB4B4B4);
        _detailLabel.text = @"思和会";
    }
    return _detailLabel;
}
-(void)setModel:(ServiceListRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.siheserviceAppImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
   
}
-(void)setRecomendModel:(RecommendListRes *)recomendModel{
    _recomendModel = recomendModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,recomendModel.siheserviceAppImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
    
}

@end
