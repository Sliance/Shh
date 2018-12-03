//
//  MineHeadView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineHeadView.h"
#import "MineTypeBtn.h"


@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xFAFAFA);
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    [self addSubview:self.bgImage];
    [self addSubview:self.bgView];
    [self addSubview:self.headImage];
    [self.bgView addSubview:self.hYView];
    [self.hYView addSubview:self.hYimage];
    [self.hYView addSubview:self.hYtitle];
    [self.hYView addSubview:self.hYDate];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.editBtn];
    [self.bgImage addSubview:self.messageBtn];
    [self.bgImage addSubview:self.serviceBtn];
    
    NSArray *imageArr= @[@"\U0000e916",@"\U0000e913",@"\U0000e927"];
    NSArray *dataArr = @[@"签到",@"历史",@"下载"];
    for (int i = 0; i<3; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i*(SCREENWIDTH/3-10), 70, SCREENWIDTH/3-10, 80)];
        btn.imageLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageLabel.textColor = DSColorFromHex(0x464646);
        btn.typeLabel.textColor = DSColorFromHex(0x464646);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }

    self.editBtn.frame = CGRectMake(SCREENWIDTH/2-65, 46, 100, 15);
   
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.image = [UIImage imageNamed:@"bg_mine"];
        _bgImage.frame = CGRectMake(0, 0, SCREENWIDTH, 250);
        _bgImage.userInteractionEnabled = YES;
    }
    return _bgImage;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:8];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.frame = CGRectMake(15, 85, SCREENWIDTH-30, 200);
    }
    return _bgView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"mine"];
        _headImage.frame = CGRectMake(SCREENWIDTH/2-37, 48, 74, 74);
        [_headImage.layer setCornerRadius:37];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_headImage.layer setBorderWidth:0.5];
        _headImage.userInteractionEnabled = YES;
    }
    return _headImage;
}
-(UIView *)hYView{
    if (!_hYView) {
        _hYView = [[UIView alloc]init];
        _hYView.backgroundColor = DSColorFromHex(0xCDB59C);
        _hYView.frame = CGRectMake(0, 165, SCREENWIDTH-30, 200);
        _hYView.userInteractionEnabled = YES;
    }
    return _hYView;
}
-(UILabel *)hYimage{
    if (!_hYimage) {
        _hYimage = [[UILabel alloc]init];
        _hYimage.font = [UIFont fontWithName:@"icomoon"size:16];
        _hYimage.text = @"\U0000e92e";
        _hYimage.textColor = DSColorFromHex(0x52402C);
        _hYimage.frame = CGRectMake(15, 9, 21, 16);
    }
    return _hYimage;
}
-(UILabel *)hYtitle{
    if (!_hYtitle) {
        _hYtitle = [[UILabel alloc]init];
        _hYtitle.textAlignment = NSTextAlignmentLeft;
        _hYtitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYtitle.textColor = DSColorFromHex(0x52402C);
        _hYtitle.text = @"思和会会员";
        _hYtitle.numberOfLines = 1;
        _hYtitle.frame = CGRectMake(52, 0, 80, 35);
    }
    return _hYtitle;
}
-(UILabel *)hYDate{
    if (!_hYDate) {
        _hYDate = [[UILabel alloc]init];
        _hYDate.textAlignment = NSTextAlignmentRight;
        _hYDate.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYDate.textColor = DSColorFromHex(0x52402C);
        _hYDate.text = @"加入会员 >";
        _hYDate.numberOfLines = 1;
        _hYDate.frame = CGRectMake(SCREENWIDTH-30-105, 0, 100, 35);
        _hYDate.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
        [_hYDate addGestureRecognizer:tap];
    }
    return _hYDate;
}
-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"未登录" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_editBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setTitle:@"\U0000e928" forState:UIControlStateNormal];
        _messageBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        [_messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _messageBtn.frame = CGRectMake(0, 20, 58, 54);
        [_messageBtn addTarget:self action:@selector(pressMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}
-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn setTitle:@"\U0000e90f" forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:27];
        [_serviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _serviceBtn.frame = CGRectMake(SCREENWIDTH-23-15, 36, 23, 23);
    }
    return _serviceBtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        _nameLabel.textColor = DSColorFromHex(0x454545);
        _nameLabel.text = @"唐瑛";
    }
    return _nameLabel;
}
-(void)pressBtn:(MineTypeBtn*)sender{
    if (sender.tag==0) {
        sender.imageLabel.textColor = DSColorFromHex(0x969696);
        sender.typeLabel.text =@"已签到";
    }else{
        self.typeBlock(sender.tag);
    }
}
-(void)pressMessage:(UIButton*)sender{
    self.messageBlock();
}
-(void)pressEdit{
    self.editBlock();
}

-(void)pressTap{
    self.addBlock();
}
@end
