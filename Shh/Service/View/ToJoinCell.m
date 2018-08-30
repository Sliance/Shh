//
//  ToJoinCell.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ToJoinCell.h"

@implementation ToJoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(UIImageView *)headiamge{
    if (!_headiamge) {
        _headiamge = [[UIImageView alloc]init];
        _headiamge.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _headiamge;
}
-(void)setcornerLayout{
    [self addSubview:self.headiamge];
    [self.headiamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(194);
        
        
    }];
}
@end
