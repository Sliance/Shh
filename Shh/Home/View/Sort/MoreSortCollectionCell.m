//
//  MoreSortCollectionCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/30.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MoreSortCollectionCell.h"

@implementation MoreSortCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(SCREENWIDTH/3-15);
        }];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.text = @"行业趋势";
    }
    return _titleLabel;
}




@end
