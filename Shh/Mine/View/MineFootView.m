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
    [self.headView addSubview:self.hYDate];
    [self.headView addSubview:self.hYimage];
    [self.headView addSubview:self.hYtitle];
    
    NSArray *imageArr= @[@"\U0000e908",@"\U0000e924",@"\U0000e922",@"\U0000e919",@"\U0000e917",@"\U0000e900"];
    //@"\U0000e90c",@"\U0000e92a",@"\U0000e907"
    NSArray *dataArr = @[@"我的购买",@"我的收藏",@"我的关注",@"设置",@"入驻思和会",@"帮助中心"];
//    @"我的积分",@"我的勋章",
    for (int i = 0; i<6; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i%3*(SCREENWIDTH/3-10), 80+i/3*115, SCREENWIDTH/3-10, 115)];
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
        _bgView.frame = CGRectMake(15, 10, SCREENWIDTH-30, 345);
    }
    return _bgView;
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
-(UILabel *)hYDate{
    if (!_hYDate) {
        _hYDate = [[UILabel alloc]init];
        _hYDate.textAlignment = NSTextAlignmentRight;
        _hYDate.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYDate.textColor = DSColorFromHex(0x797979);
        _hYDate.text = @" >";
        _hYDate.numberOfLines = 1;
        _hYDate.frame = CGRectMake(SCREENWIDTH-30-125-30, 0, 120, 40);
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
@end
