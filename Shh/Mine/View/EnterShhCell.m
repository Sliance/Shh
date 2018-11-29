//
//  EnterShhCell.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "EnterShhCell.h"

@implementation EnterShhCell

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
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DSColorFromHex(0x464646);
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = DSColorFromHex(0x969696);
        _contentLabel.numberOfLines =0;
    }
    return _contentLabel;
}
-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
    }
    return _rightImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.rightImage];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(30);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-60);
            make.top.equalTo(self).offset(10);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-60);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
    }
    return self;
}
@end
