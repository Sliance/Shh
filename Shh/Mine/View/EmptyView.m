//
//  EmptyView.m
//  Shh
//
//  Created by zhangshu on 2018/12/25.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "EmptyView.h"
#import "ZSConfig.h"
@implementation EmptyView

-(UIImageView *)image{
    if (!_image) {
        _image   = [[UIImageView alloc]init];
    }
    return _image;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x969696);
    }
    return _titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.image];
        [self addSubview:self.titleLabel];
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-30);
    
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.image.mas_bottom).offset(10);
            
        }];
    }
    return self;
}
@end
