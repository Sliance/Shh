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
        _nameLabel.textAlignment = NSTextAlignmentLeft;
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
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setImageWidth:(NSInteger)imageWidth{
    _imageWidth = imageWidth;
}
-(void)setImageHeight:(NSInteger )imageHeight{
    _imageHeight = imageHeight;
//    if(imageHeight ==110){
//        _nameLabel.numberOfLines = 2;
//        _nameLabel.text = @"培养“搞定关键” 任务的销售能力";
//    }else{
//        _nameLabel.numberOfLines = 1;
//        _nameLabel.text = @"加入思和会";
//    }
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(self.imageWidth);
        make.height.mas_equalTo(imageHeight);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.width.mas_equalTo(self.imageWidth);
        
    }];
}

-(void)setModel:(GuessListRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.imagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.title;
}

-(void)setBottomModel:(RecommendListRes *)bottomModel{
    _bottomModel = bottomModel;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,bottomModel.siheserviceAppImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = bottomModel.siheserviceTitle;
}


@end
