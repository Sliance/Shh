//
//  ApplyImageCell.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ApplyImageCell.h"

@implementation ApplyImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
-(UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc]init];
        _logoImage.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _logoImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.logoImage];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}
-(void)setWidth:(NSInteger)width{
    _width = width;
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-30);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(width);
    }];
    
}
@end
