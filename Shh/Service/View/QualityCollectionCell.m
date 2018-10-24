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
   
    
    
}

-(void)setImageWidth:(NSInteger)imageWidth{
    _imageWidth = imageWidth;
}
-(void)setImageHeight:(NSInteger)imageHeight{
    _imageHeight = imageHeight;
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(self.imageHeight);
        make.width.mas_equalTo(self.imageWidth);
        
    }];
}
-(void)setModel:(ServiceListRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.siheserviceAppImagePath];
    [self.headiamge sd_setImageWithURL:[NSURL URLWithString:url]];
}


@end
