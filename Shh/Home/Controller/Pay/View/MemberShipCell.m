//
//  MemberShipCell.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MemberShipCell.h"

@implementation MemberShipCell

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
        _titleLabel.text = @"你的名字";
    }
    return _titleLabel;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"info_friend"];
    }
    return _headImage;
}
-(UITextField *)contentFiled{
    if (!_contentFiled) {
        _contentFiled = [[UITextField alloc]init];
        _contentFiled.delegate = self;
        _contentFiled.font = [UIFont systemFontOfSize:14];
        _contentFiled.textColor = DSColorFromHex(0x464646);
        _contentFiled.textAlignment = NSTextAlignmentRight;
        _contentFiled.placeholder = @"请填写您的姓名";
        [_contentFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _contentFiled;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentFiled];
        [self addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.centerY.equalTo(self);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(18);
            make.centerY.equalTo(self);
        }];
        [self.contentFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
