//
//  HomeLikeCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeLikeCell.h"

@implementation HomeLikeCell
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        
    }
    return _nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
    }
    return self;
}
-(void)setImageHeight:(NSInteger )imageHeight{
    _imageHeight = imageHeight;
    if(imageHeight ==110){
        _nameLabel.numberOfLines = 2;
        _nameLabel.text = @"培养“搞定关键” 任务的销售能力";
    }else{
        _nameLabel.numberOfLines = 1;
        _nameLabel.text = @"加入思和会";
    }
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(imageHeight);
        make.height.mas_equalTo(110);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.width.mas_equalTo(imageHeight);
        
    }];
}
@end
