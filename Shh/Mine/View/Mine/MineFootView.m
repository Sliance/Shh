//
//  MineFootView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineFootView.h"
#import "MineTypeBtn.h"

@implementation MineFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headView];
    [self addSubview:self.midView];
    [self.headView addSubview:self.hYDate];
    [self.headView addSubview:self.hYimage];
    [self.headView addSubview:self.hYtitle];
    [self.midView addSubview:self.yanImage];
    [self.midView addSubview:self.zongImage];
    [self.midView addSubview:self.yanLabel];
    [self.midView addSubview:self.zongLabel];
    [self.midView addSubview:self.yanright];
    [self.midView addSubview:self.zongright];
    NSArray *imageArr= @[@"\U0000e908",@"\U0000e90c",@"\U0000e92a",@"\U0000e924",@"\U0000e922",@"\U0000e919",@"\U0000e917",@"\U0000e900"];
    //@"\U0000e907"
    NSArray *dataArr = @[@"我的购买",@"我的积分",@"我的勋章",@"我的收藏",@"我的关注",@"设置",@"入驻思和会",@"帮助中心"];

    for (int i = 0; i<imageArr.count; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i%3*(SCREENWIDTH/3-10), 70+i/3*88, SCREENWIDTH/3-10, 88)];
        btn.imageLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageLabel.textColor = DSColorFromHex(0x464646);
        btn.typeLabel.textColor = DSColorFromHex(0x777777);
        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }
    
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:8];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.frame = CGRectMake(15, 100, SCREENWIDTH-30, 345);
    }
    return _bgView;
}
-(UIView *)midView{
    if (!_midView) {
        _midView = [[UIView alloc]init];
        _midView.backgroundColor = [UIColor whiteColor];
        [_midView.layer setCornerRadius:8];
        [_midView.layer setMasksToBounds:YES];
        _midView.frame = CGRectMake(15, 10, SCREENWIDTH-30, 80);
    }
    return _midView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = DSColorFromHex(0xFAFAFA);
        [_headView.layer setCornerRadius:20];
        [_headView.layer setMasksToBounds:YES];
        _headView.frame = CGRectMake(13, 10, SCREENWIDTH-30-26, 40);
        _headView.userInteractionEnabled = YES;
    }
    return _headView;
}
-(UILabel *)hYimage{
    if (!_hYimage) {
        _hYimage = [[UILabel alloc]init];
        _hYimage.font = [UIFont fontWithName:@"icomoon"size:20];
        _hYimage.text = @"\U0000e923";
        _hYimage.textColor = DSColorFromHex(0x787878);
        _hYimage.frame = CGRectMake(18, 10, 19, 19);
    }
    return _hYimage;
}
-(UILabel *)hYtitle{
    if (!_hYtitle) {
        _hYtitle = [[UILabel alloc]init];
        _hYtitle.textAlignment = NSTextAlignmentLeft;
        _hYtitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYtitle.textColor = DSColorFromHex(0x797979);
        _hYtitle.text = @"邀请好友加入";
        _hYtitle.numberOfLines = 1;
        _hYtitle.frame = CGRectMake(47, 0, 80, 40);
    }
    return _hYtitle;
}
-(UIImageView *)yanImage{
    if (!_yanImage) {
        _yanImage = [[UIImageView alloc]init];
        _yanImage.image = [UIImage imageNamed:@"xueye_mine"];
        _yanImage.frame = CGRectMake(30, 16, 15, 11);
    }
    return _yanImage;
}
-(UIImageView *)zongImage{
    if (!_zongImage) {
        _zongImage = [[UIImageView alloc]init];
        _zongImage.image = [UIImage imageNamed:@"xueye_mine"];
        _zongImage.frame = CGRectMake(30, 56, 15, 11);
    }
    return _zongImage;
}
-(UILabel *)yanLabel{
    if (!_yanLabel) {
        _yanLabel = [[UILabel alloc]init];
        _yanLabel.textAlignment = NSTextAlignmentLeft;
        _yanLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _yanLabel.textColor = DSColorFromHex(0x797979);
        _yanLabel.text = @"加入研习社";
        _yanLabel.numberOfLines = 1;
        _yanLabel.frame = CGRectMake(60, 10, 80, 22);
    }
    return _yanLabel;
}
-(UILabel *)zongLabel{
    if (!_zongLabel) {
        _zongLabel = [[UILabel alloc]init];
        _zongLabel.textAlignment = NSTextAlignmentLeft;
        _zongLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _zongLabel.textColor = DSColorFromHex(0x797979);
        _zongLabel.text = @"加入总裁班";
        _zongLabel.numberOfLines = 1;
        _zongLabel.frame = CGRectMake(60, 50, 80, 22);
    }
    return _zongLabel;
}
-(UIButton *)yanright{
    if (!_yanright) {
        _yanright = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yanright setTitleColor:DEFAULTColor forState:UIControlStateNormal];
        _yanright.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [_yanright setImage:[UIImage imageNamed:@"yan_right"] forState:UIControlStateNormal];
//        [_yanright setTitle:@"信息有待完善" forState:UIControlStateNormal];
        _yanright.frame = CGRectMake(SCREENWIDTH-30-80-30, 0, 80, 40);
        [_yanright setIconInRightWithSpacing:80];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressYan)];
        [_yanright addGestureRecognizer:tap];
    }
    return _yanright;
}
-(UIButton *)zongright{
    if (!_zongright) {
        _zongright =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_zongright setTitleColor:DEFAULTColor forState:UIControlStateNormal];
        _zongright.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        [_zongright setImage:[UIImage imageNamed:@"yan_right"] forState:UIControlStateNormal];
        _zongright.frame = CGRectMake(SCREENWIDTH-30-80-30, 40, 80, 40);
        [_zongright setIconInRightWithSpacing:80];
        _zongright.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressZong)];
        [_zongright addGestureRecognizer:tap];
    }
    return _zongright;
}
-(UILabel *)hYDate{
    if (!_hYDate) {
        _hYDate = [[UILabel alloc]init];
        _hYDate.textAlignment = NSTextAlignmentRight;
        _hYDate.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYDate.textColor = DSColorFromHex(0x797979);
        _hYDate.text = @" >";
        _hYDate.numberOfLines = 1;
        _hYDate.frame = CGRectMake(SCREENWIDTH-30-125-30, 0, 110, 40);
        _hYDate.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
        [_hYDate addGestureRecognizer:tap];
    }
    return _hYDate;
}
-(void)pressBtn:(MineTypeBtn*)sender{
    self.selecteBlock(sender.tag);
}
-(void)pressTap{
    self.tapBlock();
}
-(void)pressYan{
    self.selecteBlock(100);
}
-(void)pressZong{
    self.selecteBlock(101);
}
@end
