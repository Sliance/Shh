//
//  ApplyCustomCell.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ApplyCustomCell.h"

@implementation ApplyCustomCell

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
-(UITextField *)contentFiled{
    if (!_contentFiled) {
        _contentFiled = [[UITextField alloc]init];
        _contentFiled.delegate = self;
        _contentFiled.font = [UIFont systemFontOfSize:14];
        _contentFiled.textColor = DSColorFromHex(0x464646);
    }
    return _contentFiled;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentFiled];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        [self.contentFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(100);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}


@end
